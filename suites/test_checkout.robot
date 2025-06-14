*** Settings ***
Documentation    Saucedemo Checkout Test Suite
Library    Browser
Resource    ../resources/saucedemo_resource.robot

*** Test Cases ***
Proceed To Checkout After Adding Product To Cart
    [Tags]    saucedemo    checkout    proceed
    [Setup]    Open Saucedemo Browser
    Login And Add Product To Cart
    Click    .shopping_cart_link
    Wait For Elements State    id=checkout    visible    10s
    Click    id=checkout
    Take Screenshot
    Wait For Elements State    id=first-name    visible    10s
    [Teardown]    Close Browser

Checkout Should Require Information
    [Tags]    saucedemo    checkout    negative
    [Setup]    Open Saucedemo Browser
    Login And Add Product To Cart
    Click    .shopping_cart_link
    Wait For Elements State    id=checkout    visible    10s
    Click    id=checkout
    Wait For Elements State    id=continue    visible    10s
    Click    id=continue
    Wait For Elements State    xpath=//h3[contains(text(),'Error')]    visible    10s
    [Teardown]    Close Browser

First Name, Last Name, Postal Code Required For Next Step
    [Tags]    saucedemo    checkout    required_fields    negative
    [Setup]    Open Saucedemo Browser
    Login And Add Product To Cart
    Click    .shopping_cart_link
    Wait For Elements State    id=checkout    visible    10s
    Click    id=checkout
    Wait For Elements State    id=first-name    visible    10s
    Click    id=continue
    Wait For Elements State    xpath=//h3[contains(text(),'Error')]    visible    10s
    [Teardown]    Close Browser

Order Should Be Finished And Thank You Message Should Be Shown
    [Tags]    saucedemo    checkout    finish    positive
    [Setup]    Open Saucedemo Browser
    Login And Add Product To Cart
    Click    .shopping_cart_link
    Wait For Elements State    id=checkout    visible    10s
    Click    id=checkout
    Wait For Elements State    id=first-name    visible    10s
    Fill Text    id=first-name    ${FIRST_NAME}
    Fill Text    id=last-name     ${LAST_NAME}
    Fill Text    id=postal-code   ${POSTAL_CODE}
    Click    id=continue
    Wait For Elements State    id=finish    visible    10s
    Click    id=finish
    Wait For Elements State    xpath=//h2[text()='Thank you for your order!']    visible    10s
    Get Text    xpath=//h2
    [Teardown]    Close Browser

Check Cart Total Price Equals Subtotal Plus Tax
    [Tags]    saucedemo    checkout    total    standard_user
    [Setup]    Open Saucedemo Browser
    Login And Add Product To Cart
    Click    .shopping_cart_link
    Wait For Elements State    id=checkout    visible    10s
    Click    id=checkout
    Wait For Elements State    id=first-name    visible    15s
    Fill Text    id=first-name    ${FIRST_NAME}
    Fill Text    id=last-name     ${LAST_NAME}
    Fill Text    id=postal-code   ${POSTAL_CODE}
    Click    id=continue
    ${subtotal_text}=    Get Text    xpath=//div[@class='summary_subtotal_label']
    ${tax_text}=         Get Text    xpath=//div[@class='summary_tax_label']
    ${total_text}=       Get Text    xpath=//div[@class='summary_total_label']
    ${subtotal}=    Evaluate    float('${subtotal_text}'.replace('Item total: $',''))
    ${tax}=         Evaluate    float('${tax_text}'.replace('Tax: $',''))
    ${total}=       Evaluate    float('${total_text}'.replace('Total: $',''))
    Should Be True    abs(${subtotal} + ${tax} - ${total}) < 0.01    Subtotal + Tax != Total: ${subtotal} + ${tax} != ${total}
    [Teardown]    Close Browser

# ...existing code for more test cases if needed...
