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
        测试场景:response中code!=200
    ***/
    @TestCase
    func testOAuth2AccessTokenExtractorExtract01(): Unit {
        var oauth2AccessTokenExtractor=OAuth2AccessTokenExtractor.instance()
        var response01=Response(Int32(2),"message",HashMap<String,String>(),"")
        var flag=1
        try{
            oauth2AccessTokenExtractor.extract(response01)
        }catch(e:OAuth4cjException){
            if(e.toString().contains("Response code is not 200 but")){
                flag=0
            }
        }
        @Assert(flag,0)
    }
}