// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj

@Test
public class TestOAuth20ServiceB008{
    /***
        public func getAuthorizationUrl(state: String): String
        测试场景:设置state入参非None
    ***/

    @TestCase
    func testOAuth20ServiceGetAuthorizationUrl0201(): Unit {
         var oauth20Service=OAuthServiceTest.getOAuth20Service()
         var re_authorizationUrl=oauth20Service.getAuthorizationUrl("OAuth20Service state")
         var exp_additionalParams=HashMap<String,String>()
         var exp_params = ParameterList(exp_additionalParams)
         exp_params.add(OAuthConstants.RESPONSE_TYPE, oauth20Service.getResponseType());
         exp_params.add(OAuthConstants.CLIENT_ID, oauth20Service.getApiKey());
         exp_params.add(OAuthConstants.REDIRECT_URI, oauth20Service.getCallback().getOrThrow());
         exp_params.add(OAuthConstants.SCOPE, oauth20Service.getDefaultScope().getOrThrow());
         exp_params.add(OAuthConstants.STATE, "OAuth20Service state")
         let exp_authorizationUrl=exp_params.appendTo(OAuthServiceTest.api_oauth20Service.getAuthorizationBaseUrl())
         @Assert(re_authorizationUrl,exp_authorizationUrl)//添加请求头，转大写
    }
}