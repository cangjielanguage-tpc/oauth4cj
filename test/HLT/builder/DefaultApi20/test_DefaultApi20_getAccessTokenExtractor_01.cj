// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import model.*
from oauth4cj import builder.*
from oauth4cj import extractors.*

@Test
public class TestDefaultApi20B004{
    /***
        public func getAccessTokenExtractor(): TokenExtractor<OAuth2AccessToken>
        测试场景:构造器默认
    ***/
    @TestCase
    func testDefaultApi20GetAccessTokenExtractor01(): Unit {
        var subDefaultApi20=SubDefaultApi20()
        var accessTokenExtractor=subDefaultApi20.getAccessTokenExtractor()
        @Assert(accessTokenExtractor is OAuth2AccessTokenJsonExtractor, true)
        @Assert(accessTokenExtractor is TokenExtractor<OAuth2AccessToken>, true)
    }
}