// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestServiceBuilderB004{
    /***
        public func setResponseType(responseType: String): ServiceBuilderOAuth20
        测试场景:验证字符串是否为空-否
    ***/
    @TestCase
    func testServiceBuildersetResponseType02(): Unit {
        var serviceBuilder01=ServiceBuilderOAuth20("abc")
        var subDefaultApi20=SubDefaultApi20()
        var str="andfsopfks"
        serviceBuilder01.setResponseType(str)
        let OAuth20Service=serviceBuilder01.build(subDefaultApi20)
        @Assert(OAuth20Service.getResponseType(),str)
    }
}