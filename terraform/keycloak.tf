
resource "azurerm_container_app" "auth" {
  name                         = "shotyourpet-auth-containerapp"
  container_app_environment_id = azurerm_container_app_environment.shotyourpet.id
  resource_group_name          = azurerm_resource_group.shotyourpet.name
  revision_mode                = "Single"

  depends_on = [
    azurerm_container_app.rabbit
  ]

  ingress {
    allow_insecure_connections = false
    external_enabled           = true
    target_port                = 8080
    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }

  template {
    container {
      name    = "auth"
      image   = "ghcr.io/shot-your-pet/auth:main"
      cpu     = 0.25
      memory  = "0.5Gi"
      command = ["start-dev", "--import-realm"]

      env {
        name  = "KEYCLOAK_ADMIN"
        value = "admin"
      }

      env {
        name  = "KEYCLOAK_ADMIN_PASSWORD"
        value = "thisisanadminpassword"
      }

      env {
        name  = "KC_EVENTS_LISTENERS"
        value = "shot_your_pet_event_listener,email"
      }

      env {
        name  = "JAVA_OPTS_APPEND"
        value = "-Drabbitmq.host=rabbit -Drabbitmq.port=5672 -Drabbitmq.username=guest -Drabbitmq.password=guest"
      }
    }
  }
}
