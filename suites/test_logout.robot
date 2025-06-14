*** Settings ***
Documentation    Saucedemo Logout Test Suite
Library    Browser
Resource    ../resources/saucedemo_resource.robot

*** Test Cases ***
Logout From Hamburger Menu
    [Tags]    logout
    [Setup]    Open Saucedemo Browser
    Login With Credentials    ${USERNAME}    ${PASSWORD}
    Click    id=react-burger-menu-btn
    Wait For Elements State    id=logout_sidebar_link    visible    10s
    Click    id=logout_sidebar_link
    Wait For Elements State    id=user-name    visible    10s
    Get Url    # Optionally, add Should Be Equal As Strings    ${URL}    ${LOGIN_URL}
    [Teardown]    Close Browser

Logout Ends Session
    [Tags]    logout
    [Setup]    Open Saucedemo Browser
    Login With Credentials    ${USERNAME}    ${PASSWORD}
    Wait For Elements State    id=react-burger-menu-btn    visible    10s
    Click    id=react-burger-menu-btn
    Wait For Elements State    id=logout_sidebar_link    visible    10s
    Wait For Elements State    id=logout_sidebar_link    enabled    10s
    Click    id=logout_sidebar_link
    Browser.Go To    https://www.saucedemo.com/inventory.html
    Wait For Elements State    id=user-name    visible    10s
    [Teardown]    Close Browser

