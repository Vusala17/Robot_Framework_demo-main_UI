*** Settings ***
Library     ./../libraries/Calculator.py


*** Variables ***
${__RESULT__}       0


*** Keywords ***
The Calculator Is Running
    Start Calculator
    ${state}=    Get State
    Should Be Equal As Strings    ${state}    started

I Add ${a} And ${b}
    Set A    ${a}
    Set B    ${b}
    Add
    ${result}=    Get Result
    Set Test Variable    ${__RESULT__}    ${result}

I Subtract ${b} From ${a}
    Set A    ${a}
    Set B    ${b}
    Subtract
    ${result}=    Get Result
    Set Test Variable    ${__RESULT__}    ${result}

I Multiply ${a} By ${b}
    Set A    ${a}
    Set B    ${b}
    Multiply
    ${result}=    Get Result
    Set Test Variable    ${__RESULT__}    ${result}

I Divide ${a} By ${b}
    Set A    ${a}
    Set B    ${b}
    Run Keyword And Ignore Error    Divide
    ${result}=    Get Result
    Set Test Variable    ${__RESULT__}    ${result}

The Result Should Be ${expected}
    Should Be Equal As Numbers    ${__RESULT__}    ${expected}

It Should Raise Division By Zero Error
    Run Keyword And Expect Error    ValueError: Division by zero is not allowed.    Divide
