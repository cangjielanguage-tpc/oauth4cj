// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from std import collection.*
from std import time.*
from oauth4cj import oauth.*
from oauth4cj import model.*
from oauth4cj import extractors.*
from oauth4cj import services.*

func testAPI20_01(): Int32 {
    var apiA: A = A()
    var tokenEAccess: TokenExtractor<OAuth2AccessToken> = apiA.getAccessTokenExtractor()
    let responseBody: String = ##"{"access_token":"oauth2_token"}"##
    let response: Response = Response(200, "", HashMap<String, String>(), responseBody)
    let oauth2AccessToken: OAuth2AccessToken = tokenEAccess.extract(response)
    if (!oauth2AccessToken.getAccessToken().equals("oauth2_token")) {
        return -1
    }

    var verbAccess: Verb = apiA.getAccessTokenVerb()
    if (!verbAccess.toString().equals("POST")) {
        return -1
    }

    var refreshTEndpoint = apiA.getRefreshTokenEndpoint()
    if (!refreshTEndpoint.equals("getAccessTokenEndpoint")) {
        return -1
    }

    try {
        var bearerSignature = apiA.getBearerSignature()
        var clientAuthentication = apiA.getClientAuthentication()
        
    } catch (e: Exception) {
        println(e)
        return -1
    }
    return 0
}

func testAPI20_02(): Int32 {
    var apiA: A = A()
    try {
        var revokeTEndpoint = apiA.getRevokeTokenEndpoint()
        return -1
    } catch (e: IllegalArgumentException) {
        println(e)
        return 0
    }
}

func testAPI20_03(): Int32 {
    var apiA: A = A()
    try {
        var deviceAEndpoint:String = apiA.getDeviceAuthorizationEndpoint()
        return -1
    } catch (e: Exception) {
        println(e)
        return 0
    }
}   

func testAPI20_04(): Int32 {
    var apiA: A = A()
    let params = HashMap<String, String>([("a", "0"), ("b", "1")])
    let url:String = apiA.getAuthorizationUrl("responseType", "apiKey", Some("callback"), Some("scope"),
                                                Some("state"), params)
    let baseUrl = "getAuthorizationBaseUrl?a=0&b=1&response_type=responseType&client_id=apiKey&redirect_uri=callback&" +
                    "scope=scope&state=state"
    if (!url.equals(baseUrl)) {
        println(url)
        return -1
    }
    return 0
}

func testAPI20_05(): Int32 {
    var apiA: A = A()
    let params = HashMap<String, String>([("a", "0"), ("b", "1")])
    let url:String = apiA.getAuthorizationUrl("responseType", "apiKey", Option<String>.None, Option<String>.None,
                                                Option<String>.None, params)
    let baseUrl = "getAuthorizationBaseUrl?a=0&b=1&response_type=responseType&client_id=apiKey"
    if (!url.equals(baseUrl)) {
        println(url)
        return -1
    }
    return 0
}

func testAPI20_06(): Int32 {
    var apiA: A = A()
    let responseBody: String = 
        ##"{"device_code": "123","user_code": "456", "verification_uri": "Beijing","expires_in": 200}"##
    let response: Response = Response(200, "", HashMap<String, String>(), responseBody)
    var deviceJsonE: DeviceAuthorizationJsonExtractor = apiA.getDeviceAuthorizationExtractor()
    var device: DeviceAuthorization = deviceJsonE.extract(response)
    if (!device.getDeviceCode().equals("123")) {
        return -1
    }
    if (!device.getUserCode().equals("456")) {
        return -1
    }
    if (!device.getVerificationUri().equals("Beijing")) {
        return -1
    }
    if (device.getExpiresInSeconds() != 200) {
        return -1
    }
    return 0
}

class A <: DefaultApi20 {
    public init(){}
    
    public func getAccessTokenEndpoint(): String {
        return "getAccessTokenEndpoint"
    }

    protected func getAuthorizationBaseUrl(): String {
        return "getAuthorizationBaseUrl"
    }
}

main() {
    var test_01 = testAPI20_01()
    var test_02 = testAPI20_02()
    var test_03 = testAPI20_03()
    var test_04 = testAPI20_04()
    var test_05 = testAPI20_05()
    var test_06 = testAPI20_06()

    var sum = test_01+test_02+test_03+test_04+test_05+test_06
    println(sum)
    println("test_01=${test_01}, test_02=${test_02}, test_03=${test_03}, test_04=${test_04}"+
            ", test_05=${test_05}, test_06=${test_06}")
    return sum
}