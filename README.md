# PurgoMalum API Manual Testing (Postman + BDD Approach)

## Overview
This project demonstrates manual testing of the PurgoMalum API using Postman with a BDD (Behavior-Driven Development) approach. The focus is on validating the profanity filtering service across multiple scenarios.

## About PurgoMalum API
PurgoMalum is a RESTful web service for filtering profanity, obscenity, and other unwanted content from text. The API supports multiple output formats (plain text, JSON, and XML) and can be customized via query parameters.

Base URL:`https://www.purgomalum.com/service`


## Prerequisites

Ensure the following tools are installed on your system:

- [Postman](https://www.postman.com/downloads/)
- GitLab account (for CI/CD integration if needed)


## Repository Setup

1. Clone the repository:
 git clone https://github.com/priyanadar1812/PurgoMalum-API-Tests_Chip.git
 
 cd purgomalum-api-tests


## Steps to download and import the API testing collection files from Github in Postman:- 
1. Open GitHub repository link -> Repository path -> priyanadar1812/PurgoMalum-API-Tests
2. Postman Collections.zip file -> click on it 
3. Right side -> click on 3 dots -> select Download and file is downloaded
4. Open the files in your preferred IDE.
5. Ensure the all the 9 collection files are available.


## Importing the Postman Collection

1. Open Postman.
2. Click Import → Choose Files.
3. Select all the 9 collection files eg. `PurgoMalum.postman_collection.json` to import
4. Verify that the Chip API Assessment collection appears in your workspace.


## BDD Approach for PurgoMalum API Testing
Each test scenario follows the Given-When-Then structure:

### Sample Scenarios (Attached in the GitHub Repo)
***Scenario 1***: Basic Profanity Filter (JSON Response)

**Given**: The user inputs a text containing profanity.

**When**: The text is sent to the PurgoMalum API with JSON response format.

**Then**: The response should censor the profane words.


## Running Manual Tests in Postman

1. Open Postman
2. Select the env as `purgomalum_env`
3. Navigate to the PurgoMalum-API-Tests_Chip collection
4. Select a request and click Send
5. Verify the output matches the expected behavior under the Test tab using assertions.

## Example Postman Assertion (Under the "Tests" Tab):

pm.response.to.have.status(200);

pm.expect(pm.response.json().result).to.eql("This is a **** example");

## Future Improvements

- List of existing Profanity words check for duplicates ,overriding word check error message features could be implemented .
- If list of errors could be available
- Enhance edge case coverage (e.g., null inputs, large payloads).
- Add performance checks for large text inputs.

## Issues found 

Note: Some issues found which do not seem to match requirements could possibly be a bug -
1. Custom words with underscore(_), numbers are not accepted and not added to list with 'add' parameter and not replaced eg. (123_ugly,idiot_bad )
- underscore
- numbers 
- double quotes (")
- add word with 200 char 
2. Issue with input text not filtering if multiple words added without comma separated value

