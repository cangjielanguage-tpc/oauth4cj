// DEPENDENCE: ../common_Values.cj
// EXEC: cjc %import-path %L %l %f common_Values.cj
// EXEC: ./main

main (){

    let flag = testOAuth20ServiceGetAuthorizationUrl02()
    if (flag != 0){
        return flag
    }
    return flag
}

/***
    public func extractAuthorization(redirectLocation: String): OAuth2Authorization
    测试场景:redirectLocation包含字符'#',且包含?,有&,分割后所有值仅有一个=,且解码时异常，此处抛异常
***/
func testOAuth20ServiceGetAuthorizationUrl02(): Int64 {
    var oauth20Service=OAuthServiceTest.getOAuth20Service()
    let redirectLocation01="http://www.baidu.com?code=%2&state=stateValue#"
    let redirectLocation02="http://www.baidu.com?code=codeValue&state=%2#"
    let redirectLocation03="http://www.baidu.com?code=codeValue&name=%2#"
    var flag=1
    try{
       oauth20Service.extractAuthorization(redirectLocation01)
    }catch(e:OAuth4cjException){
        //e.printStackTrace()
        if(e.toString().contains("unsupported decoding.") && e.toString().contains("URLDecoder: Incomplete trailing escape (%) pattern")){
            flag=0
        }
    }
    if (flag != 0){
        return flag
    }

    println("flag = ${flag}")
    flag=2
    try{
        oauth20Service.extractAuthorization(redirectLocation02)
    }catch(e:OAuth4cjException){
        println(e.toString())
        if(e.toString().contains("unsupported decoding.") && e.toString().contains("URLDecoder: Incomplete trailing escape (%) pattern")){
            flag=0
        }
    }

    if (flag != 0){
        return flag
    }
    println("flag = ${flag}")

    let authorization: OAuth2Authorization = oauth20Service.extractAuthorization(redirectLocation03)
    if (!authorization.getCode().equals("codeValue")){
        return 3
    }
    return 0
}
