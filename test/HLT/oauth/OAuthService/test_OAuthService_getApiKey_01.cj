// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj

@Test
public class TestOAuthServiceB008{
    /***
        public open func getApiKey(): String
        测试场景:与构造器传入一致即可,验证不同的子类实现
    ***/

    var serviceType=""
    @TestCase
    func testOAuthServiceGetApiKey01(): Unit {
        var oauth10aService=OAuthServiceTest.getOAuth10aService()
        serviceType="OAuth10aService"
        var re_apiKey=oauth10aService.getApiKey()
        @Assert(re_apiKey,serviceType+OAuthServiceTest.apiKey)
    }

    @TestCase
    func testOAuthServiceGetApiKey02(): Unit {
         var oauth20Service=OAuthServiceTest.getOAuth20Service()
         serviceType="OAuth20Service"
         var re_apiKey=oauth20Service.getApiKey()
         @Assert(re_apiKey,serviceType+OAuthServiceTest.apiKey)
    }
}