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
        测试场景:response中body非空,包含access_token，同时包含oauth_token_secret
    ***/
    @TestCase
    func testOAuth1AccessTokenJsonExtractorExtract04(): Unit {
        var oauth1AccessTokenJsonExtractor02 = OAuth1AccessTokenJSONExtractor.instance()
        var body=###"{"oauth_token":"dadadsasdada","oauth_token_secret":"dadadsasdada"}"###
        var response01=Response(Int32(200),"message",HashMap<String,String>(),body)

        var oauth1AccessToken02=oauth1AccessTokenJsonExtractor02.extract(response01)

        @Assert(oauth1AccessToken02 is OAuth1AccessToken,true)
        @Assert(oauth1AccessToken02.getToken(),"dadadsasdada")
        @Assert(oauth1AccessToken02.getTokenSecret(),"dadadsasdada")
        @Assert(oauth1AccessToken02.getRawResponse(),body)

    }
}

