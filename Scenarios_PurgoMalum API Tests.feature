Feature: Profanity Filter API
As a user of the profanity filter API
I want to add my own banned words
So that they can be censored in the response

Background:
Given I am able to access the service

  Scenario Outline: Validate response format as per the endpoint
    Given the API is available at "<endpoint>"
    When I request to filter the text as "You are an ass"
    Then the response status should be 200
    And the response should be in expected format "<format>"
  Examples: 
  |endpoint | format           |
  | /json   | application/json |
  | /xml    | application/xml  |
  | /plain  | text/plain       |


Scenario Outline: Detect profanity in a given text
    Given the API is available at "<endpoint>"
    When I request to filter the text "You are a test idiot"
    Then the response status should be 200
    And Check for profanity is detected and filtered with default character "*" as "You are an ***"
  Examples: 
  |endpoint | 
  | /json   | 	
  | /xml    | 
  | /plain  | 

Scenario Outline: Adding custom words to the profanity filter
  Given the API is available at "/json"
  When I request to filter the text "<input_text>"
  And I add "<custom_words>" to the list of banned words
  Then the response should be successful with status 200
  And the filtered response should replace "<expected_word>" with "<expected_replacement>"
Examples:
  | input_text                    | custom_words | expected_word  | expected_replacement          |
  | This is a dumb example        | dumb         | dumb           | This is a **** example        |
  | This is a lame and stupid one | lame,stupid  | lame           | This is a **** and ****** one |                 
  | You are a 123 idiot           | 123,idiot    | 123 idiot      | You are a *** ****            |                 
  | You are a bad_ugly            | bad_ugly     | bad_ugly       | You are a ********            |
  | You are a bad                 | BAD          | bad            | You are a ***                 |

  
Scenario Outline: Custom words adding limit to the profanity list
  Given the API is available at "/json"
  When I attempt to add "<num_words>" words to the banned list
  Then the API response should show "<error_message>"
  And the response status should be 200

Examples:
  | num_words | error_message                              |
  | 11        | User Black List Exceeds Limit of 10 Words. |
  | 10        | No error message                           |
  | 9         | No error message 			   |

Scenario: JSON API allows Custom words can be 200 maximum characters in length 
  Given the API is available at "/json"
  When I attempt to add maximum 200 characters in length to the banned list
  Then the API response should show error message as "User Black List Exceeds Limit of 10 Words"
  And the response status should be 200


Scenario: XML API Custom words can be 200 maximum characters in length 
  Given the API is available at "/xml"
  When I attempt to add maximum 200 characters in length to the banned list
  Then the API response should show error message as "User Black List Exceeds Limit of 10 Words"
  And the response status should be 200


Scenario: Plain API Custom words can be 200 maximum characters in length 
  Given the API is available at "/plain"
  When I attempt to add maximum 200 characters in length to the banned list
  Then the API response should show error message as "User Black List Exceeds Limit of 10 Words"
  And the response status should be 200


 Scenario Outline: Replace the added profanities with custom text in JSON
    Given I have the API endpoint "/json"
    When I request to filter the text "<input_text>"
    And I add "<custom_words>" and replacement text as "<fill_text>" to the list of banned words
    Then the response should be successful with status 200
    And the filtered response should replace "<expected_word>" with "<fill_text>" as  "You are a [] example"
