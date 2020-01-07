*** Settings ***
Library           SeleniumLibrary

*** Test Cases ***
login
    Open Browser    https://console-staging.lbondtech.com/    chrome    #打开浏览器
    Maximize Browser Window    #浏览器最大化
    Input Text    //*[@id="app"]/div/div[1]/div/span[1]/div/input    ceshidl@163.com    #输入正确的用户名
    Input Password    //*[@id="app"]/div/div[1]/div/span[2]/div/input    Zichan360    #输入正确的密码
    Click Element    //*[@id="app"]/div/div[1]/div/button    #点击登录按钮
    Sleep    3    #等待3秒
    Page Should Contain    我的产品    #断言包含我的产品
    Comment    Page Should Contain    验证    #断言输入登录失败时会出现验证
    sleep    4
