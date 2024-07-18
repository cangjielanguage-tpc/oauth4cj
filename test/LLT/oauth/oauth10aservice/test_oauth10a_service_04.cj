// DEPENDENCE: ./oauth10a_api.cj
// EXEC: cjc %import-path %L %l %f ./oauth10a_api.cj
// EXEC: ./main

import std.collection.*
import std.time.*
import std.io.*
public import oauth4cj.*


func testOAuth10aService09(service: OAuth10aService): Int32 {
    try {
        let res: Future<OAuth1RequestToken> = service.getRequestTokenAsync()
        res.get(1000 * 1000 * 1000)
        return -1
    } catch (ex: Exception) {
        return 0
    }
}

func testOAuth10aService10(service: OAuth10aService): Int32 {
    try {
        let res: Future<OAuth1RequestToken> = service.getRequestTokenAsync(MyCallBack())
        res.get(1000 * 1000 * 1000)
        return -1
    } catch (ex: Exception) {
        return 0
    }
}

func testOAuth10aService11(service: OAuth10aService): Int32 {
    try {
        let requestToken = OAuth1RequestToken("token", "tokenSecret")
        let oauthVerifier = "oauthVerifier"
        let res: Future<OAuth1AccessToken> = service.getAccessTokenAsync(requestToken, oauthVerifier)
        res.get(1000 * 1000 * 1000)
        return -1
    } catch (ex: Exception) {
        return 0
    }
}

func testOAuth10aService12(service: OAuth10aService): Int32 {
    try {
        let requestToken = OAuth1RequestToken("token", "tokenSecret")
        let oauthVerifier = "oauthVerifier"
        let res: Future<OAuth1AccessToken> = service.getAccessTokenAsync(requestToken, oauthVerifier, MyCallBack())
        res.get(1000 * 1000 * 1000)
        return -1
    } catch (ex: Exception) {
        return 0
    }
}


main() {
    var oauth10aApi = OAuth10aApi(true)
    var httpClientConfig = Option<HttpClientConfig>.None
    var httpClient: HttpClient = OkHttpHttpClient(OkHttpHttpClientConfig.defaultConfig())
    var httpClientProvider = Option<HttpClientProvider>.None
    var stream = ByteArrayStream()
    var service = OAuth10aService(oauth10aApi, "apiKey", "apiSecret", "callback", 
        Option<String>.None, stream, "userAgent", 
        httpClientConfig, Some(httpClient), httpClientProvider)

    var test_09 = testOAuth10aService09(service)
    var test_10 = testOAuth10aService10(service)
    var test_11 = testOAuth10aService11(service)
    var test_12 = testOAuth10aService12(service)

    var sum = test_09+test_10+test_11+test_12
    println(sum)
    println("test_09=${test_09}, test_10=${test_10}, test_11=${test_11}, test_12=${test_12}")
    return sum
}

class MyCallBack <: OAuthAsyncRequestCallback {
    public init() {}
    public func onCompleted(response: Any): Unit {
        println(response as String)
        println("MyCallBack onCompleted")
    }

    public func onThrowable(e: Exception): Unit {
        println(e.message)
        println("MyCallBack onThrowable")
    }
}
