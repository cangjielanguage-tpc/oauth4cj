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

func testOAuth10aService01(): Int32 {
    var oauth10aApi = OAuth10aApi(false)
    var httpClientConfig = Option<HttpClientConfig>.None
    var httpClient = Option<HttpClient>.None
    var httpClientProvider = Option<HttpClientProvider>.None
    var service = OAuth10aService(oauth10aApi, "apiKey", "apiSecret", "callback", 
        Option<String>.None, Option<OutputStream>.None, "userAgent", 
        httpClientConfig, httpClient, httpClientProvider)
    try {
        var requestToken = service.getRequestToken()
        return -1
    } catch (e: OAuth4cjException) {
        return 0
    }
}

func testOAuth10aService02(): Int32 {
    var oauth10aApi = OAuth10aApi(false)
    var httpClientConfig = Option<HttpClientConfig>.None
    var httpClient = Option<HttpClient>.None
    var httpClientProvider = Option<HttpClientProvider>.None
    var service = OAuth10aService(oauth10aApi, "apiKey", "apiSecret", "callback", 
        Option<String>.None, Option<OutputStream>.None, "userAgent", 
        httpClientConfig, httpClient, httpClientProvider)
    var requestToken = OAuth1RequestToken("token", "tokenSecret")
    try {
        var accessToken = service.getAccessToken(requestToken, "oauthVerifier")
        return -1
    } catch (e: Exception) {
        return 0
    }
}

func testOAuth10aService03(): Int32 {
    var oauth10aApi = OAuth10aApi(true)
    var httpClientConfig = Option<HttpClientConfig>.None
    var httpClient = Option<HttpClient>.None
    var httpClientProvider = Option<HttpClientProvider>.None
    var service = OAuth10aService(oauth10aApi, "apiKey", "apiSecret", "callback", 
        Option<String>.None, Option<OutputStream>.None, "userAgent", 
        httpClientConfig, httpClient, httpClientProvider)
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

func testOAuth10aService04(): Int32 {
    var oauth10aApi = OAuth10aApi(true)
    var httpClientConfig = Option<HttpClientConfig>.None
    var httpClient = Option<HttpClient>.None
    var httpClientProvider = Option<HttpClientProvider>.None
    var service = OAuth10aService(oauth10aApi, "apiKey", "apiSecret", "callback", 
        Option<String>.None, Option<OutputStream>.None, "userAgent", 
        httpClientConfig, httpClient, httpClientProvider)
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
    var test_01 = testOAuth10aService01()
    var test_02 = testOAuth10aService02()
    var test_03 = testOAuth10aService03()
    var test_04 = testOAuth10aService04()

    var sum = test_01+test_02+test_03+test_04
    println(sum)
    println("test_01=${test_01}, test_02=${test_02}, test_03=${test_03}, test_04=${test_04}")
    return sum
}