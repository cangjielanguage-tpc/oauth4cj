// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj

@Test
public class TestOAuth20ServiceB008{
    /***
        public func getAuthorizationUrl(additionalParams: HashMap<String, String>): String
        测试场景:additionalParams非空
    ***/

    @TestCase
    func testOAuth20ServiceGetAuthorizationUrl0301(): Unit {
         var oauth20Service=OAuthServiceTest.getOAuth20Service()
         var additionalParams=HashMap<String,String>([("additionalParams01","01"),("additionalParams02","02")])
         var re_authorizationUrl=oauth20Service.getAuthorizationUrl(additionalParams)
         var exp_additionalParams=additionalParams
         var exp_params = ParameterList(exp_additionalParams)
         exp_params.add(OAuthConstants.RESPONSE_TYPE, oauth20Service.getResponseType());
         exp_params.add(OAuthConstants.CLIENT_ID, oauth20Service.getApiKey());
         exp_params.add(OAuthConstants.REDIRECT_URI, oauth20Service.getCallback().getOrThrow());
         exp_params.add(OAuthConstants.SCOPE, oauth20Service.getDefaultScope().getOrThrow());
         let exp_authorizationUrl=exp_params.appendTo(OAuthServiceTest.api_oauth20Service.getAuthorizationBaseUrl())
         @Assert(re_authorizationUrl,exp_authorizationUrl)//添加请求头，转大写
    }
}