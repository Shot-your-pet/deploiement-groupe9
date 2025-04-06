package fr.miage.syp.provider;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.rabbitmq.client.Channel;
import com.rabbitmq.client.Connection;
import com.rabbitmq.client.ConnectionFactory;
import org.keycloak.events.Event;
import org.keycloak.events.EventListenerProvider;
import org.keycloak.events.admin.AdminEvent;

import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;

public class ShotYourPetEventListenerProvider implements EventListenerProvider {

    private final static String QUEUE_NAME = "keycloak.keycloak_events";
    private Connection connection;
    private Channel channel;
    private ObjectMapper mapper = new ObjectMapper();

    // Initialisation de la connexion RabbitMQ avec des paramètres configurables
    public ShotYourPetEventListenerProvider() {
        try {
            ConnectionFactory factory = new ConnectionFactory();

            // Récupération des paramètres depuis les propriétés système avec des valeurs par défaut
            String rabbitHost = System.getProperty("rabbitmq.host", "localhost");
            String rabbitPort = System.getProperty("rabbitmq.port", "5672");
            String rabbitUser = System.getProperty("rabbitmq.username", "guest");
            String rabbitPass = System.getProperty("rabbitmq.password", "guest");

            factory.setHost(rabbitHost);
            factory.setPort(Integer.parseInt(rabbitPort));
            factory.setUsername(rabbitUser);
            factory.setPassword(rabbitPass);

            connection = factory.newConnection();
            channel = connection.createChannel();

            // Déclaration de la file (durable, non exclusive, non auto-suppression)
            channel.queueDeclare(QUEUE_NAME, true, false, false, null);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void onEvent(Event event) {
        sendEventToRabbitMQ(event);
    }

    @Override
    public void onEvent(AdminEvent adminEvent, boolean includeRepresentation) {
        sendEventToRabbitMQ(adminEvent);
    }

    private void sendEventToRabbitMQ(Object event) {
        Map<String, Object> payload = new HashMap<>();

        if (event instanceof Event) {
            Event userEvent = (Event) event;
            payload.put("eventType", userEvent.getType().toString());
            payload.put("userId", userEvent.getUserId());
            payload.put("realmId", userEvent.getRealmId());
            payload.put("clientId", userEvent.getClientId());
            payload.put("sessionId", userEvent.getSessionId());
            payload.put("ipAddress", userEvent.getIpAddress());
            payload.put("error", userEvent.getError());
            payload.put("details", userEvent.getDetails());
        } else if (event instanceof AdminEvent) {
            AdminEvent adminEvent = (AdminEvent) event;
            payload.put("operationType", adminEvent.getOperationType().toString());
            payload.put("resourceType", adminEvent.getResourceType().name());
            payload.put("resourcePath", adminEvent.getResourcePath());
            if (adminEvent.getRepresentation() != null) {
                payload.put("representation", adminEvent.getRepresentation());
            }
        }

        try {
            String message = mapper.writeValueAsString(payload);
            channel.basicPublish("", QUEUE_NAME, null, message.getBytes(StandardCharsets.UTF_8));
            System.out.println("Message envoyé à RabbitMQ de type: " + event.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void close() {
        try {
            if (channel != null) {
                channel.close();
            }
            if (connection != null) {
                connection.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
