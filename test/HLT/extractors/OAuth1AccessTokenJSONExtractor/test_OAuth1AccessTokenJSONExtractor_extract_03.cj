// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import model.*
from std import collection.*
from oauth4cj import extractors.*

@Test
public class TestOAuth1AccessTokenJsonExtractorB004{
    /***
        public func extract(response: Response): OAuth2AccessToken
        测试场景:response中body非空,包含access_token，同时不包含oauth_token_secret
    ***/
    @TestCase
    func testOAuth1AccessTokenJsonExtractorExtract03(): Unit {
        var oauth1AccessTokenJsonExtractor02=OAuth1AccessTokenJSONExtractor.instance()
        var body=###"{"access_token":"dadadsasdada"}"###
        var response01=Response(Int32(200),"message",HashMap<String,String>(),body)
        var flag=1
        try{
            oauth1AccessTokenJsonExtractor02.extract(response01)
        }catch(e:Exception){
            if(e.toString().contains("Exception: Response body is incorrect. Can't extract token and secret from this: '"+body+"'")){
                flag=0
            }
        }
        @Assert(flag,0)
    }
}

