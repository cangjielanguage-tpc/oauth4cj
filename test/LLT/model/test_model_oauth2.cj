// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from oauth4cj import model.*

// OAuth2AccessToken

// public init("token", tokenType:"tokenType", expiresIn:0, refreshToken:"", scope:"", "a=1&b=2&c=3")
public func testOAuth2_01():Int32 {
    var oauth2AccessToken_0:OAuth2AccessToken = OAuth2AccessToken("token","a=1&b=2&c=3")
    var rawResponse:String = oauth2AccessToken_0.getRawResponse()
    if (!rawResponse.equals("a=1&b=2&c=3")) {
        return -1
    } 
    var parameter:String = oauth2AccessToken_0.getParameter("c")
    if (!parameter.equals("3")) {
        return -1
    } 

    var oauth2AccessToken:OAuth2AccessToken = OAuth2AccessToken("token", "tokenType", 100, "refreshToken","scope","a=1&b=2&c=3")
    var token:String = oauth2AccessToken.getAccessToken()
    if (!token.equals("token")) {
        return -1
    } 
    var tokenType:String = oauth2AccessToken.getTokenType()
    if (!tokenType.equals("tokenType")) {
        return -1
    } 
    var expiresIn:Int32 = oauth2AccessToken.getExpiresIn()
    if (expiresIn != 100) {
        return -1
    } 
    var refreshToken:String = oauth2AccessToken.getRefreshToken()
    if (!refreshToken.equals("refreshToken")) {
        return -1
    } 
    var scope:String = oauth2AccessToken.getScope()
    if (!scope.equals("scope")) {
        return -1
    } 
    return 0
}

// public func equals(object:Object):Bool
public func testOAuth2_02():Int32 {
    var oauth2Token_0:OAuth2AccessToken = OAuth2AccessToken("token", "tokenType", 100, "refreshToken", "scope", "a=1&b=2&c=3")
    var oauth2Token_1:Token = Token("a=1&b=2&c=3")
    if (oauth2Token_0.equals(oauth2Token_1)){ //父类型返回false
        return -1
    }
    var oauth2Token_2:OAuth1AccessToken = OAuth1AccessToken("token", "tokenSecret", "rawResponse")
    if (oauth2Token_0.equals(oauth2Token_2)){ //不同类型返回false
        return -1
    }
    var oauth2Token_3:OAuth2AccessToken = OAuth2AccessToken("token", "tokenType", 100, "refreshToken", "scope", "a=1&b=2&c=3")
    if (!oauth2Token_0.equals(oauth2Token_3)){ //相同类型token tokenType refreshToken scope expiresIn都相同返回true
        return -1
    }
    var oauth2Token_4:OAuth2AccessToken = OAuth2AccessToken("token", "tokenType", 100, "refreshToken", "scope", "")
    if (!oauth2Token_0.equals(oauth2Token_4)){ //相同类型token tokenType refreshToken scope expiresIn都相同返回true rawResponse不影响结果
        return -1
    }
    return 0
}

// public func equals(object:Object):Bool
public func testOAuth2_03():Int32 {
    var oauth2Token_0:OAuth2AccessToken = OAuth2AccessToken("token")
    var oauth2Token_1:OAuth2AccessToken = OAuth2AccessToken("token1")
    if (oauth2Token_0.equals(oauth2Token_1)){ //相同类型token不同 返回false
        return -1
    }
    var oauth2Token_2:OAuth2AccessToken = OAuth2AccessToken("token", "tokenType2", 100, "refreshToken", "scope", "a=1&b=2&c=3")
    if (oauth2Token_0.equals(oauth2Token_2)){ //相同类型tokenType不同 返回false
        return -1
    }
    var oauth2Token_3:OAuth2AccessToken = OAuth2AccessToken("token", "tokenType", 100, "refreshToken3", "scope", "a=1&b=2&c=3")
    if (oauth2Token_0.equals(oauth2Token_3)){ //相同类型refreshToken不同 返回false
        return -1
    }
    var oauth2Token_4:OAuth2AccessToken = OAuth2AccessToken("token", "tokenType", 100, "refreshToken", "scope4", "a=1&b=2&c=3")
    if (oauth2Token_0.equals(oauth2Token_4)){ //相同类型scope不同 返回false
        return -1
    }
    var oauth2Token_5:OAuth2AccessToken = OAuth2AccessToken("token", "tokenType", 200, "refreshToken", "scope4", "a=1&b=2&c=3")
    if (oauth2Token_0.equals(oauth2Token_5)){ //相同类型expiresIn不同 返回false
        return -1
    }
    return 0
}

main() {
    var test_01 = testOAuth2_01()
    var test_02 = testOAuth2_02()
    var test_03 = testOAuth2_03()

    var sum = test_01+test_02+test_03
    println(sum)
    println("test_01=${test_01}, test_02=${test_02}, test_03=${test_03}")
    return sum
}