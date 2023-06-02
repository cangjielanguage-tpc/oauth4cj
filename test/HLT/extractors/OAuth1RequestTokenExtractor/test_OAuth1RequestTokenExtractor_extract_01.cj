// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import model.*
from std import collection.*
from oauth4cj import extractors.*
from oauth4cj import exceptions.*
@Test
public class TestOAuth1RequestTokenExtractorB004{
    /***
        public func extract(response: Response): OAuth1AccessToken
        测试场景:response中body是空字符串
    ***/
    @TestCase
    func testOAuth1RequestTokenExtractorExtract01(): Unit {
        var oauth1RequestTokenExtractor01=OAuth1RequestTokenExtractor.instance()
        var body=""
        var response01=Response(Int32(2),"message",HashMap<String,String>(),body)
        var flag=0
        try{
            oauth1RequestTokenExtractor01.extract(response01)
        }catch(e:IllegalArgumentException){

            if(e.toString().contains("Response body is incorrect. Can't extract a token from an empty string")){
                flag=1
            }
        }
        @Assert(flag,1)
    }
}