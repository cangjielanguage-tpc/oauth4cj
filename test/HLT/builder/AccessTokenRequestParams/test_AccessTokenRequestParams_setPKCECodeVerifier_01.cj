// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import builder.*

@Test
public class TestAccessTokenRequestParamsB005{
    /***
        public static func create(code: String): AccessTokenRequestParams
        测试场景:根据调用源返回
    ***/
    @TestCase
    func testAccessTokenRequestParamsSetPKCECodeVerifier01(): Unit {
        var accessTokenRequestParams01=AccessTokenRequestParams("code")
        var accessTokenRequestParams02=AccessTokenRequestParams.create("code")

        accessTokenRequestParams01.setPKCECodeVerifier("strValue")
        accessTokenRequestParams02.setPKCECodeVerifier("strValue")
        @Assert(accessTokenRequestParams01.getPkceCodeVerifier(),"strValue")
        @Assert(accessTokenRequestParams02.getPkceCodeVerifier(),"strValue")

        accessTokenRequestParams01.setPKCECodeVerifier("")
        accessTokenRequestParams02.setPKCECodeVerifier("")
        @Assert(accessTokenRequestParams01.getPkceCodeVerifier(),"")
        @Assert(accessTokenRequestParams02.getPkceCodeVerifier(),"")
    }
}