Feature:  Parameters examples

  Background:
    * def baseUrl = 'https://petstore.swagger.io/v2/store'
    * def spartanUrl = 'http://18.233.164.111:8000/'
    * def hrUrl = 'http://52.207.61.129:1000/ords/hr'


  Scenario: path parameters
    Given url baseUrl
    And path "inventory"
    When method get
    Then status 200


  Scenario: get all spartans with path
    Given url spartanUrl
    And path "api/spartans"
    When method get
    Then status 200
    And print response


  Scenario: get ones spartan only
    Given url spartanUrl
    And path "api/spartans"
    And path "3"
    When method get
    Then status 200
    And print response
    And match response == {"gender": "Male","phone": 6105035231,"name": "Fidole","id": 3}


  Scenario: get ones spartan only

    * def expectedSpartan =
  """
  {"gender": "Male",
  "phone": 6105035231,
  "name": "Fidole",
  "id": 3}
}
    """

    Given url spartanUrl
    And path "api/spartans"
    And path "3"
    When method get
    Then status 200
    And print response
    And match response == expectedSpartan


  Scenario:  query parameters
    Given url spartanUrl
    And path "api/spartans/search"
    And param nameContains = 'j'
    And param gender = 'Female'
    When method GET
    Then status 200
    And match header Content-Type == 'application/json'
    And print response
      #verify each content has gender = Female
    And match each response.content contains {"gender":"Female"}
      #second way of iteration
    And match each response.content[*].gender == 'Female'
    And match response.content[0].name == 'Jeanelle'
      #verify each content phone is number
    And match each response.content[*].phone == '#number'



  Scenario: hr regions example
    Given url hrUrl
    And path 'regions'
    When method GET
    Then status 200
    And print response
    And match response.limit == 25
    And match each response.items[*].region_id == '#number'

