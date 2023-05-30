// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from std import collection.*

from oauth4cj import extractors.*
from oauth4cj import model.*
from oauth4cj import exceptions.*

main() {

    var test_01 = testOAuth1AccessTokenJsonExtractorExtract02()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    return test_01
}

/***
    public func extract(response: Response): OAuth2AccessToken
    测试场景:response中body非空,解析后json树不包含"oauth_token"
***/
func testOAuth1AccessTokenJsonExtractorExtract02(): Int64 {
    var oauth1AccessTokenJsonExtractor02=OAuth1AccessTokenJSONExtractor.instance()
    var body=###"{"error_uri":"http://www.baidu.com"}"###
    var response01=Response(Int32(200),"message",HashMap<String,String>(),body)
    var flag: Int64 = 1
    try{
        oauth1AccessTokenJsonExtractor02.extract(response01)
    }catch(e:OAuth4cjException){
        println(e.message)
        if(e.message.contains("Response body is incorrect. Can't extract token and secret from this: '${body}'")){
            flag = 0
        }
    }
   return flag
}


