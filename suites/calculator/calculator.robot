*** Settings ***
Documentation       Test suite for a simple calculator API.

Library             ./../../libraries/Calculator.py


*** Test Cases ***
Test Addition
    [Documentation]    Test the addition functionality of the calculator.
    [Tags]    calculator    addition
    [Setup]    Start Calculator
    Set A    5
    Set B    3
    Add
    ${result}=    Get Result
    Should Be Equal As Numbers    ${result}    8
    [Teardown]    Stop Calculator

Test Subtraction
    [Documentation]    Test the subtraction functionality of the calculator.
    [Tags]    calculator    subtraction
    [Setup]    Start Calculator
    Set A    5
    Set B    3
    Subtract
    ${result}=    Get Result
    Should Be Equal As Numbers    ${result}    2
    [Teardown]    Stop Calculator

Test Multiplication
    [Documentation]    Test the multiplication functionality of the calculator.
    [Tags]    calculator    multiplication
    [Setup]    Start Calculator
    Set A    5
    Set B    3
    Multiply
    ${result}=    Get Result
    Should Be Equal As Numbers    ${result}    15
    [Teardown]    Stop Calculator

Test Division
    [Documentation]    Test the division functionality of the calculator.
    [Tags]    calculator    division
    [Setup]    Start Calculator
    Set A    6
    Set B    3
    Divide
    ${result}=    Get Result
    Should Be Equal As Numbers    ${result}    2
    [Teardown]    Stop Calculator

Test Division By Zero
    [Documentation]    Test division by zero raises an error.
    [Tags]    calculator    division_by_zero
    [Setup]    Start Calculator
    Set A    6
    Set B    0
    Run Keyword And Expect Error    ValueError: Division by zero is not allowed.    Divide
    [Teardown]    Stop Calculator
