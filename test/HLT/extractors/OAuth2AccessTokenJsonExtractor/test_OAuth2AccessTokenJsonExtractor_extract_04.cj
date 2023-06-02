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
        测试场景:responseCode!=200,response中body非空
    ***/
    @TestCase
    func testOAuth2AccessTokenJsonExtractorExtract04(): Unit {
        var oAuth2AccessTokenJsonExtractor02=OAuth2AccessTokenJsonExtractor.instance()
        var body=###"{
"error_uri":"http://www.baidu.com",
"error":"slow_down",
"error_description":"error_description",
"expires_in":"expires_in",
"token_type":"token_type",
"refresh_token":"refresh_token",
"scope":"scope",
"access_token":"access_token"}"###
        var response01=Response(Int32(201),"message",HashMap<String,String>(),body)
        var flag=1
        try{
            oAuth2AccessTokenJsonExtractor02.extract(response01)
        }catch(e:OAuth2AccessTokenErrorResponse){//这里只验证到抛异常，具体异常信息在generateError逻辑中验证
            flag=0
        }
        @Assert(flag,0)
    }
}

