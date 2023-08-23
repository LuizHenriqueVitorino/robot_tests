*** Settings ***
Library    RequestsLibrary

*** Test Cases ***
Requestes das imagens do faker_api
    Create Session    alias=fakerapi    url=https://fakerapi.it/api/v1/

    ${RESPONSE}    GET On Session    alias=fakerapi    url=images?_quantity=1&_type=kittens&_height=300

    Log To Console    ${RESPONSE.json()}

    Delete All Sessions
    

*** Keywords ***