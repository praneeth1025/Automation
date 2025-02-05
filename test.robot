*** Settings ***
Library  SeleniumLibrary
Library     OperatingSystem
Library    Collections
Library    XML

*** Variables ***
${email_xpath}    //div/input[@id='username']
${password_xpath}    //div/input[@id='password']
${username}    ######
${password}    ####

*** Keyword ***
check modal is opened
    ${element_visibility_dismiss}    Run Keyword And Return Status    Element Should Be Visible    //button[@aria-label = "Dismiss"]
    IF    ${element_visibility_dismiss} == True
        Click Element    //button[@aria-label = "Dismiss"] 
        Sleep    0.5       
        click element    //button/span[text()='Discard']
    END

click job 
    @{jobs}=    Create List
    @{jobs}    Get WebElements    //div['data-results-list-top-scroll-sentinel']//ul/li[contains(@class, 'ember-view')]
    # @{new_list}    Get Elements    @{jobs}    //div['data-results-list-top-scroll-sentinel']//ul[@class='ybBZiujXmyKLKKTvcBpcxjJutuzOQoeCnLQ']/li
    Log To Console    ${jobs}    
    ${length}    Get Length    ${jobs}
    Log To Console    ${length}
    # Get List Items    //ul/li[contains(@class, 'ember-view')]
    FOR    ${element}    IN    @{jobs}
        ${index}    Get Index From List    ${jobs}    ${element}
        Set Global Variable    ${index}
        ${value}    Evaluate    ${index}+1
        ${status}=    Run Keyword And Return Status     Wait Until Element Is Visible    (//div['@data-results-list-top-scroll-sentinel']//ul/li[contains(@class , 'ember-view')])[${value}]//a
        ${job_title}    Get Text    (//div['@data-results-list-top-scroll-sentinel']//ul/li[contains(@class , 'ember-view')])[${value}]//a
        ${company}    Get Text    ((//div['@data-results-list-top-scroll-sentinel']//ul/li[contains(@class , 'ember-view')])[${value}]//div/span)[1]
        # ${job_title}    Get Element Text    (//div['@data-results-list-top-scroll-sentinel']//ul/li[contains(@class , 'ember-view')])[${value}]//a
        # ${company}    Get Element Text    (//div['@data-results-list-top-scroll-sentinel']//ul/li[contains(@class, 'ember-view')]//div/span)[${value}]
        Append To List    ${jobs_list}    ${job_title}-${company}
        Click Element   (//div['data-results-list-top-scroll-sentinel']//ul/li[contains(@class , 'ember-view')])[${index}+1]//a
        ${element_visibility}    Run Keyword And Return Status    Wait Until Element Is Visible    (//button/span[text()='Easy Apply'])[1]
        Click Element    (//button/span[text()='Easy Apply'])[1]
        check modal is opened
        
    END
    
*** Test Cases ***
Open Google
    Open Browser    https://www.linkedin.com/login    Chrome
    Maximize Browser Window
    sleep    5
    Input Text    ${email_xpath}    ${username}
    Sleep    2
    Input Text    ${password_xpath}    ${password}
    Click Element    //div[@class='login__form_action_container ']//button
    Log To Console    elemtent clicked
    Sleep    10
    Log To Console    started
    Wait Until Element Is Visible    //div[@class='share-box-feed-entry__avatar']
    Click Element    //span[text()='Jobs']
    Sleep    20
    Wait Until Element Is Visible    //a[@aria-label='Show all Job picks for you']/span[text()='Show all']
    Sleep    3
    Click Element    //a[@aria-label='Show all Job picks for you']/span[text()='Show all']
    Sleep    30
    Input Text    (//input)[1]    software engineer
    Press Keys    (//input)[1]    ENTER
    Sleep    10
    Click Element    //button[text()="Easy Apply"]
    Sleep    30
    # Wait Until Element Is Visible    (//button/span[text()='Easy Apply'])[1]
    # Click Button    (//button/span[text()='Easy Apply'])[1]
    @{jobs_list}=    Create List    
    Set Global Variable    @{jobs_list}
    
    # @{jobs}    Get WebElements    //div['data-results-list-top-scroll-sentinel']//ul/li[contains(@class , 'ember-view')]
    click job 
    IF    ${index} == 25
        Click Button    //div[contains(@class , 'jobs-search-pagination jobs-search-results-list__pagination p4')]//button/span[text()='Next' ]
        click job
    END
    

    
    # Append To List    ${jobs}
    # Get Length    ${jobs_list}
    # FOR    ${element}    IN    @{jobs_list}
    #     Click Element    ${element}
    #     Wait Until Element Is Visible    (//button/span[text()='Easy Apply'])[1]
    #     Click Button    (//button/span[text()='Easy Apply'])[1]
    #     check modal is opened
    # END
    Sleep    3s
    # Close Browser

