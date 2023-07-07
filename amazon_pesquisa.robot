*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${input_pesquisa}    id:twotabsearchtextbox
${botao_lupa}        id:nav-search-submit-button

*** Keywords ***
DADO que o usuário acesse o site
    Open Browser    https://www.amazon.com.br/    chrome
QUANDO ele escrever o nome do produto no campo de pesquisa
    Input Text    ${input_pesquisa}    bola
E clicar no ícone da lupa
    Click Element    ${botao_lupa}
ENTÃO o sistema deve apresentar os itens correspondentes à pesquisa
    Sleep    5s
    Close Browser

*** Test Cases ***
Cenário 1: Pesquisar produto
    DADO que o usuário acesse o site
    QUANDO ele escrever o nome do produto no campo de pesquisa
    E clicar no ícone da lupa
    ENTÃO o sistema deve apresentar os itens correspondentes à pesquisa
