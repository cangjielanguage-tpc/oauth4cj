// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import model.*
from oauth4cj import builder.*
from oauth4cj import extractors.*

@Test
public class TestDefaultApi10aB004{
    /***
        public func getAccessTokenExtractor(): TokenExtractor<OAuth1AccessToken>
        测试场景:能生成TokenExtractor<OAuth1AccessToken>即可
    ***/
    @TestCase
    func testDefaultApi10aGetAccessTokenExtractor01(): Unit {
        var subDefaultApi10a=SubDefaultApi10a()
        let accessTokenExtractor=subDefaultApi10a.getAccessTokenExtractor()
        @Assert(accessTokenExtractor is TokenExtractor<OAuth1AccessToken>,true)
        @Assert(accessTokenExtractor is OAuth1AccessTokenExtractor,true)
    }
}
