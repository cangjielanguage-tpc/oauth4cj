// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp

from std import unittest.*
from std import unittest.testmacro.*
from std import collection.*
from oauth4cj import util.*

@Test
public class TestAccessTokenRequestParamsB005{
    /***
        public func setExtraParameters(extraParameters: HashMap<String, String>): AccessTokenRequestParams
        测试场景: 首次设置,设置非空map
    ***/
    @TestCase
    func testAccessTokenRequestParamsSetExtraParameters02(): Unit {
        var accessTokenRequestParams01=AccessTokenRequestParams("code")
        var accessTokenRequestParams02=AccessTokenRequestParams.create("code")

        var map02=HashMap<String, String>([("key01","value01"),("key02","value02")])
        
        let re01=accessTokenRequestParams01.setExtraParameters(map02)
        let re02=accessTokenRequestParams02.setExtraParameters(map02)
        @Assert(accessTokenRequestParams01.getExtraParameters(),map02)
        @Assert(accessTokenRequestParams02.getExtraParameters(),map02)
        @Assert(re01.getExtraParameters(),map02)
        @Assert(re02.getExtraParameters(),map02)
    }
}