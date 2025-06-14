*** Comments ***
Settings >> https://docs.robotframework.org/docs/getting_started/how_to_write_rf#settings


*** Settings ***
Documentation       Test API suite demonstrating basic structure: settings, variables, test cases, and keywords.

Resource            ./../resources/example.resource

Suite Setup         Log    Suite Started
Suite Teardown      Log    Suite Teardown


*** Variables ***
${LOG_MESSAGE_1}    This is a log message
${LOG_MESSAGE_2}    This is another log message


*** Test Cases ***
Test Case 1
    [Documentation]    This is the first test case
    [Tags]    jira-0001    test01
    [Setup]    Log    Test Case 1 Setup

    Should Not Be Empty    ${LOG_MESSAGE_1}
    Should Not Be Empty    ${LOG_MESSAGE_2}
    Log Extra Info    ${LOG_MESSAGE_1}
    Log Additional Info    ${LOG_MESSAGE_2}

    [Teardown]    Log    Test Case 1 Teardown


*** Keywords ***
Log Extra Info
    [Documentation]    Logs additional debug information
    [Arguments]    ${message}
    Log    ${message}
