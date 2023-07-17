// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from std import collection.*
from oauth4cj import builder.*
from oauth4cj import pkce.*
from oauth4cj import oauth.*
from oauth4cj import httpclient.*

type OAuth4cjHttpClient = oauth4cj.httpclient.HttpClient

func testAuthorizationURL_01(): Int32 {
    var mapAdditional = HashMap<String, String>()
    mapAdditional.put("name1", "value1")
    mapAdditional.put("name2", "value2")
    var pkce: PKCE =  PKCE()
    var codeChallenge = "123456!@#%%$#"
    pkce.setCodeChallengeMethod(PKCECodeChallengeMethod.PLAIN)
    pkce.setCodeChallenge(codeChallenge)
    var urlBuilder = AuthorizationUrlBuilder(getService())
                        .setState(Some("state"))
                        .setScope(Some("scope"))
                        .setAdditionalParams(mapAdditional)
                        .setPkce(Some(pkce))
    var getP = urlBuilder.getPkce()
    var map = getP.getOrThrow().getAuthorizationUrlParams()
    var value = map[PKCE.PKCE_CODE_CHALLENGE_PARAM]
    if (!codeChallenge.equals(value)) {
        println(value)
        return -1
    }

    urlBuilder.initPKCE()
    var getP_2 = urlBuilder.getPkce()
    var map_2 = getP_2.getOrThrow().getAuthorizationUrlParams()
    var value_2 = map_2[PKCE.PKCE_CODE_CHALLENGE_PARAM]
    if (codeChallenge.equals(value_2)) {
        println(value)
        return -1
    }
    return 0
}



func testAuthorizationURL_02(): Int32 {
    var pkce: PKCE =  PKCE()
    var codeChallenge = "123456!@#%%$#"
    pkce.setCodeChallengeMethod(PKCECodeChallengeMethod.PLAIN)
    pkce.setCodeChallenge(codeChallenge)
    // pkce中的参数
    // [("code_challenge","123456!@#%%$#"), ("code_challenge_method", "PLAIN")]
    var urlString = AuthorizationUrlBuilder(getService())
                        .setState(Some("state"))
                        .setScope(Some("scope"))
                        .setPkce(Some(pkce))
                        .build()
    // DefaultApi20中追加参数
    // [("response_type","responseType"), ("client_id", "apiKey"), ("redirect_uri", "callback"), ("scope", "scope"), ("state", "state")]

    var expectString = "getAuthorizationBaseUrl?code_challenge=123456%21%40%23%25%25%24%23&code_challenge_method=PLAIN" + 
                        "&response_type=responseType&client_id=apiKey&redirect_uri=callback&scope=scope&state=state"
    if (!urlString.equals(expectString)) {
        return -1
    }
    return 0
}

func testAuthorizationURL_03(): Int32 {
    var map = HashMap<String, String>()
    map.put("name1", "value1")
    map.put("name2", "value2")
    var urlString = AuthorizationUrlBuilder(getService())
                        .setState(Some("state"))
                        .setScope(Some("scope"))
                        .setAdditionalParams(map)
                        .setPkce(Option<PKCE>.None)
                        .build()
    var expectString = "getAuthorizationBaseUrl?name1=value1&name2=value2&response_type=responseType&client_id=apiKey&redirect_uri=callback&scope=scope&state=state"
    if (!urlString.equals(expectString)) {
        return -1
    }
    return 0
}

func testAuthorizationURL_04(): Int32 {
    var map = HashMap<String, String>()
    map.put("name1", "value1")
    map.put("name2", "value2")
    var urlString = AuthorizationUrlBuilder(getService())
                        .setState(Option<String>.None)
                        .setScope(Option<String>.None)
                        .setAdditionalParams(map)
                        .setPkce(Option<PKCE>.None)
                        .build()
    var expectString = "getAuthorizationBaseUrl?name1=value1&name2=value2&response_type=responseType&client_id=apiKey&redirect_uri=callback"
    if (!urlString.equals(expectString)) {
        println(urlString)
        return -1
    }
    return 0
}

func testAuthorizationURL_05(): Int32 {
    var api: MyApi20 = MyApi20()
    var config: Option<HttpClientConfig> = Some(MyConfig().createDefaultConfig())
    var service: OAuth20Service = ServiceBuilderOAuth20("apiKey")
                                    .setCallback("callback")
                                    .setApiSecret("apiSecret")
                                    .setHttpClientConfig(config)
                                    .setHttpClient(Option<OAuth4cjHttpClient>.None)
                                    .setUserAgent("user agent")
                                    .setResponseType("responseType")
                                    .setDefaultScope("DefaultScope")
                                    .build(api)
    var map = HashMap<String, String>()
    map.put("name1", "value1")
    map.put("name2", "value2")
    var urlString = AuthorizationUrlBuilder(service)
                        .setState(Option<String>.None)
                        .setScope(Option<String>.None)
                        .setAdditionalParams(map)
                        .setPkce(Option<PKCE>.None)
                        .build()
    var expectString = "getAuthorizationBaseUrl?name1=value1&name2=value2&response_type=responseType&client_id=apiKey&redirect_uri=callback&scope=DefaultScope"
    if (!urlString.equals(expectString)) {
        return -1
    }
    return 0
}

func getService(): OAuth20Service {
    var api: MyApi20 = MyApi20()
    var config: Option<HttpClientConfig> = Some(MyConfig().createDefaultConfig())
    var service: OAuth20Service = ServiceBuilderOAuth20("apiKey")
                                    .setCallback("callback")
                                    .setApiSecret("apiSecret")
                                    .setHttpClientConfig(config)
                                    .setHttpClient(Option<OAuth4cjHttpClient>.None)
                                    .setUserAgent("user agent")
                                    .setResponseType("responseType")
                                    .build(api)
    return service
}

class MyConfig <: HttpClientConfig {
    private var flag: Bool = false
    public init(){}
    public func createDefaultConfig(): MyConfig {
        this.flag = false
        return this
    }
}

class MyApi20 <: DefaultApi20 {
    public init(){}
    public func getAccessTokenEndpoint(): String {
        return "getAccessTokenEndpoint"
    }
    protected func getAuthorizationBaseUrl(): String {
        return "getAuthorizationBaseUrl"
    }
}

main() {
    var test_01 = testAuthorizationURL_01()
    var test_02 = testAuthorizationURL_02()
    var test_03 = testAuthorizationURL_03()
    var test_04 = testAuthorizationURL_04()
    var test_05 = testAuthorizationURL_05()

    var sum = test_01+test_02+test_03+test_04+test_05
    println(sum)
    println("test_01=${test_01}, test_02=${test_02}, test_03=${test_03}, test_04=${test_04}, test_05=${test_05}")
    return sum
}

