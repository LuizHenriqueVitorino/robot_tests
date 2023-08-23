*** Settings ***
Library    RequestsLibrary

*** Variables ***

*** Test Cases ***
Realizando primeiro GET no Fake API
    Create Session    alias=faker_api    url=https://fakerapi.it/api/v1/

    ${RESPONSE}    GET On Session    alias=faker_api    url=addresses?_quantity=1

    Log To Console    ${RESPONSE}
    Log To Console    ${RESPONSE.text}

    ${RESPONSE}    GET On Session    alias=faker_api    url=books?_quantity=1

    Log To Console    ${RESPONSE}
    Log To Console    ${RESPONSE.text}

    ${return}   Session Exists  alias=faker_api
    Log To Console  ${return}

    Delete All Sessions

    ${return}   Session Exists  alias=faker_api

    Log To Console  ${return}

Realizando outro GET 1
    Create Session    alias=faker_api    url=https://fakerapi.it/api/v1/

    ${RESPONSE}    GET On Session    alias=faker_api    url=books?_quantity=1    expected_status=200    msg=Essa mensagem é um teste
    Log To Console    ${RESPONSE}
    Log To Console    ${RESPONSE.text}

    Delete All Sessions


*** Keywords ***