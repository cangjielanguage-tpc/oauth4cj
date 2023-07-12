// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj

@Test
public class TestServiceBuilderB004{
    /***
        public func setApiSecretIsEmptyStringUnsafe(): ServiceBuilder
        测试场景:验证字符串是否为空-默认调用
    ***/
    @TestCase
    func testServiceBuildersetApiSecret01(): Unit {
        var serviceBuilder01=ServiceBuilderOAuth10a("abc")
        serviceBuilder01.setApiSecretIsEmptyStringUnsafe()

        var subDefaultApi10a=SubDefaultApi10a()
        let oAuth10aService=serviceBuilder01.build(subDefaultApi10a)
        @Assert(oAuth10aService.getApiSecret(),"")


        var serviceBuilder02=ServiceBuilderOAuth20("abc")
        serviceBuilder02.setApiSecretIsEmptyStringUnsafe()
        var subDefaultApi20=SubDefaultApi20()
        let oAuth20Service=serviceBuilder02.build(subDefaultApi20)
        @Assert(oAuth20Service.getApiSecret(),"")
    }
}