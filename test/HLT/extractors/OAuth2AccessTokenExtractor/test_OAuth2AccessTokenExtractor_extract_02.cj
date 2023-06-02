// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import model.*
from std import collection.*
from oauth4cj import extractors.*
from oauth4cj import exceptions.*
@Test
public class TestOAuth2AccessTokenExtractorB004{
    /***
        public func extract(response: Response): OAuth2AccessToken
        测试场景:response中code==200,但是body为空
    ***/
    @TestCase
    func testOAuth2AccessTokenExtractorExtract01(): Unit {
        var oauth2AccessTokenExtractor=OAuth2AccessTokenExtractor.instance()
        var response01=Response(Int32(200),"message",HashMap<String,String>(),"")
        var flag=1
        try{
            oauth2AccessTokenExtractor.extract(response01)
        }catch(e:IllegalArgumentException){
            if(e.toString().contains("Response body is incorrect. Can't extract a token from an empty string")){
                flag=0
            }
        }
        @Assert(flag,0)
    }
}