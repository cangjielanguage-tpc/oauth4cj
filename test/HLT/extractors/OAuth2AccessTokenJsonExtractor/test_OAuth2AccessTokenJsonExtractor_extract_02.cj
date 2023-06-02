// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import model.*
from std import collection.*
from oauth4cj import extractors.*

@Test
public class TestOAuth2AccessTokenJsonExtractorB004{
    /***
        public func extract(response: Response): OAuth2AccessToken
        测试场景:responseCode=200,response中body非空,且校验参数均包含
    ***/
    @TestCase
    func testOAuth2AccessTokenJsonExtractorExtract02(): Unit {
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
        var response01=Response(Int32(200),"message",HashMap<String,String>(),body)
        var re02=oAuth2AccessTokenJsonExtractor02.extract(response01)
        @Assert(re02.getAccessToken(),"access_token")
        @Assert(re02.getTokenType(),"token_type")
        @Assert(re02.getExpiresIn(),Int32(0))
        @Assert(re02.getRefreshToken(),"refresh_token")
        @Assert(re02.getScope(),"scope")
    }
}

