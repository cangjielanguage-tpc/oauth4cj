// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj

@Test
public class TestAuthorizationUrlBuilderB005{
    /***
        public func setPkce(pkce: Option<PKCE>): AuthorizationUrlBuilder
        测试场景:验证生效即可
    ***/
    @TestCase
    func testAuthorizationUrlBuilderSetAdditionalParams01(): Unit {
        var api = SubDefaultApi20()
        var config: Option<HttpClientConfig> = Some(MyConfig().createDefaultConfig())
        var scopeBuilder=ScopeBuilder().withScope("defaultScope")
        var oauth20Service=ServiceBuilderOAuth20("apiKey")
                    .setCallback("callback")
                    .setApiSecret("apiSecret")
                    .setHttpClientConfig(config)
                    .setHttpClient(Option<HttpClient>.None)
                    .setUserAgent("user agent")
                    .setApiSecretIsEmptyStringUnsafe()
                    .setDefaultScope(scopeBuilder)
                    .setResponseType("responseType")
                    .build(api)
        var oathorizationUrlBuilder01=AuthorizationUrlBuilder(oauth20Service)
        var pkce=PKCE()
        var oathorizationUrlBuilder02=oathorizationUrlBuilder01.setPkce(pkce)
        var re=oathorizationUrlBuilder02.build()
        var params=HashMap<String,String>()
        params.putAll(pkce.getAuthorizationUrlParams())
        var exp_re=oauth20Service.getApi().getAuthorizationUrl(oauth20Service.getResponseType(),
                                                               oauth20Service.getApiKey(),
                                                               oauth20Service.getCallback(),
                                                               "defaultScope", Option<String>.None, params)
        @Assert(re,exp_re)
    }
}

class MyConfig <: HttpClientConfig {
    private var flag: Bool = false
    public init(){}
    public func createDefaultConfig(): MyConfig {
        this.flag = false
        return this
    }
}