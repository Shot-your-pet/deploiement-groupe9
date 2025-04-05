Feature: Keycloak Authentication

  Scenario: Get auth token
    Given url 'http://192.168.1.130:9001/realms/ShotYourPet/protocol/openid-connect/token'
    And form field grant_type = 'password'
    And form field client_id = 'shotyourpet'
    And form field username = 'user'
    And form field password = 'user'
    And form field scope = 'offline_access'
    When method POST
    Then status 200
    * def token = response.access_token