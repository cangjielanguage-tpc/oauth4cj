// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import std.collection.*

public import oauth4cj.*

main() {

    var test_01 = testOAuth1AccessTokenJsonExtractorExtract03()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    return test_01
}

/***
    public func extract(response: Response): OAuth2AccessToken
    测试场景:response中body非空,包含access_token，同时不包含oauth_token_secret
***/
func testOAuth1AccessTokenJsonExtractorExtract03(): Int64 {
    var oauth1AccessTokenJsonExtractor02=OAuth1AccessTokenJSONExtractor.instance()
    var body=###"{"access_token":"dadadsasdada"}"###
    var response01=OAuth4cjResponse(Int32(200),"message",HashMap<String,String>(),body)
    var flag: Int64 = 1
    try{
        oauth1AccessTokenJsonExtractor02.extract(response01)
    }catch(e: OAuth4cjException){
        println(e.message)
        if(e.message.contains("Response body is incorrect. Can't extract token and secret from this: '${body}'")){
            flag = 0
        }
    }
    return flag
}


