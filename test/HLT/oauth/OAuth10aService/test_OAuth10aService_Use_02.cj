// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj

@Test
public class TestOAuth10aServiceB008{
    /***
        public func getRequestTokenAsync(callback: Option<OAuthAsyncRequestCallback>): Future<OAuth1RequestToken>
        public func getAccessTokenAsync(requestToken: OAuth1RequestToken, oauthVerifier: String,callback: Option<OAuthAsyncRequestCallback>): Future<OAuth1AccessToken>
        测试场景:有回调
    ***/

    @TestCase
    func testOAuth10aServiceUse02(): Unit {
        spawn {
            serve10a()
        }
        sleep(1*Duration.second)
        let appKey: String = "123456789"
        let appSecret: String = "123456789"

        let myInterceptor = MyInterceptor()
        let client: httpclient4cj.HttpClient = httpclient4cj.HttpClient.builder().addInterceptor(myInterceptor).build()
        myInterceptor.setClient(client)

        let myClient: OkHttpHttpClient = OkHttpHttpClient(client)
        let service: OAuth10aService = ServiceBuilderOAuth10a(appKey).
                setApiSecret(appSecret).
                setHttpClient(Some(myClient)).
                build(MyApi10a.instance())
        let subOAuthAsyncRequestCallback01=SubOAuthAsyncRequestCallback()
        let requestToken_async = service.getRequestTokenAsync(Option<OAuthAsyncRequestCallback>.Some(subOAuthAsyncRequestCallback01)).get()
        @Assert(requestToken_async.getToken(),"request_token_0")
        @Assert(subOAuthAsyncRequestCallback01.getFlagOnCompleted(),"pass")
        @Assert(subOAuthAsyncRequestCallback01.getFlagOnThrowable(),"fail")

        let oauthVerifier: String = "123456"
        let subOAuthAsyncRequestCallback02=SubOAuthAsyncRequestCallback()
        let accessToken_async = service.getAccessTokenAsync(requestToken_async, oauthVerifier,Option<OAuthAsyncRequestCallback>.Some(subOAuthAsyncRequestCallback02)).get()
        @Assert(accessToken_async.getToken(),"access_token")
        @Assert(subOAuthAsyncRequestCallback02.getFlagOnCompleted(),"pass")
        @Assert(subOAuthAsyncRequestCallback02.getFlagOnThrowable(),"fail")
    }
}