Feature: Validation

Background:
    * url baseUrl

@ignore @operation
Scenario: getPetById
* def req = {"params": {"petId": 0 }}
* def authHeader = call read('classpath:karate-auth.js') req.auth
* def headers = karate.merge(req.headers || {}, authHeader || {})
Given path '/pet/', req.params.petId
And headers headers
When method GET
* print response


@ignore @operation
Scenario: getPetById

* def req = {"params": { "petId": 0 }}
* def authHeader = call read('classpath:karate-auth.js') req.auth
* def headers = karate.merge(req.headers || {}, authHeader || {})
Given path '/pet/', req.params.petId
And headers headers
When method GET
* print response
* def expected = 
"""
  {
  "id": '#number',
  "category": {
    "id": '#number',
    "name": "#string"
  },
  "name": "#present",
  "photoUrls": [
    "#string"
  ],
  "tags": [
    {
      "id":'#number',
      "name": "#string"
    }
  ],
  "status": "available"
}
"""
* match response contains deep expected
