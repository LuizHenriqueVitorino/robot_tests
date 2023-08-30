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

QUANDO o usuário receber o Obter Token
    ${BODY}      Create Dictionary   email=${USUARIO.email}   password=${USUARIO.senha}
    ${RESPONSE}  POST On Session     alias=serveRest    url=login    json=${BODY}
    Log   Resposta Retornada: ${\n}${RESPONSE.text}
    Dictionary Should Contain Item    ${RESPONSE.json()}    message    Login realizado com sucesso
    ${TOKEN}     Get From Dictionary    ${RESPONSE.json()}    authorization
    Set Suite Variable    ${TOKEN}
E realizar a requisição do produto ${_id}
    [Documentation]    Realiza uma requisição informando o id do produto no path do endpoint
    ${RESPONSE}    GET On Session    alias=serveRest    url=/produtos/${_id}
Então o sistema deve retornar um json com o produto relacionado ao id pesquisado
    [Documentation]    Verifica se o status de resposta é 200
    ${HEADERS}   Create Dictionary  Authorization=${TOKEN}
    ${RESPONSE}  GET On Session     alias=serveRest    url=produtos/${_id}    headers=${HEADERS}
    Log   Resposta Retornada: ${\n}${RESPONSE.text}
    Dictionary Should Contain Item    ${RESPONSE.json()}    nome    Samsung 60 polegadas

    Delete All Sessions


*** Test Cases ***
Cenário 1: Pesquisar produto por id
    DADO que o usuário inicie a sessão na API do serverest
    E realize o cadastro no sistema
    QUANDO o usuário receber o Obter Token
    E realizar a requisição do produto ${_id}
    Então o sistema deve retornar um json com o produto relacionado ao id pesquisado