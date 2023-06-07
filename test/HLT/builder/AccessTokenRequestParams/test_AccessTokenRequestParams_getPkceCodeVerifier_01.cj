// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import util.*
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
        var result01 = false
        var result02 = false 

        match (accessTokenRequestParams01.getPkceCodeVerifier()) {
            case Some(x) => result01 = false
            case None => result01 = true // 默认为None
        }

        match (accessTokenRequestParams02.getPkceCodeVerifier()) {
            case Some(x) => result02 = false
            case None => result02 = true // 默认为None
        }

        @Assert(result01)
        @Assert(result02)
    }
}