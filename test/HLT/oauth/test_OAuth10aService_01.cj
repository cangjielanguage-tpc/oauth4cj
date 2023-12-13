// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj

public let exp_api=OAuthServiceTest.api_oauth10aService
public var oauth10aService=OAuthServiceTest.getOAuth10aService()

public var url="http://127.0.0.1:${port}/index"
@Test
public class TestOAuth10aServiceB008{
    /***
        public func getApi(): DefaultApi10a
        测试场景：结果与构造器一致
    ***/
    public override func beforeAll(): Unit{
        serve10a()
        sleep(3*Duration.second)
        url="http://127.0.0.1:${port}/1234"
    }
    @TestCase
    func testOAuth10aServiceGetApi01(): Unit {
         oauth10aService=OAuthServiceTest.getOAuth10aService()
         var re_api=(oauth10aService.getApi() as SubDefaultApi10a).getOrThrow()
         @Assert(re_api==exp_api,true)
    }
    /***
        public func getAuthorizationUrl(requestToken: OAuth1RequestToken): String
        测试场景:结果与对标库逻辑一致
    ***/
    @TestCase
    func testOAuth10aServiceGetAuthorizationUrl01(): Unit {
         oauth10aService=OAuthServiceTest.getOAuth10aService()
         var requestToken=OAuth1RequestToken("token","tokenSecret")
         var re_authorizationUrl=oauth10aService.getAuthorizationUrl(requestToken)
        let exp_authorizationUrl=exp_api.getAuthorizationUrl(requestToken)
        @Assert(re_authorizationUrl,exp_authorizationUrl)
    }
    /***
        public func getVersion(): String
        测试场景:默认值
    ***/

    @TestCase
    func testOAuth10aServiceGetVersion01(): Unit {
         oauth10aService=OAuthServiceTest.getOAuth10aService()
         var re_Version=oauth10aService.getVersion()
         @Assert(re_Version,"1.0")
    }
    /***
        public func signRequest(token: OAuth1AccessToken, request: OAuth4cjRequest): Unit
        测试场景:请求加签后，对应参数添加正常
    ***/
    @TestCase
    func testOAuth10aServiceSignRequest01(): Unit {
         oauth10aService=OAuthServiceTest.getOAuth10aService()
         let token=OAuth1AccessToken("token","tokenSecret","rawResponse")
         let request=OAuth4cjRequest(Verb.POST,url)
         oauth10aService.signRequest(token,request)
         var re_OAuthParams=request.getOauthParameters()
         var re_Headers=request.getHeaders()
         var exp_OAuthParams=HashMap<String,String>()
         exp_OAuthParams.put(OAuthConstants.TOKEN,token.getToken())
         exp_OAuthParams.put(OAuthConstants.TIMESTAMP,re_OAuthParams.get("${OAuthConstants.TIMESTAMP}").getOrThrow())
         exp_OAuthParams.put(OAuthConstants.NONCE,re_OAuthParams.get("${OAuthConstants.NONCE}").getOrThrow())
         exp_OAuthParams.put(OAuthConstants.CONSUMER_KEY,oauth10aService.getApiKey())
         exp_OAuthParams.put(OAuthConstants.SIGN_METHOD,exp_api.getSignatureService().getSignatureMethod())
         exp_OAuthParams.put(OAuthConstants.VERSION,oauth10aService.getVersion())
         exp_OAuthParams.put(OAuthConstants.SCOPE,OAuthServiceTest.scope_oauth10aService.getOrThrow())
         exp_OAuthParams.put(OAuthConstants.SIGNATURE,re_OAuthParams.get("${OAuthConstants.SIGNATURE}").getOrThrow())
         var exp_oauthHeader=HashMap<String,String>()
         exp_oauthHeader.put(OAuthConstants.HEADER_AUTHORIZATION, exp_api.getHeaderExtractor().extract(request))

         @Assert(re_OAuthParams,exp_OAuthParams)
         @Assert(re_Headers,exp_oauthHeader)
    }
    /***
        public func getRequestToken(): OAuth1RequestToken
        public func getAccessToken(requestToken: OAuth1RequestToken, oauthVerifier: String): OAuth1AccessToken
        测试场景:无回调
    ***/

    @TestCase
    func testOAuth10aServiceUse0101(): Unit {
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
    /***
        public func getRequestTokenAsync(): Future<OAuth1RequestToken>
        public func getAccessTokenAsync(requestToken: OAuth1RequestToken, oauthVerifier: String): Future<OAuth1AccessToken>
        测试场景:无回调
    ***/

    @TestCase
    func testOAuth10aServiceUse0102(): Unit {
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

        let requestToken_async = service.getRequestTokenAsync().get()
        @Assert(requestToken_async.getToken(),"request_token_0")
        let oauthVerifier: String = "123456"

        // 请求accessToken
        let accessToken_async = service.getAccessTokenAsync(requestToken_async, oauthVerifier).get()
        @Assert(accessToken_async.getToken(),"access_token")
    }
    /***
        public func getRequestTokenAsync(callback: Option<OAuthAsyncRequestCallback>): Future<OAuth1RequestToken>
        public func getAccessTokenAsync(requestToken: OAuth1RequestToken, oauthVerifier: String,callback: Option<OAuthAsyncRequestCallback>): Future<OAuth1AccessToken>
        测试场景:有回调
    ***/

    @TestCase
    func testOAuth10aServiceUse02(): Unit {
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
public func getSignature(request:OAuth4cjRequest, tokenSecret:String):String{
    let baseString = exp_api.getBaseStringExtractor().extract(request)
    let signature  = exp_api.getSignatureService().getSignature(baseString, oauth10aService.getApiSecret(), tokenSecret)
    return signature
}