Examples:
  | input_text                    | custom_words | expected_word  | fill_text              |  
  | This is a dumb example        | dumb         | dumb           |   123                  |
  | This is a lame and stupid one | lame,stupid  | lame stupid    |    _                   |                 
  | You are a 123 idiot           | 123,idiot    | 123 idiot      |    ~                   |                 
  | You are a bad_ugly            | bad_ugly     | bad_ugly       |    !                   |
  | You are a bad                 | bad          | bad            |    =                   |
  | You are a bad                 | bad          | bad            |    -                   |
  | You are a bad                 | bad          | bad            |    |                   |
  | You are a bad                 | bad          | bad            |    '                   |
  | You are a bad                 | bad          | bad            |    "                   |
  | You are a bad                 | bad          | bad            |    {}    		   |
  | You are a bad                 | bad          | bad            |    []  	           |
  | You are a bad                 | bad          | bad            |    ()    		   |
  | You are a bad                 | bad          | this is curiously long replacement text | Max Length 20 characters |



 Scenario Outline: Replace the added profanities with custom text in XML API
    Given I have the API endpoint "/xml"
    When I request to filter the text "<input_text>"
    And I add "<custom_words>" and replacement text as "<fill_text>" to the list of banned words
    Then the response should be successful with status 200
    And the filtered response should replace "<expected_word>" with "<fill_text>" as  "You are a [] example"

  Examples:
  | input_text                    | custom_words | expected_word  | fill_text                |  
  | This is a dumb example        | dumb         | dumb           |   123                    |
  | This is a lame and stupid one | lame,stupid  | lame stupid    |    _                     |                 
  | You are a 123 idiot           | 123,idiot    | 123 idiot      |    ~                     |                 
  | You are a bad_ugly            | bad_ugly     | bad_ugly       |    !                     |
  | You are a bad                 | bad          | bad            |    =                     |
  | You are a bad                 | bad          | bad            |    -                     |
  | You are a bad                 | bad          | bad            |    |                     |
  | You are a bad                 | bad          | bad            |    '                     |
  | You are a bad                 | bad          | bad            |    "                     |
  | You are a bad                 | bad          | bad            |    {}    		     |
  | You are a bad                 | bad          | bad            |    []  	             |
  | You are a bad                 | bad          | bad            |    ()    		     |
  | You are a bad                 | bad          | bad            | Max Length 20 characters |


 Scenario Outline: Replace the added profanities with custom text in Plain Text API
    Given I have the API endpoint "/plain"
    When I request to filter the text "<input_text>"
    And I add "<custom_words>" and replacement text as "<fill_text>" to the list of banned words
    Then the response should be successful with status 200
    And the filtered response should replace "<expected_word>" with "<fill_text>" as  "You are a [] example"
  Examples:
  | input_text                    | custom_words | expected_word  | fill_text                |  
  | This is a dumb example        | dumb         | dumb           |   123                    |
  | This is a lame and stupid one | lame,stupid  | lame stupid    |    _                     |                 
  | You are a 123 idiot           | 123,idiot    | 123 idiot      |    ~                     |                 
  | You are a bad_ugly            | bad_ugly     | bad_ugly       |    !                     |
  | You are a bad                 | bad          | bad            |    =                     |
  | You are a bad                 | bad          | bad            |    -                     |
  | You are a bad                 | bad          | bad            |    |                     |
  | You are a bad                 | bad          | bad            |    '                     |
  | You are a bad                 | bad          | bad            |    "                     |
  | You are a bad                 | bad          | bad            |    {}    		     |
  | You are a bad                 | bad          | bad            |    []  	             |
  | You are a bad                 | bad          | bad            |    ()    		     |
  | You are a bad                 | bad          | bad            | Max Length 20 characters |


 Scenario Outline: Replace the custom word added profanities with characters in JSON API
    Given I have the API endpoint "/json"
    When I request to filter the text "<input_text>"
    And I add "<custom_words>" and replacement character as "<fill_char>" to the list of banned words
    Then the response should be successful with status 200
    And the filtered response should fill designated "<fill_char>" to the length of word "<expected_word>" replaced as "You are a === example"
Examples:
  | input_text                    | custom_words | expected_word  | fill_char                |  
  | This is a lame and stupid one | lame,stupid  | lame stupid    |    underscore(_)         | 
  | You are a bad                 | bad          | bad            |    |                     |                
  | You are a 123 idiot           | 123,idiot    | 123 idiot      |    ~                     |                 
  | You are a bad_ugly            | bad_ugly     | bad_ugly       |    =                     |
  | You are a bad                 | bad          | bad            |    |                     |
  | You are a bad                 | bad          | bad            |    *                     |
  | You are a bad                 | bad          | bad            |    hyphen(-)             |


 Scenario Outline: Replace the custom word added profanities with characters in XML API
    Given I have the API endpoint "/xml"
    When I request to filter the text "<input_text>"
    And I add "<custom_words>" and replacement character as "<fill_text>" to the list of banned words
    Then the response should be successful with status 200
       And the filtered response should fill designated "<fill_char>" to the length of word "<expected_word>" replaced as "You are a ||| example"
Examples:
  | input_text                    | custom_words | expected_word  | fill_char                |  
  | This is a lame and stupid one | lame,stupid  | lame stupid    |    underscore(_)         | 
  | You are a bad                 | bad          | bad            |    |                     |                
  | You are a 123 idiot           | 123,idiot    | 123 idiot      |    ~                     |                 
  | You are a bad_ugly            | bad_ugly     | bad_ugly       |    =                     |
  | You are a bad                 | bad          | bad            |    |                     |
  | You are a bad                 | bad          | bad            |    *                     |
  | You are a bad                 | bad          | bad            |    hyphen(-)             |

 Scenario Outline: Replace the custom word added profanities with characters in Plain Text API
    Given I have the API endpoint "/plain"
    When I request to filter the text "<input_text>"
    And I add "<custom_words>" and replacement character as "<fill_char>" to the list of banned words
    Then the response should be successful with status 200
    And the filtered response should fill designated "<fill_char>" to the length of word "<expected_word>" replaced as "You are a ~~~ example"
Examples:
  | input_text                    | custom_words | expected_word  | fill_char                |  
  | This is a lame and stupid one | lame,stupid  | lame stupid    |    underscore(_)         | 
  | You are a bad                 | bad          | bad            |    |                     |                
  | You are a 123 idiot           | 123,idiot    | 123 idiot      |    ~                     |                 
  | You are a bad_ugly            | bad_ugly     | bad_ugly       |    =                     |
  | You are a bad                 | bad          | bad            |    |                     |
  | You are a bad                 | bad          | bad            |    *                     |
  | You are a bad                 | bad          | bad            |    hyphen(-)             |
  

Scenario Outline: Verify text contains words matching profanity list
    Given I have the API endpoint "/containsprofanity"
    When I request to filter the text "<input>"
    Then the response status should be 200
    And the response should check <match> profanity list and display "<result>"
Examples:
	| input                     | match                   | result |
	| this is an assh$$$ person | matches found from list | true   |
	| this is a good example    | If no matches are found | false  |

Scenario: Verify custom text added to profanity list
    Given I have the API endpoint "/containsprofanity"
    When I request to add a text to the profanity list 
    Then the response status should be 200
    And the response should check match profanity list and display true