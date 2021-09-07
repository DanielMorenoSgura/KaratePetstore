Feature: Curso de Karate


Background:
# cometario esta variable viene del karate-config.js
* url miVariableUrl
* def myPet = 
"""
    {
  "id": 10,
  "name": "doggie",
  "category": {
    "id": 1,
    "name": "Dogs"
  },
  "photoUrls": [
    "string"
  ],
  "tags": [
    {
      "id": 0,
      "name": "string"
    }
  ],
  "status": "available"
}
"""

Scenario: Find Pets by Status
Given url miVariableUrl
And path 'pet', 'findByStatus'
And param status = 'availableXXX'
When method GET
Then assert responseStatus == 400
* print response

Scenario: Find Pets by Tags
Given url 'https://petstore3.swagger.io/api/v3/pet/findByTags?tags=one'
When method GET
* print response

Scenario: Add new Pet
Given path 'pet'
* print myPet
Given request myPet
When method post
Then assert responseStatus == 200
* print response


