// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj

@Test
public class TestOAuth10aServiceB008{
    /***
        public func getAuthorizationUrl(requestToken: OAuth1RequestToken): String
        测试场景:结果与对标库逻辑一致
    ***/
    @TestCase
    func testOAuth10aServiceGetAuthorizationUrl01(): Unit {
         var oauth10aService=OAuthServiceTest.getOAuth10aService()
         var requestToken=OAuth1RequestToken("token","tokenSecret")
         var re_authorizationUrl=oauth10aService.getAuthorizationUrl(requestToken)

        let exp_api=OAuthServiceTest.api_oauth10aService
        let exp_authorizationUrl=exp_api.getAuthorizationUrl(requestToken)
        @Assert(re_authorizationUrl,exp_authorizationUrl)
    }
}