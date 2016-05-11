*** Settings ***
Documentation    Mobile EventOn functionality testing
# string of start the testsuit testing
# robot -d results  tests/EventOnTest.robot
Library  AppiumLibrary
Library  String
Library  OperatingSystem
#Library  Selenium2Library
Test Teardown       close application

*** Variables ***
#set desire capability
#in Python it looks:
#desired_caps['newCommandTimeout'] = '5000'

${REMOTE_URL}       http://localhost:4723/wd/hub
${PLATFORM_NAME}    Android
${PLATFORM_VERSION}    6.0
#${DEVICE_NAME}     Emulator_api23        # see screenshots in Resours for VD
#${DEVICE_NAME}     192.168.56.101:5555   # ok for VD also
${DEVICE_NAME}      bbce5135              # ok for Real device
${APP}              C:\\development\\EventOn\\Resours\\EventOn_com.eventon.app.apk
${Location}         San Francisco


*** Test Cases ***

User can Launch App
    [Tags]    001 Start app
    #robot -d results -t "User can Launch App" tests/EventOnTest.robot
    Launch App
    capture page screenshot
    #close application

User can search any Location on the map
    [Tags]    002 Main function
    #robot -d results -t "User can search any Location on the map" tests/EventOnTest.robot
    When Launch App
    Then Search some location  ${Location}
    Then capture page screenshot

User can search their Location on the map
    [Tags]    003 Main function
    #robot -d results -t "User can search their Location on the map" tests/EventOnTest.robot
    When Launch App
    Then Click Element        name=My Location
    Then Capture Page Screenshot

User can search signs of EVENTS on the map
    [Tags]    004 Main function
    #robot -d results -t "User can search signs of EVENTS on the map" tests/EventOnTest.robot
    When Launch App
    Then Search some location  ${Location}
    Then click element         class=android.view.View
    Then capture page screenshot

User can search list of EVENTS
    [Tags]    005 Main function
    #robot -d results -t "User can search list of EVENTS" tests/EventOnTest.robot
    When Launch App
    Then Search some location  ${Location}
    Then Search list of EVENTS
    Then capture page screenshot


*** Keywords ***
Launch App
    [Arguments]
    Open Application  ${REMOTE_URL}  platformName=${PLATFORM_NAME}  platformVersion=${PLATFORM_VERSION}  deviceName=${DEVICE_NAME}  app=${APP}  automationName=appium  appPackage=com.eventon.app
    log to console      Application launched successfully!!

Search some location
    [Arguments]  ${Location}
    wait until page contains element  id=com.eventon.app:id/menu_search
    Click Element       id=com.eventon.app:id/menu_search
    Input Text          id=com.eventon.app:id/search_src_text    ${Location}
    #Click A Point       670, 1230
    run  adb shell input keyboard keyevent 66 keyboard
    log                 Location opened on the map
    log to console      Location found and opened

Search list of EVENTS
    click element         class=android.view.View
    click element         class=android.widget.ImageButton
    Wait Until Page Contains Element  id=com.eventon.app:id/menu_list
    capture page screenshot
    click element         id=com.eventon.app:id/menu_list
    Wait Until Page Contains Element   class=android.widget.TextView


