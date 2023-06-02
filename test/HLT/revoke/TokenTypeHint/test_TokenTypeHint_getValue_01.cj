// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import revoke.*

@Test
public class TestTokenTypeHintB004{
    /***
        public func getValue(): String
        测试场景:获取枚举token的内容
    ***/
    @TestCase
    func testTokenTypeHintgetValue01(): Unit {
        var tokentypehint01=TokenTypeHint.ACCESS_TOKEN_HINT
        var tokentypehint02=TokenTypeHint.REFRESH_TOKEN_HINT
        var res01=tokentypehint01.getValue()
        var res02=tokentypehint02.getValue()
        @Assert(res01,"access_token_hint")
        @Assert(res02,"refresh_token_hint")
    }
}