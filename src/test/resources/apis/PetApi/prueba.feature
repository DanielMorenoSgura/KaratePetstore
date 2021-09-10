Feature: Curso de Karate


Background:
# cometario esta variable viene del karate-config.js
* url baseUrl
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
Given url baseUrl
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

Scenario: compare files
    Given path 'pet'
    * def myPetJson = read('test-data/payload.json')
    * def mypetYml = read('test-data/payload.yml')
    * match myPetJson == mypetYml
    * assert myPetJson == mypetYml

Scenario Outline: dynamic files
    Given path 'pet'
    * def myCategory = {"id":1,"name":#(category)}
    * def myPet = read()
    And request myPet
    When method post
    Then status 200
    
   Examples:
   | id | name  | category | status    |
   | 1  | dog   | one      | available |
   | 2  | cat   | two      | available |
   | 3  | bird  | three    | sold      |

Scenario Outline: Add new pet <id> <name> <category> <status>
    Given path 'pet'
    * def myPet = 
    """
    {
      "id": '#(id)',
      "name": #(name),
      "category": {
        "id": 1,
        "name": '#(category)'
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
      "status": #(status)
    }
    """
    * print myPet
    Given request myPet
    When method POST
    Then assert responseStatus == 200
    * print response
    
    Examples:
    | id | name  | category | status    |
    | 1  | dog   | one      | available |
    | 2  | cat   | two      | available |
    | 3  | bird  | three    | sold      |
    




