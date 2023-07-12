// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj


@Test
public class TestOAuth20ServiceB008{
    /***
        public func getAccessTokenPasswordGrantAsync(username: String, password: String, scope: String):Future<OAuth2AccessToken>
        测试场景:鉴权成功
    ***/
    @Skip
    @TestCase
    func testOAuth20ServiceGetAccessTokenPasswordGrantAsync0401(): Unit {
        let USER_NAME: String = "your  userid"
        let PASSWORD: String = "your passwaord"
        let scope: String = "user_info emails"


        let PROTECTED_RESOURCE_URL: String = "https://gitee.com/api/v5/emails"

        // Replace these with your client id and secret //将这些替换为您的客户端id和机密
        let clientId: String = "your client id"
        let clientSecret: String = "your client secret"

        //ServiceBuilder(clientId).
        let service: OAuth20Service = ServiceBuilderOAuth20(clientId).
                setApiSecret(clientSecret).
                setDefaultScope(scope).
                setCallback("http://www.example.com/oauth_callback/").
                build(GiteeApi.instance())
        let subOAuthAsyncRequestCallback01=SubOAuthAsyncRequestCallback()
        let callback=Option<OAuthAsyncRequestCallback>.Some(subOAuthAsyncRequestCallback01)
        let fut_accessToken = service.getAccessTokenPasswordGrantAsync(USER_NAME, PASSWORD,scope,callback)
        let accessToken: OAuth2AccessToken=fut_accessToken.get()
        let requestUrl: String = PROTECTED_RESOURCE_URL
        let request: OAuth4cjRequest = OAuth4cjRequest(Verb.GET, requestUrl)
        service.signRequest(accessToken, request)
        let response = service.execute(request)
        @Assert(response.getCode(),200)
    }
}