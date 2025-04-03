Feature: API Testing for Shot Your Pet Mockoon

  Background:
    * url 'http://localhost/api'

  Scenario: Get timeline
    Given path '/timeline'
    When method GET
    Then status 200
    And match response == '#notnull'

  Scenario: Get user profile
    Given path '/profile'
    When method GET
    Then status 200
    And match response contains { id: '#number', username: '#string' }

  Scenario: Upload an image
    Given path '/images/upload'
    And multipart file image = { read: 'sample.jpg', filename: 'sample.jpg', contentType: 'image/jpeg' }
    When method POST
    Then status 201
    And match response contains { imageUrl: '#string' }

  Scenario: Subscribe to notifications
    Given path '/notifications/subscribe'
    And request { userId: 123 }
    When method POST
    Then status 200
    And match response contains { success: true }

  Scenario: Add a new challenge
    Given path '/challenges'
    And request { title: 'New Challenge', description: 'This is a new challenge.' }
    When method POST
    Then status 201
    And match response contains { id: '#number', title: 'New Challenge' }

  Scenario: Update a challenge
    Given path '/challenges/1'
    And request { title: 'Updated Challenge', description: 'Updated description.' }
    When method PUT
    Then status 200
    And match response contains { id: 1, title: 'Updated Challenge' }

  Scenario: Get all challenges
    Given path '/challenges'
    When method GET
    Then status 200
    And match response == '#[0]'

  Scenario: Delete a challenge
    Given path '/challenges/1'
    When method DELETE
    Then status 204
