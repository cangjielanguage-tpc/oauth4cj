// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import builder.*
@Test
public class TestAccessTokenRequestParamsB005{
    /***
        public func GetScope(): String
        测试场景: 默认构造器
    ***/
    @TestCase
    func testAccessTokenRequestParamsGetScope01(): Unit {
        var accessTokenRequestParams01=AccessTokenRequestParams("code")
        var accessTokenRequestParams02=AccessTokenRequestParams.create("code")
        @Assert(accessTokenRequestParams01.getScope(),"")
        @Assert(accessTokenRequestParams02.getScope(),"")
    }
}