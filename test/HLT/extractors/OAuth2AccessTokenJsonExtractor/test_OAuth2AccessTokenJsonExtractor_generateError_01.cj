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
        测试场景:response中body不为空，但无法解析成json字符串
    ***/
    @TestCase
    func testOAuth2AccessTokenJsonExtractorGenerateError01(): Unit {
        var oAuth2AccessTokenJsonExtractor02=OAuth2AccessTokenJsonExtractor.instance()
        var response01=Response(Int32(2),"message",HashMap<String,String>(),"value")
        var flag=1
        try{
            oAuth2AccessTokenJsonExtractor02.generateError(response01)
        }catch(e:OAuth2AccessTokenErrorResponse){
            flag=0
            var error_re=e.getResponse().toString()
            var error_exp=response01.toString()
            @Assert(error_exp,error_re)
        }
        @Assert(flag,0)
    }
}