// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestServiceBuilderB004{
    /***
        public func setApiSecret(apiKey: String): ServiceBuilder
        测试场景:验证字符串是否为空-否
    ***/
    @TestCase
    func testServiceBuildersetApiSecret01(): Unit {
        var serviceBuilder01=ServiceBuilderOAuth10a("abc")
        var subDefaultApi10a=SubDefaultApi10a()
        serviceBuilder01.setApiSecret("str")
        let oAuth10aService=serviceBuilder01.build(subDefaultApi10a)
        @Assert(oAuth10aService.getApiSecret(),"str")

        var serviceBuilder02=ServiceBuilderOAuth20("abc")
        var subDefaultApi20=SubDefaultApi20()
        serviceBuilder02.setApiSecret("str")
        let oauth20Service=serviceBuilder02.build(subDefaultApi20)
        @Assert(oauth20Service.getApiSecret(),"str")
    }
}