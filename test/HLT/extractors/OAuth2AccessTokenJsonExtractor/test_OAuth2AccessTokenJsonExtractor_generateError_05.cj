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
        public func generateError(response: Response): Unit
        测试场景:
        response中body不为空，且可解析成json字符串,
        且包含key("error_uri"),
        包含("error"),但是error信息是OAuth2Error的errorString,
        但是key不包含error_description
    ***/
    @TestCase
    func testOAuth2AccessTokenJsonExtractorGenerateError05(): Unit {
        var oAuth2AccessTokenJsonExtractor02=OAuth2AccessTokenJsonExtractor.instance()
        var body=###"{
"error_uri":"http://www.baidu.com",
"error":"slow_down",
"expires_in":"expires_in",
"token_type":"token_type",
"refresh_token":"refresh_token",
"scope":"scope",
"access_token":"access_token"}"###
        var response01=Response(Int32(2),"message",HashMap<String,String>(),body)
        var flag=1
        try{
            oAuth2AccessTokenJsonExtractor02.generateError(response01)
        }catch(e:OAuth2AccessTokenErrorResponse){
            flag=0
            var error=e.getError().getOrThrow()
            @Assert(error.getErrorString(),"slow_down")
        }
        @Assert(flag,0)
    }
}