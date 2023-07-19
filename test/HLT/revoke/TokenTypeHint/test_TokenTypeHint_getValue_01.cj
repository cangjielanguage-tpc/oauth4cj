// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


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