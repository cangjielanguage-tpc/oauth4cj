// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj

@Test
public class TestOAuth20ServiceB008{
    /***
        public func getAuthorizationUrl(pkce: PKCE): String
        测试场景:pkce非None
    ***/

    @TestCase
    func testOAuth20ServiceGetAuthorizationUrl0401(): Unit {
         var oauth20Service=OAuthServiceTest.getOAuth20Service()
         let pkce=PKCE()
         pkce.setCodeChallenge("Pkce codeChallenge")
         var re_authorizationUrl=oauth20Service.getAuthorizationUrl(pkce)
         var exp_additionalParams=HashMap<String,String>()
         exp_additionalParams.putAll(pkce.getAuthorizationUrlParams())
         var exp_params = ParameterList(exp_additionalParams)
         exp_params.add(OAuthConstants.RESPONSE_TYPE, oauth20Service.getResponseType());
         exp_params.add(OAuthConstants.CLIENT_ID, oauth20Service.getApiKey());
         exp_params.add(OAuthConstants.REDIRECT_URI, oauth20Service.getCallback().getOrThrow());
         exp_params.add(OAuthConstants.SCOPE, oauth20Service.getDefaultScope().getOrThrow());
         let exp_authorizationUrl=exp_params.appendTo(OAuthServiceTest.api_oauth20Service.getAuthorizationBaseUrl())
         @Assert(re_authorizationUrl,exp_authorizationUrl)//添加请求头，转大写
    }
}