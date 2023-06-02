// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import builder.*
@Test
public class TestAccessTokenRequestParamsB005{
    /***
        public func getPkceCodeVerifier(): String
        测试场景: 默认构造器
    ***/
    @TestCase
    func testAccessTokenRequestParamsGetPkceCodeVerifier01(): Unit {
        var accessTokenRequestParams01=AccessTokenRequestParams("code")
        var accessTokenRequestParams02=AccessTokenRequestParams.create("code")
        @Assert(accessTokenRequestParams01.getPkceCodeVerifier(),"")
        @Assert(accessTokenRequestParams02.getPkceCodeVerifier(),"")
    }
}