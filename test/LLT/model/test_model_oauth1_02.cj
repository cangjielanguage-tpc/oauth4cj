// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from oauth4cj import model.*

// OAuth1RequestToken

// public init("token", "tokenSecret", "a=1&b=2&c=3") 
public func testOAuth1_05():Int32 {
    var oauth1RequestToken:OAuth1RequestToken = OAuth1RequestToken("token", "tokenSecret", true, "a=1&b=2&c=3")
    var rawResponse:String = oauth1RequestToken.getRawResponse()
    if (!rawResponse.equals("a=1&b=2&c=3")) {
        return -1
    } 
    var parameter:String = oauth1RequestToken.getParameter("a")
    if (!parameter.equals("1")) {
        return -1
    } 
    var token:String = oauth1RequestToken.getToken()
    if (!token.equals("token")) {
        return -1
    } 
    var tokenSecret:String = oauth1RequestToken.getTokenSecret()
    if (!tokenSecret.equals("tokenSecret")) {
        return -1
    } 
    var oauthCallbackConfirmed:Bool = oauth1RequestToken.isOauthCallbackConfirmed()
    if (!oauthCallbackConfirmed) {
        return -1
    } 
    return 0
}

// public init("token", "tokenSecret", oauthCallbackConfirmed:false, "a=1&b=2&c=3") 
public func testOAuth1_06():Int32 {
    var oauth1RequestToken:OAuth1RequestToken = OAuth1RequestToken("token", "tokenSecret", false, "a=1&b=2&c=3")
    var oauthCallbackConfirmed:Bool = oauth1RequestToken.isOauthCallbackConfirmed()
    if (oauthCallbackConfirmed) {
        return -1
    } 
    return 0
}

// public func equals(object:Object):Bool
public func testOAuth1_07():Int32 {
    var oauth1Token_0:OAuth1RequestToken = OAuth1RequestToken("token", "tokenSecret", "rawResponse")
    var oauth1Token_1:OAuth1Token = OAuth1Token("token", "tokenSecret", "rawResponse")
    if (oauth1Token_0.equals(oauth1Token_1)){ //父类型返回false
        return -1
    }

    var oauth1Token_2:OAuth1AccessToken = OAuth1AccessToken("token", "tokenSecret", "rawResponse")
    if (oauth1Token_0.equals(oauth1Token_2)){ //不同类型返回false
        return -1
    }

    var oauth1Token_3:OAuth1RequestToken = OAuth1RequestToken("token", "tokenSecret")
    if (!oauth1Token_0.equals(oauth1Token_3)){ //相同类型token tokenSecret相同返回true
        return -1
    }

    var oauth1Token_4:OAuth1RequestToken = OAuth1RequestToken("token4", "tokenSecret", false, "rawResponse")
    if (oauth1Token_0.equals(oauth1Token_4)){ //相同类型token不同返回false
        return -1
    }
    
    var oauth1Token_5:OAuth1RequestToken = OAuth1RequestToken("token", "tokenSecret5", false, "rawResponse")
    if (oauth1Token_0.equals(oauth1Token_5)){ //相同类型tokenSecret不同返回false
        return -1
    }

    var oauth1Token_6:OAuth1RequestToken = OAuth1RequestToken("token", "tokenSecret", true, "rawResponse6")
    if (!oauth1Token_0.equals(oauth1Token_6)){ //相同类型rawResponse不同不影响,返回true
        return -1
    }

    var oauth1Token_7:OAuth1RequestToken = OAuth1RequestToken("token", "tokenSecret", false, "rawResponse")
    if (!oauth1Token_0.equals(oauth1Token_7)){ //相同类型oauthCallbackConfirmed不同不影响,返回true
        return -1
    }
    return 0
}

main() {
    var test_05 = testOAuth1_05()
    var test_06 = testOAuth1_06()
    var test_07 = testOAuth1_07()

    var sum = test_05+test_06+test_07
    println(sum)
    println("test_05=${test_05}, test_06=${test_06}, test_07=${test_07}")
    return sum
}