*** Settings ***
Library    RequestsLibrary

*** Variables ***

*** Test Cases ***
Realizando primeiro GET no Fake API
    Create Session    alias=faker_api    url=https://fakerapi.it/api/v1/images?_width=380
    ${RESPONSE}    GET On Session    alias=faker_api    url=https://fakerapi.it/api/v1/images?_width=380

    Log To Console    ${RESPONSE}
    Log To Console    ${RESPONSE.text}


*** Keywords ***