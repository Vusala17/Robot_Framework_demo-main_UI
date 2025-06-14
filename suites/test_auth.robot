*** Settings ***
Documentation    Saucedemo Auth Test Suite
Library    Browser
Resource    ../resources/saucedemo_resource.robot

*** Test Cases ***
Standard User Should Be Able To See Products
    [Tags]    saucedemo    auth    standard_user
    [Setup]    Open Saucedemo Browser
    Login With Credentials    ${USERNAME}    ${PASSWORD}
    Wait For Elements State    [data-test="inventory-container"]    visible    10s
    [Teardown]    Close Browser

Locked Out User Should Not Be Able To Login
    [Tags]    saucedemo    auth    locked_out_user
    [Setup]    Open Saucedemo Browser
    Login With Credentials    ${LOCKED_OUT_USER}    ${PASSWORD}
    ${error}=    Error Message Should Be Visible
    Should Contain    ${error}    Sorry, this user has been locked out.
    [Teardown]    Close Browser

Invalid User Should Not Be Able To Login
    [Tags]    saucedemo    auth    invalid_user
    [Setup]    Open Saucedemo Browser
    Login With Credentials    ${INVALID_USER}    ${INVALID_PASSWORD}
    ${error}=    Error Message Should Be Visible
    # Optionally: Should Contain    ${error}    expected error text
    [Teardown]    Close Browser
