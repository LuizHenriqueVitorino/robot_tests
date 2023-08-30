*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    FakerLibrary    locale=pt_br

*** Variables ***
${BASE_URL}           https://serverest.dev
${_id}                K6leHdftCeOJj8BJ

*** Keywords ***
Criar dados do usuário
    [Documentation]    Cria um dicionário com os dados do usuário
    ${FIRT_NAME}  FakerLibrary.First Name
    ${LAST_NAME}  FakerLibrary.Last Name
    ${EMAIL}      FakerLibrary.Email
    ${PASSWORD}   FakerLibrary.Password
    ${USUARIO}    Create Dictionary    nome=${FIRT_NAME} ${LAST_NAME}  email=${EMAIL}  senha=${PASSWORD}
    Set Suite Variable    ${USUARIO}  
DADO que o usuário inicie a sessão na API do serverest
    [Documentation]    Inicia a cessão na API do serverest
    ${HEADERS}    Create Dictionary    Content-Type=application/json
    Create Session    alias=serveRest    url=${BASE_URL}    headers=${HEADERS}    disable_warnings=1
E realize o cadastro no sistema
    Criar dados do usuário
    ${Body}    Create Dictionary    nome=${USUARIO.nome}    email=${USUARIO.email}    password=${USUARIO.senha}    administrador=true
    ${RESPONSE}    POST On Session     alias=serveRest    url=usuarios    json=${BODY}
    Log   Resposta Retornada: ${\n}${RESPONSE.text}
QUANDO o usuário realiza a requisição do produto ${_id}
    [Documentation]    Realiza uma requisição informando o id do produto no path do endpoint
    ${RESPONSE}    GET On Session    alias=serveRest    url=/produtos/${_id}
Então o status de resposta deve ser 200
    [Documentation]    Verifica se o status de resposta é 200
    ${HEADERS}   Create Dictionary  Authorization=${TOKEN}
    ${RESPONSE}  GET On Session     alias=serveRest    url=produtos/${_id}    headers=${HEADERS}
    Log   Resposta Retornada: ${\n}${RESPONSE.text}
    Should Be Equal As Strings    200    200

    Delete All Sessions


*** Test Cases ***
Cenário 1: Pesquisar produto por id
    DADO que o usuário inicie a sessão na API do serverest
    E realize o cadastro no sistema
    QUANDO o usuário realiza a requisição do produto ${_id}
    Então o status de resposta deve ser 200