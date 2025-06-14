*** Settings ***
Documentation    Saucedemo Product Test Suite
Library    Browser
Resource    ../resources/saucedemo_resource.robot

*** Test Cases ***
Product List Visible After Login
    [Tags]    product    list
    [Setup]    Open Saucedemo Browser
    Login With Credentials    ${USERNAME}    ${PASSWORD}
    Wait For Elements State    [data-test="inventory-container"]    visible    10s
    [Teardown]    Close Browser

Product Names And Prices Are Correct
    [Tags]    product    data
    [Setup]    Open Saucedemo Browser
    Login With Credentials    ${USERNAME}    ${PASSWORD}
    Wait For Elements State    xpath=//div[text()='Sauce Labs Backpack']    visible    10s
    ${name}=    Get Text    xpath=//div[text()='Sauce Labs Backpack']
    Should Be Equal As Strings    ${name}    Sauce Labs Backpack
    ${price}=    Get Text    xpath=//div[text()='Sauce Labs Backpack']/following::div[@class='inventory_item_price'][1]
    Should Be Equal As Strings    ${price}    $29.99
    [Teardown]    Close Browser

Sort Dropdown Functionality
    [Tags]    product    sort
    [Setup]    Open Saucedemo Browser
    Login With Credentials    ${USERNAME}    ${PASSWORD}
    Select Options By    .product_sort_container    value    lohi
    ${first_price}=    Get Text    xpath=(//div[@class='inventory_item_price'])[1]
    Should Be Equal As Strings    ${first_price}    $7.99
    Select Options By    .product_sort_container    value    hilo
    ${first_price}=    Get Text    xpath=(//div[@class='inventory_item_price'])[1]
    Should Be Equal As Strings    ${first_price}    $49.99
    [Teardown]    Close Browser

