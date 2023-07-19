// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj

@Test
public class TestAuthorizationUrlBuilderB005{
    /***
        public func build(): String
        测试场景:默认构造,结果准确
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
                    .setHttpClient(Option<OAuth4cjHttpClient>.None)
                    .setUserAgent("user agent")
                    .setApiSecretIsEmptyStringUnsafe()
                    .setDefaultScope(scopeBuilder)
                    .setResponseType("responseType")
                    .build(api)
        var oathorizationUrlBuilder01=AuthorizationUrlBuilder(oauth20Service)
        var map01=HashMap<String,String>()
        var re=oathorizationUrlBuilder01.build()
        var exp_re=oauth20Service.getApi().getAuthorizationUrl(oauth20Service.getResponseType(),
                                                               oauth20Service.getApiKey(),
                                                               oauth20Service.getCallback(),
                                                               "defaultScope", Option<String>.None, map01)
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