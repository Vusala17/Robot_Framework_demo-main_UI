*** Settings ***
Documentation       Test suite for a simple calculator API.

Resource            ./../../resources/calculator.resource


*** Test Cases ***
Test Addition
    [Documentation]    Test the addition functionality of the calculator.
    [Tags]    calculator    addition
    Given The Calculator Is Running
    When I Add 5 And 3
    Then The Result Should Be 8

Test Subtraction
    [Documentation]    Test the subtraction functionality of the calculator.
    [Tags]    calculator    subtraction
    Given The Calculator Is Running
    When I Subtract 10 From 4
    Then The Result Should Be -6

Test Multiplication
    [Documentation]    Test the multiplication functionality of the calculator.
    [Tags]    calculator    multiplication
    Given The Calculator Is Running
    When I Multiply 6 By 7
    Then The Result Should Be 42

Test Division
    [Documentation]    Test the division functionality of the calculator.
    [Tags]    calculator    division
    Given The Calculator Is Running
    When I Divide 20 By 4
    Then The Result Should Be 5

Test Division By Zero
    [Documentation]    Test division by zero raises an error.
    [Tags]    calculator    division_by_zero
    Given The Calculator Is Running
    When I Divide 10 By 0
    Then It Should Raise Division By Zero Error
