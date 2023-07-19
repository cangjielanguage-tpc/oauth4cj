// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


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