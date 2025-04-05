import com.intuit.karate.junit5.Karate;

public class KarateRunnerTest {
    @Karate.Test
    Karate testAll() {
        return Karate.run("classpath:auth-keycloak.feature", "classpath:test-ti-endpoints.feature").relativeTo(getClass());
    }
}
