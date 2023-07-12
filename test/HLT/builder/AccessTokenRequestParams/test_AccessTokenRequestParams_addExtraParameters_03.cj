// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj


@Test
public class TestAccessTokenRequestParamsB005{
    /***
         public func addExtraParameters(extraParameters: HashMap<String, String>): AccessTokenRequestParams
        测试场景: 已有参数添加一个空map
    ***/
    @TestCase
    func testAccessTokenRequestParamsAddExtraParameters03(): Unit {
        var accessTokenRequestParams01=AccessTokenRequestParams("code")
        var accessTokenRequestParams02=AccessTokenRequestParams.create("code")
        var map01=HashMap<String, String>([("key01","value01"),("key02","value02")])
        var map02=HashMap<String, String>()
        let re01=accessTokenRequestParams01.addExtraParameters(map01)
        let re02=accessTokenRequestParams01.addExtraParameters(map02)
        let re03=accessTokenRequestParams02.addExtraParameters(map01)
        let re04=accessTokenRequestParams02.addExtraParameters(map02)

        @Assert(accessTokenRequestParams01.getExtraParameters(),map01)
        @Assert(accessTokenRequestParams02.getExtraParameters(),map01)
        @Assert(re01.getExtraParameters(),map01)
        @Assert(re02.getExtraParameters(),map01)
        @Assert(re03.getExtraParameters(),map01)
        @Assert(re04.getExtraParameters(),map01)
    }
}