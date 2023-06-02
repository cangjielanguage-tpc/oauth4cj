// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import model.*
from std import collection.*
from oauth4cj import extractors.*
from oauth4cj import exceptions.*
@Test
public class TestOAuth2AccessTokenJsonExtractorB004{
    /***
        public func extract(response: Response): OAuth2AccessToken
        测试场景:response中body非空,但是responseCode=200,不包含access_token，包含其他
    ***/
    @TestCase
    func testOAuth2AccessTokenJsonExtractorExtract03(): Unit {
        var oAuth2AccessTokenJsonExtractor02=OAuth2AccessTokenJsonExtractor.instance()
        var body=###"{
"error_uri":"http://www.baidu.com",
"error":"slow_down",
"error_description":"error_description",
"expires_in":2,
"token_type":"token_type",
"refresh_token":"refresh_token",
"scope":"scope"}"###
        var response01=Response(Int32(200),"message",HashMap<String,String>(),body)

        var flag=1
        try{
            oAuth2AccessTokenJsonExtractor02.extract(response01)
        }catch(e:OAuth4cjException){
            if(e.toString().contains("Response body is incorrect. Can't extract a '" + "access_token" + "' from this: '" + body + "'")){
                flag=0
            }
        }
        @Assert(flag,0)
    }
}

