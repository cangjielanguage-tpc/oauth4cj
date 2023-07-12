// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj


@Test
public class TestAccessTokenRequestParamsB005{
    /***
        public func setExtraParameters(extraParameters: HashMap<String, String>): AccessTokenRequestParams
        测试场景: 首次设置,设置一个空的map
    ***/
    @TestCase
    func testAccessTokenRequestParamsSetExtraParameters01(): Unit {
        var accessTokenRequestParams01=AccessTokenRequestParams("code")
        var accessTokenRequestParams02=AccessTokenRequestParams.create("code")

        var map01=HashMap<String, String>()

        let re01=accessTokenRequestParams01.setExtraParameters(map01)
        let re02=accessTokenRequestParams02.setExtraParameters(map01)
        @Assert(accessTokenRequestParams01.getExtraParameters(),map01)
        @Assert(accessTokenRequestParams02.getExtraParameters(),map01)
        @Assert(re01.getExtraParameters(),map01)
        @Assert(re02.getExtraParameters(),map01)
    }
}