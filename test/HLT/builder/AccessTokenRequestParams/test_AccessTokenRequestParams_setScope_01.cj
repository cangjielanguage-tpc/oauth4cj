// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj

@Test
public class TestAccessTokenRequestParamsB005{
    /***
        public static func create(code: String): AccessTokenRequestParams
        测试场景:设置成功，根据调用源返回
    ***/
    @TestCase
    func testAccessTokenRequestParamsSetScope01(): Unit {
        var accessTokenRequestParams01=AccessTokenRequestParams("code")
        var accessTokenRequestParams02=AccessTokenRequestParams.create("code")
        let re01=accessTokenRequestParams01.setScope("strValue")
        let re02=accessTokenRequestParams02.setScope("strValue")
        @Assert(accessTokenRequestParams01.getScope(),"strValue")
        @Assert(accessTokenRequestParams02.getScope(),"strValue")
        @Assert(re01 is AccessTokenRequestParams,true)
        @Assert(re02 is AccessTokenRequestParams,true)
    }
}