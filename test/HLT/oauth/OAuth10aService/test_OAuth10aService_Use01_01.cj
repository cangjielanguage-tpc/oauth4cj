// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj

@Test
public class TestOAuth10aServiceB008{
    /***
        public func getRequestToken(): OAuth1RequestToken
        public func getAccessToken(requestToken: OAuth1RequestToken, oauthVerifier: String): OAuth1AccessToken
        测试场景:无回调
    ***/

    @TestCase
    func testOAuth10aServiceUse0101(): Unit {
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

        let requestToken = service.getRequestToken()
        @Assert(requestToken.getToken(),"request_token_0")
        let oauthVerifier: String = "123456"

        // 请求accessToken
        let accessToken = service.getAccessToken(requestToken, oauthVerifier)
        @Assert(accessToken.getToken(),"access_token")

    }
}

