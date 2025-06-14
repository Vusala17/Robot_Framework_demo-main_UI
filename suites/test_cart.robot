*** Settings ***
Documentation    Saucedemo Cart Test Suite
Library    Browser
Resource    ../resources/saucedemo_resource.robot

*** Test Cases ***
Single Product Should Be Added To Cart
    [Tags]    saucedemo    cart    single_product
    [Setup]    Open Saucedemo Browser
    Login With Credentials    ${USERNAME}    ${PASSWORD}
    Click    id=add-to-cart-sauce-labs-backpack
    Click    .shopping_cart_link
    Wait For Elements State    xpath=//div[text()='Sauce Labs Backpack']    visible    10s
    [Teardown]    Close Browser

Multiple Products Should Be Added To Cart
    [Tags]    saucedemo    cart    multiple_products
    [Setup]    Open Saucedemo Browser
    Login With Credentials    ${USERNAME}    ${PASSWORD}
    Click    id=add-to-cart-sauce-labs-backpack
    Click    id=add-to-cart-sauce-labs-bike-light
    Click    .shopping_cart_link
    Wait For Elements State    xpath=//div[text()='Sauce Labs Backpack']    visible    10s
    Wait For Elements State    xpath=//div[text()='Sauce Labs Bike Light']    visible    10s
    [Teardown]    Close Browser

Product Should Be Removable From Cart
    [Tags]    saucedemo    cart    remove_product
    [Setup]    Open Saucedemo Browser
    Login With Credentials    ${USERNAME}    ${PASSWORD}
    Click    id=add-to-cart-sauce-labs-backpack
    Click    .shopping_cart_link
    Click    id=remove-sauce-labs-backpack
    Wait For Elements State    xpath=//div[text()='Sauce Labs Backpack']    detached    10s
    [Teardown]    Close Browser

# ...existing code for more test cases if needed...