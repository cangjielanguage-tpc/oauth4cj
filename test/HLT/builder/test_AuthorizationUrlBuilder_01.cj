// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj

@Test
public class TestAuthorizationUrlBuilder{
    /***
        public func build(): String
        测试场景:默认构造,结果准确
    ***/
    @TestCase
    func testAuthorizationUrlBuilderBuild01(): Unit {
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
    /***
        public func initPKCE(): AuthorizationUrlBuilder
        测试场景:设置为缺省的pkce
    ***/
    @TestCase
    func testAuthorizationUrlBuilderInitPKCE01(): Unit {
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
        var oathorizationUrlBuilder02=oathorizationUrlBuilder01.initPKCE()
        var after_pkce=oathorizationUrlBuilder02.getPkce().getOrThrow()
        var re=oathorizationUrlBuilder02.build()
        var params=HashMap<String,String>()
        params.putAll(after_pkce.getAuthorizationUrlParams())
        var exp_re=oauth20Service.getApi().getAuthorizationUrl(oauth20Service.getResponseType(),
                                                               oauth20Service.getApiKey(),
                                                               oauth20Service.getCallback(),
                                                               "defaultScope", Option<String>.None, params)
        @Assert(re,exp_re)
    }
    /***
        public func setAdditionalParams(additionalParams: HashMap<String, String>): AuthorizationUrlBuilder
        测试场景:设置额外参数成功
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
        var map01=HashMap<String,String>([("first","first"),("second","second")])
        var oathorizationUrlBuilder02=oathorizationUrlBuilder01.setAdditionalParams(map01)
        var re=oathorizationUrlBuilder02.build()
        var exp_re=oauth20Service.getApi().getAuthorizationUrl(oauth20Service.getResponseType(),
                                                               oauth20Service.getApiKey(),
                                                               oauth20Service.getCallback(),
                                                               "defaultScope", Option<String>.None, map01)
        @Assert(re,exp_re)
    }
    /***
        public func setPkce(pkce: Option<PKCE>): AuthorizationUrlBuilder
        测试场景:验证生效即可
    ***/
    @TestCase
    func testAuthorizationUrlBuilderSetPkce01(): Unit {
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
    /***
        public func setScope(scope: Option<String>): AuthorizationUrlBuilder
        测试场景:设置scope非空
    ***/
    @TestCase
    func testAuthorizationUrlBuilderSetScope01(): Unit {
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
        var oathorizationUrlBuilder02=oathorizationUrlBuilder01.setScope(Option<String>.Some("scope"))
        var re=oathorizationUrlBuilder02.build()
        var exp_re=oauth20Service.getApi().getAuthorizationUrl(oauth20Service.getResponseType(),
                                                               oauth20Service.getApiKey(),
                                                               oauth20Service.getCallback(),
                                                               "scope",Option<String>.None, HashMap<String, String>())
        @Assert(re,exp_re)
    }
    /***
        public func setState(state: String): AuthorizationUrlBuilder
        测试场景:设置state非空
    ***/
    @TestCase
    func testAuthorizationUrlBuilderSetState01(): Unit {
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
        var oathorizationUrlBuilder02=oathorizationUrlBuilder01.setState("state")
        var re=oathorizationUrlBuilder02.build()
        var exp_re=oauth20Service.getApi().getAuthorizationUrl(oauth20Service.getResponseType(),
                                                               oauth20Service.getApiKey(),
                                                               oauth20Service.getCallback(),
                                                               "defaultScope", "state", HashMap<String, String>())
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