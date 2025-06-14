*** Settings ***
Documentation       SauceDemo Auth Test Suite

Library             SeleniumLibrary
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
    [Tags]    saucedemo    auth    standard_user    selenium
    [Setup]    Open SauceDemo On Browser
    Log In As ${SAUCEDEMO_STANDARD_USER}
    User Should Be Able To See Products
    [Teardown]    Close Browser

Problem User Should Be Able To See Products
    [Tags]    saucedemo    auth    problem_user    selenium
    [Setup]    Run Keywords    Open SauceDemo On Browser
    ...    AND    Log In As ${SAUCEDEMO_PROBLEM_USER}
    ...    AND    User Should Be Able To See Products
    Log    Hello World
    [Teardown]    Close Browser

Locked Out User Should Not Be Able To See Products
    [Tags]    saucedemo    auth    locked_out_user    selenium
    [Setup]    Open SauceDemo On Browser
    Log In As ${SAUCEDEMO_LOCKED_OUT_USER}
    Lockout Error Should Be Shown
    [Teardown]    Close Browser

Performance Glitch User Should Be Able To See Products
    [Tags]    saucedemo    auth    performance_glitch_user    selenium
    [Setup]    Open SauceDemo On Browser
    Log In As ${SAUCEDEMO_PERFORMANCE_GLITCH_USER}
    User Should Be Able To See Products
    [Teardown]    Close Browser

Error User Should Be Able To See Products
    [Tags]    saucedemo    auth    error_user    selenium
    [Setup]    Open SauceDemo On Browser
    Log In As ${SAUCEDEMO_ERROR_USER}
    User Should Be Able To See Products
    [Teardown]    Close Browser

Visual User Should Be Able To See Products
    [Tags]    saucedemo    auth    visual_user    selenium
    [Setup]    Open SauceDemo On Browser
    Log In As ${SAUCEDEMO_VISUAL_USER}
    User Should Be Able To See Products
    [Teardown]    Close Browser


*** Keywords ***
Open SauceDemo On Browser
    Set Selenium Implicit Wait    5 seconds
    Set Selenium Speed    3 seconds
    Set Selenium Timeout    30 seconds

    ${prefs}=    Create Dictionary    credentials_enable_service=False    profile.password_manager_enabled=False
    ${chrome options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome options}    add_argument    --disable-notifications
    Call Method    ${chrome options}    add_argument    --disable-infobars
    Call Method    ${chrome options}    add_argument    --disable-extensions
    Call Method    ${chrome options}    add_argument    --no-default-browser-check
    Call Method    ${chrome options}    add_argument    --disable-popup-blocking
    Call Method    ${chrome options}    add_argument    --disable-save-password-bubble
    Call Method    ${chrome options}    add_experimental_option    prefs    ${prefs}

    Create WebDriver    Chrome    options=${chrome options}
    Maximize Browser Window
    Go To    ${CONSTANTS_BASE_URL}

Log In As ${username}
    [Arguments]    ${password}=${SAUCEDEMO_PASSWORD}
    Input Text    css:${LOCATORS_AUTH_USERNAME}    ${username}
    Input Text    css:${LOCATORS_AUTH_PASSWORD}    ${password}
    Click Button    css:${LOCATORS_AUTH_LOGIN_BTN}

User Should Be Able To See Products
    Wait Until Element Is Visible    css:${LOCATORS_PRODUCTS_PAGE_TITLE}    timeout=5 seconds
    ${PRODUCTS_TITLE}=    Get Text    css:${LOCATORS_PRODUCTS_PAGE_TITLE}
    Should Be Equal As Strings    ${PRODUCTS_TITLE}    ${CONSTANTS_PRODUCTS_PAGE_TITLE}
    ${URL}=    Get Location
    Should Be Equal As Strings    ${URL}    ${PRODUCTS_PAGE_URL}

Lockout Error Should Be Shown
    Wait Until Element Is Visible    css:${LOCATORS_AUTH_ERROR_MESSAGE}    timeout=5 seconds
    ${ERROR_MESSAGE}=    Get Text    css:${LOCATORS_AUTH_ERROR_MESSAGE}
    Should Be Equal As Strings    ${ERROR_MESSAGE}    ${CONSTANTS_AUTH_ERROR_MESSAGE}
