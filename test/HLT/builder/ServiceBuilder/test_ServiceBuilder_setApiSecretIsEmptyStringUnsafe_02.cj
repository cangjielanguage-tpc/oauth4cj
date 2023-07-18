// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj

@Test
public class TestServiceBuilderB004{
    /***
        public func setApiSecretIsEmptyStringUnsafe(): ServiceBuilder
        测试场景:验证字符串是否为空-设置后调用
    ***/
    @TestCase
    func testServiceBuildersetApiSecret01(): Unit {
        var serviceBuilder01=ServiceBuilderOAuth10a("abc")
        var subDefaultApi10a=SubDefaultApi10a()

        let apiSecret="hello cangjie"

        serviceBuilder01.setApiSecret(apiSecret)
        let oauth10aService01=serviceBuilder01.build(subDefaultApi10a)
        @Assert(oauth10aService01.getApiSecret(),apiSecret)

        serviceBuilder01.setApiSecretIsEmptyStringUnsafe()
        let oauth10aService02=serviceBuilder01.build(subDefaultApi10a)
        @Assert(oauth10aService02.getApiSecret(),"")


        var serviceBuilder02=ServiceBuilderOAuth20("abc")
        var subDefaultApi20=SubDefaultApi20()
        serviceBuilder02.setApiSecret(apiSecret)
        let oAuth20Service01=serviceBuilder02.build(subDefaultApi20)
        @Assert(oAuth20Service01.getApiSecret(),apiSecret)

        serviceBuilder02.setApiSecretIsEmptyStringUnsafe()
        let oAuth20Service02=serviceBuilder02.build(subDefaultApi20)
        @Assert(oAuth20Service02.getApiSecret(),"")
    }
}