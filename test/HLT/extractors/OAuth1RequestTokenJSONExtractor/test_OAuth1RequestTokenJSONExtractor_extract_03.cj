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
        测试场景:response中body非空,包含oauth_token，同时不包含oauth_token_secret
    ***/
    @TestCase
    func testOAuth1RequestTokenJSONExtractorExtract03(): Unit {
        var oauth1RequestTokenJSONExtractor02=OAuth1RequestTokenJSONExtractor.instance()
        var body=###"{"oauth_token":"dadadsasdada"}"###
        var response01=Response(Int32(200),"message",HashMap<String,String>(),body)
        var flag=1
        try{
            oauth1RequestTokenJSONExtractor02.extract(response01)
        }catch(e:OAuth4cjException){
            if(e.toString().contains("Response body is incorrect. Can't extract token and secret from this: '" + body + '\'')){
                flag=0
            }
        }
        @Assert(flag,0)
    }
}

