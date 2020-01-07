*** Settings ***
Library           requests
Library           Selenium2Library
Library           Collections
Library           DatabaseLibrary
Library           OperatingSystem

*** Test Cases ***
打开定制版
    打开定制版
    Click Element    css=dt:nth-child(3) > a    #点击管理工作台
    Sleep    5
    Select Frame    //*[@id="iframe"]    #定位页面
    Execute Javascript    document.getElementsByClassName('select-input')[0].click()    #点击催收进展搜索框
    Sleep    3
    Click Element    //*[@id="collectionProgress"]/div/ul[1]/li[1]/div[1][contains(text(), '待主管分单')]    #点击主管未分单
    sleep    2
    Click Element    //*[@id="collectionProgress_four"]/span[contains(text(),'未分单')]    #点击未分单
    sleep    5
    Click Element    //*[@id="search-list-btn"]    #点击查询按钮
    Sleep    10
    Execute Javascript    console.log('test')
    Execute Javascript    console.log(document.getElementsByClassName('total-num')[0].innerText)
    ${total-num}    Execute Javascript    return document.getElementsByClassName('total-num')[0].innerText
    链接数据库
    ${Collectionpres}    query    SELECT COUNT(id) FROM `case` WHERE collection_status=1 AND agent_company_id=5170
    ${total-query}    Set Variable    ${Collectionpres[0][0]}
    Should Be Equal As Numbers    ${total-num}    ${total-query}
    关闭数据库
    Click Element    //*[@id="reset-search-btn"]    #点击重置按钮

数据库
    链接数据库
    ${Collectionpres}    query    SELECT COUNT(id) FROM `case` WHERE collection_status=1 AND agent_company_id=5170
    log    ${Collectionpres}
    关闭数据库

当前逾期天数
    打开定制版
    Click Element    css=dt:nth-child(3) > a    #点击管理工作台
    Sleep    5
    Select Frame    //*[@id="iframe"]    #定位页面
    Click Element    xpath=//span[contains(.,'展开')]    #点击展开按钮
    Input Text    //*[@id="s_update_time_start"]    1    #输入上次跟进起始天数
    Input Text    //*[@id="s_update_time_end"]    100    #输入上次跟进起始天数
    Sleep    3
    Click Element    //*[@id="search-list-btn"]    #点击查询按钮
    Sleep    10
    Click Element    //*[@id="reset-search-btn"]    #点击重置按钮

手动分单
    打开定制版
    Click Element    css=dt:nth-child(3) > a    #点击管理工作台
    Sleep    5
    Select Frame    //*[@id="iframe"]    #定位页面
    Execute Javascript    document.getElementById('manual-distribute-list').click()    #点击手动分单按钮
    Sleep    3
    Click Element    css=#fd-status .select-input    #点击催收状态
    sleep    2
    Click Element    xpath=//span[contains(text(),'已分单未催收')]    #点击已分单未催收
    ${total-num}    Execute Javascript    return document.getElementById('number-money').getElementsByClassName('org-font')[0].innerText
    链接数据库
    ${Collectionpres}    query    SELECT COUNT(id) FROM `case` WHERE collection_status=1 AND agent_company_id=5170
    ${total-query}    Set Variable    ${Collectionpres[0][0]}
    Should Be Equal As Numbers    ${total-num}    ${total-query}
    关闭数据库
    Click Element    /html/body/div[31]/div[2]/div[3]/div[4]/button    #点击重置按钮

距上次跟进天数
    打开定制版
    Click Element    css=dt:nth-child(3) > a    #点击管理工作台
    Sleep    5
    Select Frame    //*[@id="iframe"]    #定位页面
    Click Element    xpath=//span[contains(.,'展开')]    #点击展开按钮
    Input Text    //*[@id="s_start_end_time"]    1    #输入上次跟进起始天数
    Input Text    //*[@id="s_end_end_time"]    100    #输入上次跟进起始天数
    Sleep    3
    Click Element    //*[@id="search-list-btn"]    #点击查询按钮
    Sleep    10
    Click Element    //*[@id="reset-search-btn"]    #点击重置按钮

*** Keywords ***
登录
    [Arguments]    ${username}    ${password}
    Open Browser    https://console-staging.lbondtech.com/    chrome    #打开浏览器
    Maximize Browser Window    #浏览器最大化
    Input Text    //*[@id="app"]/div/div[1]/div/span[1]/div/input    ${username}    #输入正确的用户名
    Input Password    //*[@id="app"]/div/div[1]/div/span[2]/div/input    ${password}    #输入正确的密码
    Click Element    //*[@id="app"]/div/div[1]/div/button    #点击登录按钮
    Sleep    3    #等待3秒
    Page Should Contain    我的产品    #断言包含我的产品
    Comment    Page Should Contain    验证    #断言输入登录失败时会出现验证

打开定制版
    登录    ceshidl@163.com    Zichan360    #输入账号    #输入密码
    sleep    5
    Mouse Up    //*[@id="app"]/div/section/header/div[1]/div/div/span    #悬停我的产品
    Click Element    css=.el-dropdown-menu__item:nth-child(2) > a:nth-child(1)    #点击定制版
    sleep    20
    ${titles}    Get Window Titles
    ${titles2}    Get From List    ${titles}    1
    ${titles1}    Get From List    ${titles}    0
    Select Window    title=${titles2}
    Sleep    5
    ${gonggao}=    Run Keyword And Return Status    Element Should Be Visible    //*[@id="j-adv_sub"]
    Run Keyword If    '${gonggao}'=='True'    Run Keywords    Click Element    //*[@id="j-adv_sub"]
    ...    AND    Execute Javascript    document.getElementById('audit-wrapper2').scrollTop=10000
    ...    AND    sleep    62
    ...    AND    Click Element    id=audit-btn2
    Sleep    5

链接数据库
    Connect To Database Using Custom Params    pymysql    database='zichan360_case',user='anjiayao', passwd='Na8VWPqkzsOk', host='rm-8vbghr18k32e322r3o.mysql.zhangbei.rds.aliyuncs.com',port=3306

关闭数据库
    Disconnect From Database    #关闭数据库
