// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import model.*
from std import collection.*
from oauth4cj import extractors.*
from oauth4cj import exceptions.*
@Test
public class TestOAuth1RequestTokenJSONExtractorB004{
    /***
        public func extract(response: Response): OAuth1RequestToken
        测试场景:response中body为空
    ***/
    @TestCase
    func testOAuth1RequestTokenJSONExtractorExtract01(): Unit {
        var oauth1RequestTokenJSONExtractor02=OAuth1RequestTokenJSONExtractor.instance()
        var response01=Response(Int32(2),"message",HashMap<String,String>(),"")
        var flag=1
        try{
            oauth1RequestTokenJSONExtractor02.extract(response01)
        }catch(e:IllegalArgumentException){
            if(e.toString().contains("Response body is incorrect. Can't extract a token from an empty string")){
                flag=0
            }
        }
        @Assert(flag,0)
    }
}