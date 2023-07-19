// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj

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

        var result01 = false
        var result02 = false 

        match (accessTokenRequestParams01.getScope()) {
            case Some(x) =>
                println(x)
                result01 = false
            case None => result01 = true // 默认为None
        }

        match (accessTokenRequestParams02.getScope()) {
            case Some(x) =>
                println(x)
                result02 = false
            case None => result02 = true // 默认为None
        }

        @Assert(result01)
        @Assert(result02)
    }
}