// DEPENDENCE: ./oauth10a_api.cj
// EXEC: cjc %import-path %L %l %f ./oauth10a_api.cj
// EXEC: ./main

from std import collection.*
from std import time.*
from std import io.*
from oauth4cj import oauth.*
from oauth4cj import model.*
from oauth4cj import extractors.*
from oauth4cj import services.*
from oauth4cj import httpclient.*
from oauth4cj import exceptions.*


func testOAuth10aService05(): Int32 {
    var oauth10aApi = OAuth10aApi(false)
    var httpClientConfig = Option<HttpClientConfig>.None
    var httpClient = Option<HttpClient>.None
    var httpClientProvider = Option<HttpClientProvider>.None
    var stream = ByteArrayStream()
    var service = OAuth10aService(oauth10aApi, "apiKey", "apiSecret", "callback", 
        "scope", stream, "userAgent", 
        httpClientConfig, httpClient, httpClientProvider)
    try {
        var requestToken = service.getRequestToken()
        println(requestToken.getToken())
        return -1
    } catch (e: OAuth4cjException) {
        return 0
    }
}

func testOAuth10aService06(): Int32 {
    var oauth10aApi = OAuth10aApi(false)
    var httpClientConfig = Option<HttpClientConfig>.None
    var httpClient = Option<HttpClient>.None
    var httpClientProvider = Option<HttpClientProvider>.None
    var stream = ByteArrayStream()
    var service = OAuth10aService(oauth10aApi, "apiKey", "apiSecret", "callback", 
        Option<String>.None, stream, "userAgent", 
        httpClientConfig, httpClient, httpClientProvider)
    var requestToken = OAuth1RequestToken("token", "tokenSecret")
    try {
        var accessToken = service.getAccessToken(requestToken, "oauthVerifier")
        println(accessToken.getToken())
        return -1
    } catch (e: Exception) {
        return 0
    }
}

func testOAuth10aService07(): Int32 {
    var oauth10aApi = OAuth10aApi(true)
    var httpClientConfig = OkHttpHttpClientConfig.defaultConfig()
    var httpClient = Option<HttpClient>.None
    var httpClientProvider = OkHttpProvider()
    var stream = ByteArrayStream()
    var service = OAuth10aService(oauth10aApi, "apiKey", "apiSecret", "callback", 
        Option<String>.None, stream, "userAgent", 
        Some(httpClientConfig), httpClient, Some(httpClientProvider))
    var accessToken = OAuth1AccessToken("token", "tokenSecret")
    var request = OAuth4cjRequest(Verb.GET, "http://localhost:8080/")
    var size01 = request.getOauthParameters().size
    if (size01 != 0) {
        return  -1
    }
    service.signRequest(accessToken, request)
    var size02 = request.getOauthParameters().size
    if (size02 != 7) {
        return  -1
    }
    return 0
}

func testOAuth10aService08(): Int32 {
    var oauth10aApi = OAuth10aApi(true)
    var httpClientConfig = Option<HttpClientConfig>.None
    var httpClient: HttpClient = OkHttpHttpClient(OkHttpHttpClientConfig.defaultConfig())
    var httpClientProvider = Option<HttpClientProvider>.None
    var stream = ByteArrayStream()
    var service = OAuth10aService(oauth10aApi, "apiKey", "apiSecret", "callback", 
        Option<String>.None, stream, "userAgent", 
        httpClientConfig, Some(httpClient), httpClientProvider)
    var requestToken = OAuth1RequestToken("token", "tokenSecret")
    var url = service.getAuthorizationUrl(requestToken)
    if (!url.equals("http://localhost:8080/authorize?oauth_token=token")) {
        return  -1
    }
    var api = service.getApi()
    var flag = api is OAuth10aApi
    if (!flag) {
        return -1
    }
    return 0
}

main() {
    var test_05 = testOAuth10aService05()
    var test_06 = testOAuth10aService06()
    var test_07 = testOAuth10aService07()
    var test_08 = testOAuth10aService08()

    var sum = test_05+test_06+test_07+test_08
    println(sum)
    println("test_05=${test_05}, test_06=${test_06}, test_07=${test_07}, test_08=${test_08}")
    return sum
}