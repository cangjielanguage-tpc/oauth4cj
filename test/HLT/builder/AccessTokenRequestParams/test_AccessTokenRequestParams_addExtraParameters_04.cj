// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestAccessTokenRequestParamsB005{
    /***
         public func addExtraParameters(extraParameters: HashMap<String, String>): AccessTokenRequestParams
        测试场景: 已有参数添加一个非空map，且存在与已有参数重复key的map
    ***/
    @TestCase
    func testAccessTokenRequestParamsAddExtraParameters03(): Unit {
        var accessTokenRequestParams01=AccessTokenRequestParams("code")
        var accessTokenRequestParams02=AccessTokenRequestParams.create("code")
        var map01=HashMap<String, String>([("key01","value01"),("key02","value02")])
        var map02=HashMap<String, String>([("key03","value03"),("key02","value02")])
        var exp_map=HashMap<String, String>([("key01","value01"),("key02","value02"),("key03","value03")])

        let re01=accessTokenRequestParams01.addExtraParameters(map01)
        let re02=accessTokenRequestParams01.addExtraParameters(map02)
        let re03=accessTokenRequestParams02.addExtraParameters(map01)
        let re04=accessTokenRequestParams02.addExtraParameters(map02)

        @Assert(accessTokenRequestParams01.getExtraParameters(),exp_map)
        @Assert(accessTokenRequestParams02.getExtraParameters(),exp_map)
        @Assert(re01.getExtraParameters(),exp_map)
        @Assert(re02.getExtraParameters(),exp_map)
        @Assert(re03.getExtraParameters(),exp_map)
        @Assert(re04.getExtraParameters(),exp_map)
    }
}