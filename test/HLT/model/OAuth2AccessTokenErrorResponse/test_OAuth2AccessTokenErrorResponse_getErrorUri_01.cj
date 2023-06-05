// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from std import collection.*
from oauth4cj import model.*
from oauth4cj import oauth2.*
from encoding import url.*

@Test
public class TestOAuth2AccessTokenErrorResponseB004{
    /***
        public init(error: OAuth2Error, errorDescription: String, errorUrl: URL, rawResponse: Response)
        public func getErrorUri(): URL
        测试场景:与构造器传入一致
    ***/
    @TestCase
    func testOAuth2AccessTokenErrorResponseGetErrorUri01(): Unit {
        var error=OAuth2Error.INVALID_REQUEST
        var url=URL.parse("https://www.baidu.com")
        var response=Response(Int32(2),"message",HashMap<String,String>(),"body")
        var oAuth2AccessTokenErrorResponse=OAuth2AccessTokenErrorResponse(error,"errorDescription",url,response)
        @Assert(oAuth2AccessTokenErrorResponse.getErrorUri().toString(),url.toString())
    }
}