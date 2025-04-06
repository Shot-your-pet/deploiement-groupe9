Feature: API Testing for Shot Your Pet
  Background:
    * url 'http://localhost:8080/api'
    * def challengeId = null
    * def authToken =
      """
      function() {
        var response = karate.callSingle('classpath:auth-keycloak.feature');
        return response.token;
      }
      """

  Scenario: Get timeline
    Given path '/timeline'
    And header Authorization = 'Bearer ' + authToken
    When method GET
    Then status 200
    And match response == '#notnull'

  Scenario: Get user profile
    Given path '/profile'
    And header Authorization = 'Bearer ' + authToken
    When method GET
    Then status 200
    And match response contains { id: '#number', username: '#string' }

  Scenario: Upload an image
    Given path '/images/upload'
    And header Authorization = 'Bearer ' + authToken
    And multipart file image = { read: 'classpath:images/exemple_chat.jpg', filename: 'exemple_chat.jpg', contentType: 'image/jpeg' }
    When method POST
    Then status 201
    And match response contains { imageUrl: '#string' }

  Scenario: Subscribe to notifications
    Given path '/notifications/subscribe'
    And header Authorization = 'Bearer ' + authToken
    And request { userId: 123 }
    When method POST
    Then status 200
    And match response contains { success: true }

  Scenario: Add a new challenge
    Given path '/challenges'
    And header Authorization = 'Bearer ' + authToken
    And request { title: 'New Challenge', description: 'This is a new challenge.' }
    When method POST
    Then status 201
    And match response contains { id: '#number', title: 'New Challenge' }
    * def challengeId = response.id

  Scenario: Get the created challenge
    Given path '/challenges/' + challengeId
    And header Authorization = 'Bearer ' + authToken
    When method GET
    Then status 200
    And match response contains { id: challengeId, title: 'New Challenge' }

  Scenario: Update the created challenge
    Given path '/challenges/' + challengeId
    And header Authorization = 'Bearer ' + authToken
    And request { title: 'Updated Challenge', description: 'Updated description.' }
    When method PUT
    Then status 200
    And match response contains { id: challengeId, title: 'Updated Challenge' }

  Scenario: Get all challenges
    Given path '/challenges'
    And header Authorization = 'Bearer ' + authToken
    When method GET
    Then status 200
    And match response == '#[0]'

  Scenario: Delete the created challenge
    Given path '/challenges/' + challengeId
    And header Authorization = 'Bearer ' + authToken
    When method DELETE
    Then status 200