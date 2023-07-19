// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj

@Test
public class TestOAuthServiceB008{
    /***
        public open func getApiSecret(): String
        测试场景:与构造器传入一致即可,验证不同的子类实现
    ***/

    var serviceType=""
    @TestCase
    func testOAuthServiceGetApiSecret01(): Unit {
         var oauth10aService=OAuthServiceTest.getOAuth10aService()
         serviceType="OAuth10aService"
         var re_apiSecret=oauth10aService.getApiSecret()
         @Assert(re_apiSecret,serviceType+OAuthServiceTest.apiSecret)
    }
    @TestCase
    func testOAuthServiceGetApiSecret02(): Unit {
         var oauth20Service=OAuthServiceTest.getOAuth20Service()
         serviceType="OAuth20Service"
         var re_apiSecret=oauth20Service.getApiSecret()
         @Assert(re_apiSecret,serviceType+OAuthServiceTest.apiSecret)
    }
}