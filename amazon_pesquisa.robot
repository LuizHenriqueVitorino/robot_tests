*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${input_pesquisa}    id:twotabsearchtextbox
${botao_lupa}        id:nav-search-submit-button

*** Keywords ***
Abrir o navegador e acessar o Site
    Open Browser    https://www.amazon.com.br/    chrome
Escrever o nome do produto no input de pesquisa
    Input Text    ${input_pesquisa}    bola
Clicar na lupa
    Click Element    ${botao_lupa}
Fechar o navegador
    Sleep    5s
    Close Browser

    

*** Test Cases ***
Cenário 1: Pesquisar produto
    Abrir o navegador e acessar o Site
    Escrever o nome do produto no input de pesquisa
    Clicar na lupa
    Fechar o navegador
