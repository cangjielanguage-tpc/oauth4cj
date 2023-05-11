// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from std import collection.*
from oauth4cj import builder.*
from oauth4cj import httpclient.*
from oauth4cj import oauth.*

func testServiceBuilder_01(): Int32 {
    var api: MyApi10a = MyApi10a()
    var config: Option<HttpClientConfig> = Some(MyConfig().createDefaultConfig())
    try {
        var service: OAuth10aService = ServiceBuilder("apiKey")
                                    .setCallback("callback")
                                    .setApiSecret("apiSecret")
                                    .setUserAgent("user agent")
                                    .setHttpClientConfig(config)
                                    .setHttpClient(Option<HttpClient>.None)
                                    .withScope("scope")
                                    .build(api)
        return 0
    } catch (e: Exception) {
        return -1
    }
}

func testServiceBuilder_02(): Int32 {
    var api: MyApi20 = MyApi20()
    var config: Option<HttpClientConfig> = Some(MyConfig().createDefaultConfig())
    try {
        var service: OAuth20Service = ServiceBuilder("apiKey")
                                    .setCallback("callback")
                                    .setApiSecret("apiSecret")
                                    .setHttpClientConfig(config)
                                    .setHttpClient(Option<HttpClient>.None)
                                    .setUserAgent("user agent")
                                    .setDefaultScope("scope")
                                    .setResponseType("responseType")
                                    .build(api)
        return 0
    } catch (e: Exception) {
        return -1
    }
}

func testServiceBuilder_03(): Int32 {
    var api: MyApi10a = MyApi10a()
    try {
        var service: OAuth10aService = ServiceBuilder("apiKey")
                                        .setHttpClientConfig(Option<HttpClientConfig>.None).build(api)
        return -1
    } catch (e: IllegalArgumentException) {
        return 0
    }
}

func testServiceBuilder_04(): Int32 {
    var api: MyApi20 = MyApi20()
    var config: Option<HttpClientConfig> = Some(MyConfig().createDefaultConfig())
    var scopeString: String = "scope_1"
    var scopeBuilder: ScopeBuilder = ScopeBuilder().withScope(scopeString)
    try {
        var service: OAuth20Service = ServiceBuilder("apiKey")
                                    .setCallback("callback")
                                    .setApiSecret("apiSecret")
                                    .setHttpClientConfig(config)
                                    .setHttpClient(Option<HttpClient>.None)
                                    .setUserAgent("user agent")
                                    .setApiSecretIsEmptyStringUnsafe()
                                    .setDefaultScope(scopeBuilder)
                                    .setResponseType("responseType")
                                    .build(api)
        return 0
    } catch (e: Exception) {
        return -1
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

class MyApi10a <: DefaultApi10a {
    public init(){}
    public func getRequestTokenEndpoint(): String {
        return ""
    }

    public func getAccessTokenEndpoint(): String {
        return ""
    }

    protected func getAuthorizationBaseUrl(): String {
        return ""
    }
}

class MyApi20 <: DefaultApi20 {
    public init(){}
    public func getAccessTokenEndpoint(): String {
        return ""
    }
    protected func getAuthorizationBaseUrl(): String {
        return ""
    }
}

main() {
    var test_01 = testServiceBuilder_01()
    var test_02 = testServiceBuilder_02()
    var test_03 = testServiceBuilder_03()
    var test_04 = testServiceBuilder_04()

    var sum = test_01+test_02+test_03+test_04
    println(sum)
    println("test_01=${test_01}, test_02=${test_02}, test_03=${test_03}, test_04=${test_04}")
    return sum
}