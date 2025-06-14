*** Settings ***
Library    Browser

*** Variables ***
${LOGIN_URL}    https://www.saucedemo.com/
${USERNAME}     standard_user
${PASSWORD}     secret_sauce
${LOCKED_OUT_USER}    locked_out_user
${INVALID_USER}       invalid_user
${INVALID_PASSWORD}   wrong_password
${FIRST_NAME}   vusala
${LAST_NAME}    nadirova
${POSTAL_CODE}  12345
${LOCATOR_USERNAME}   id=user-name
${LOCATOR_PASSWORD}   id=password
${LOCATOR_LOGIN_BTN}  id=login-button
${LOCATOR_PRODUCTS_CONTAINER}    [data-test="inventory-container"]
${LOCATOR_ERROR_MSG}  data-test=error

*** Keywords ***
Open Saucedemo Browser
    New Browser    chromium
    New Page    ${LOGIN_URL}

Login With Credentials
    [Arguments]    ${username}    ${password}
    Go To    ${LOGIN_URL}
    Fill Text    ${LOCATOR_USERNAME}    ${username}
    Fill Text    ${LOCATOR_PASSWORD}    ${password}
    Click    ${LOCATOR_LOGIN_BTN}

Login With Valid Credentials
    Login With Credentials    ${USERNAME}    ${PASSWORD}
    Wait For Elements State    ${LOCATOR_PRODUCTS_CONTAINER}    visible    10s

Login With Locked Out User
    Login With Credentials    ${LOCKED_OUT_USER}    ${PASSWORD}
    Error Message Should Be Visible

Login And Add Product To Cart
    Login With Valid Credentials
    Click    id=add-to-cart-sauce-labs-backpack

User Should See Products
    Wait For Elements State    ${LOCATOR_PRODUCTS_CONTAINER}    visible    10s

Error Message Should Be Visible
    Wait For Elements State    ${LOCATOR_ERROR_MSG}    visible    10s
    ${error}=    Get Text    ${LOCATOR_ERROR_MSG}
    RETURN    ${error}

Fill User Information
    Fill Text    id=first-name    ${FIRST_NAME}
    Fill Text    id=last-name     ${LAST_NAME}
    Fill Text    id=postal-code   ${POSTAL_CODE}