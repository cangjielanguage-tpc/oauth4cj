// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

//1.7.2 示例
from std import collection.*
from std import time.*
from oauth4cj import oauth4cj.*

main() {
    var apiA: A = A()
    var tokenEAccess: TokenExtractor<OAuth2AccessToken> = apiA.getAccessTokenExtractor()
    let responseBody: String = ##"{"access_token":"oauth2_token"}"##
    let response: OAuth4cjResponse = OAuth4cjResponse(200, "", HashMap<String, String>(), responseBody)
    let oauth2AccessToken: OAuth2AccessToken = tokenEAccess.extract(response)
    if (oauth2AccessToken.getAccessToken()!="oauth2_token") {
        return -1
    }
    println("oauth2AccessToken = ${oauth2AccessToken.getAccessToken()}")
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