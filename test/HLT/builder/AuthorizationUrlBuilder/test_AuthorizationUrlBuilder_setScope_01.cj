// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj
from std import unittest.*
from std import unittest.testmacro.*
from std import collection.*
from oauth4cj import util.*
from oauth4cj import httpclient.*

@Test
public class TestAuthorizationUrlBuilderB005{
    /***
        public func setScope(scope: Option<String>): AuthorizationUrlBuilder
        测试场景:设置scope非空
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
                    .setHttpClient(Option<HttpClient>.None)
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
}

class MyConfig <: HttpClientConfig {
    private var flag: Bool = false
    public init(){}
    public func createDefaultConfig(): MyConfig {
        this.flag = false
        return this
    }
}