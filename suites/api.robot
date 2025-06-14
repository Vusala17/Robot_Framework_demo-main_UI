*** Settings ***
Library             RequestsLibrary

Suite Setup         Create Session
...                     alias=${SESSION_ALIAS}
...                     url=${BASE_URL}
...                     verify=True
...                     headers={"Content-Type": "application/json", "Accept": "application/json"}
Suite Teardown      Delete All Sessions


*** Variables ***
${BASE_URL}         https://jsonplaceholder.typicode.com
${SESSION_ALIAS}    API_SESSION
${POST_ID}          1


*** Test Cases ***
# Create A New Post Without Session
#     [Documentation]    Response https://www.w3schools.com/PYTHON/ref_requests_response.asp
#     [Tags]    api    post    withoutsession
#     &{data}=    Create Dictionary    title=Test Title    body=Test Body    userId=1
#     ${response}=    POST    url=${BASE_URL}/posts    json=&{data}
#     Should Be Equal As Integers    ${response.status_code}    201
#     Should Be True    ${response.ok}
#     Should Be Equal As Strings    ${response.url}    ${BASE_URL}/posts
#     Log    ${response.json()}

# Get A Post Without Session
#     [Tags]    api    get    withoutsession
#     ${response}=    GET    url=${BASE_URL}/posts/34
#     Should Be Equal As Integers    ${response.status_code}    200
#     Should Be Equal As Strings    ${response.json()["title"]}    magnam ut rerum iure
#     Log    ${response.json()}

Create A New Post
    [Tags]    api    post
    &{data}=    Create Dictionary    title=Test Title    body=Test Body    userId=1
    ${response}=    POST On Session    ${SESSION_ALIAS}    /posts    json=&{data}
    Should Be Equal As Integers    ${response.status_code}    201
    Log    ${response.json()}

Get A Post
    [Tags]    api    get
    ${response}=    GET On Session    ${SESSION_ALIAS}    /posts/${POST_ID}
    Should Be Equal As Integers    ${response.status_code}    200
    Should Be Equal As Strings
    ...    ${response.json()["title"]}
    ...    sunt aut facere repellat provident occaecati excepturi optio reprehenderit
    Log    ${response.json()}

Update A Post
    [Tags]    api    put
    ${updated_data}=    Create Dictionary    id=${POST_ID}    title=Updated Title    body=Updated Body    userId=1
    ${response}=    PUT On Session    ${SESSION_ALIAS}    /posts/${POST_ID}    json=${updated_data}
    Should Be Equal As Integers    ${response.status_code}    200
    Log    ${response.json()}

Delete A Post
    [Tags]    api    delete
    ${response}=    DELETE On Session    ${SESSION_ALIAS}    /posts/${POST_ID}
    Should Be Equal As Integers    ${response.status_code}    200
    Log    ${response.json()}
