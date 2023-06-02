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
        测试场景:response中code==200,但是body非空,匹配到access_token=([^&]+),token_type=([^&]+),expires_in=([^&]+),refresh_token=([^&]+),scope=([^&]+),且expires_in超过In32最大值
    ***/
    @TestCase
    func testOAuth2AccessTokenExtractorExtract01(): Unit {
        var oauth2AccessTokenExtractor02=OAuth2AccessTokenExtractor.instance()
        var int32Max=(Int64(Int32.Max)+1).toString()
        var body="access_token=access_token&token_type=token_type&expires_in=${int32Max}&refresh_token=refresh_token&scope=scope"
        var response01=Response(Int32(200),"message",HashMap<String,String>(),body)
        var oauth2AccessToken02=oauth2AccessTokenExtractor02.extract(response01)

        @Assert(oauth2AccessToken02.getExpiresIn(),Int32(0))
    }
}