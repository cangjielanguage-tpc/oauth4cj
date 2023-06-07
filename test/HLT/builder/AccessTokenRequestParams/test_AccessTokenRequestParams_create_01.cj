// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from std import collection.*
from oauth4cj import util.*

@Test
public class TestAccessTokenRequestParamsB005{
    /***
        public static func create(code: String): AccessTokenRequestParams
        测试场景:根据调用源返回
    ***/
    @TestCase
    func testAccessTokenRequestParamsCreate01(): Unit {
        var accessTokenRequestParams01=AccessTokenRequestParams("")
        var accessTokenRequestParams02=AccessTokenRequestParams.create("")
        @Assert(accessTokenRequestParams01.getCode(),"")
        @Assert(accessTokenRequestParams02.getCode(),"")
        accessTokenRequestParams01=AccessTokenRequestParams("strValue")
        accessTokenRequestParams02=AccessTokenRequestParams.create("strValue")
        @Assert(accessTokenRequestParams01.getCode(),"strValue")
        @Assert(accessTokenRequestParams02.getCode(),"strValue")
    }
}