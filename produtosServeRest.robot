*** Settings ***
Library    RequestsLibrary

*** Variables ***
${BASE_URL}           https://serverest.dev
${HEADERS}            Content-Type=application/json
${_id}                K6leHdftCeOJj8BJ

*** Keywords ***    
DADO que o endpoint da API está disponivel
    [Documentation]    Verifique se a API está disponível
    Create Session    alias=serveRest    url=${BASE_URL}
QUANDO o usuário realiza a requisição do produto ${_id}
    [Documentation]    Realiza uma requisição informando o id do produto no path do endpoint
    ${RESPONSE}    GET On Session    alias=serveRest    url=/produtos/${_id}
Então o status de resposta deve ser 200
    [Documentation]    Verifica se o status de resposta é 200
    ${status_code}    Set Variable    RESPONSE
    Should Be Equal As Strings    ${status_code}    200

    Delete All Sessions


*** Test Cases ***
Cenário 1: Pesquisar produto por id
    DADO que o endpoint da API está disponivel
    QUANDO o usuário realiza a requisição do produto ${_id}
    Então o status de resposta deve ser 200