// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestAccessTokenRequestParamsB005{
    /***
        public func addExtraParameter(name: String, value: String): AccessTokenRequestParams
        测试场景: 重复添加,与之前已存在相同
    ***/
    @TestCase
    func testAccessTokenRequestParamsAddExtraParameters02(): Unit {
        var accessTokenRequestParams01=AccessTokenRequestParams("code")
        var accessTokenRequestParams02=AccessTokenRequestParams.create("code")

        var exp_map=HashMap<String, String>([("first","first")])

        let re01=accessTokenRequestParams01.addExtraParameter("first","first")
        let re02=accessTokenRequestParams01.addExtraParameter("first","first")
        let re03=accessTokenRequestParams02.addExtraParameter("first","first")
        let re04=accessTokenRequestParams02.addExtraParameter("first","first")

        @Assert(accessTokenRequestParams01.getExtraParameters(),exp_map)
        @Assert(accessTokenRequestParams02.getExtraParameters(),exp_map)
        @Assert(re01.getExtraParameters(),exp_map)
        @Assert(re02.getExtraParameters(),exp_map)
        @Assert(re03.getExtraParameters(),exp_map)
        @Assert(re04.getExtraParameters(),exp_map)
    }
}