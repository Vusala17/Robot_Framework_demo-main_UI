*** Settings ***
Documentation       SauceDemo Auth Test Suite

Library             Browser
Variables           ../data/contants.py
Variables           ../data/locators.py


*** Variables ***
${SAUCEDEMO_STANDARD_USER}              standard_user
${SAUCEDEMO_PROBLEM_USER}               problem_user
${SAUCEDEMO_LOCKED_OUT_USER}            locked_out_user
${SAUCEDEMO_PERFORMANCE_GLITCH_USER}    performance_glitch_user
${SAUCEDEMO_ERROR_USER}                 error_user
${SAUCEDEMO_VISUAL_USER}                visual_user
${SAUCEDEMO_PASSWORD}                   secret_sauce
${PRODUCTS_PAGE_URL}                    ${CONSTANTS_BASE_URL}/inventory.html


*** Test Cases ***
Standard Users Should Be Able To See Products
    [Tags]    saucedemo    auth    standard_user
    [Setup]    Open SauceDemo On Browser
    Log In As ${SAUCEDEMO_STANDARD_USER}
    User Should Be Able To See Products
    [Teardown]    Close Browser

Problem User Should Be Able To See Products
    [Tags]    saucedemo    auth    problem_user
    [Setup]    Run Keywords    Open SauceDemo On Browser
    ...    AND    Log In As ${SAUCEDEMO_PROBLEM_USER}
    ...    AND    User Should Be Able To See Products
    Log    Hello World
    [Teardown]    Close Browser

Locked Out User Should Not Be Able To See Products
    [Tags]    saucedemo    auth    locked_out_user
    [Setup]    Open SauceDemo On Browser
    Log In As ${SAUCEDEMO_LOCKED_OUT_USER}
    Lockout Error Should Be Shown
    [Teardown]    Close Browser

Performance Glitch User Should Be Able To See Products
    [Tags]    saucedemo    auth    performance_glitch_user
    [Setup]    Open SauceDemo On Browser
    Log In As ${SAUCEDEMO_PERFORMANCE_GLITCH_USER}
    User Should Be Able To See Products
    [Teardown]    Close Browser

Error User Should Be Able To See Products
    [Tags]    saucedemo    auth    error_user
    [Setup]    Open SauceDemo On Browser
    Log In As ${SAUCEDEMO_ERROR_USER}
    User Should Be Able To See Products
    [Teardown]    Close Browser

Visual User Should Be Able To See Products
    [Tags]    saucedemo    auth    visual_user
    [Setup]    Open SauceDemo On Browser
    Log In As ${SAUCEDEMO_VISUAL_USER}
    User Should Be Able To See Products
    [Teardown]    Close Browser


*** Keywords ***
Open SauceDemo On Browser
    New Browser    browser=chromium
    ...    headless=False
    ...    slowMo=1s
    ...    timeout=30s
    New Context    tracing=True
    ...    viewport={"width": 1280, "height": 720}
    ...    defaultBrowserType=chromium
    New Page    ${CONSTANTS_START_URL}

Log In As ${username}
    [Arguments]    ${password}=${SAUCEDEMO_PASSWORD}
    Fill Text    css=${LOCATORS_AUTH_USERNAME}    ${username}
    Fill Text    css=${LOCATORS_AUTH_PASSWORD}    ${password}
    Click    css=${LOCATORS_AUTH_LOGIN_BTN}

User Should Be Able To See Products
    Wait For Elements State    css=${LOCATORS_PRODUCTS_PAGE_TITLE}    visible    5000
    ${PRODUCTS_TITLE}=    Get Text    css=${LOCATORS_PRODUCTS_PAGE_TITLE}
    Should Be Equal As Strings    ${PRODUCTS_TITLE}    ${CONSTANTS_PRODUCTS_PAGE_TITLE}
    ${URL}=    Get Url
    Should Be Equal As Strings    ${URL}    ${PRODUCTS_PAGE_URL}

Lockout Error Should Be Shown
    Wait For Elements State    css=${LOCATORS_AUTH_ERROR_MESSAGE}    visible    5000
    ${ERROR_MESSAGE}=    Get Text    css=${LOCATORS_AUTH_ERROR_MESSAGE}
    Should Be Equal As Strings    ${ERROR_MESSAGE}    ${CONSTANTS_AUTH_ERROR_MESSAGE}
