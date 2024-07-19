// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

public import oauth4cj.*

// OAuth1Token  OAuth1AccessToken

// public init("token", "tokenSecret", "a=1&b=2&c=3") getToken()预期返回"3" getTokenSecret()预期返回"tokenSecret"
public func testOAuth1_01():Int32 {
    var oauth1Token:OAuth1Token = OAuth1Token("token", "tokenSecret", "a=1&b=2&c=3")
    var rawResponse:String = oauth1Token.getRawResponse()
    if (rawResponse != "a=1&b=2&c=3") {
        return -1
    } 
    var parameter:String = oauth1Token.getParameter("c")
    if (parameter != "3") {
        return -1
    } 
    var token:String = oauth1Token.getToken()
    if (token != "token") {
        return -1
    } 
    var tokenSecret:String = oauth1Token.getTokenSecret()
    if (tokenSecret != "tokenSecret") {
        return -1
    } 
    return 0
}

// isEmpty() 
public func testOAuth1_02():Int32 {
    var oauth1Token:OAuth1Token = OAuth1Token()
    var oauth1Token_1:OAuth1Token = OAuth1Token("token", "tokenSecret", "rawResponse")
    var oauth1Token_2:OAuth1Token = OAuth1Token("", "tokenSecret", "rawResponse")
    var oauth1Token_3:OAuth1Token = OAuth1Token("token", "", "rawResponse")
    var oauth1Token_4:OAuth1Token = OAuth1Token("", "", "rawResponse")
    var oauth1Token_5:OAuth1Token = OAuth1Token("token", "tokenSecret", "")

    if (!oauth1Token.isEmpty()){
        return -1
    }
    if (oauth1Token_1.isEmpty()){
        return -1
    }
    if (oauth1Token_2.isEmpty()){
        return -1
    }
    if (oauth1Token_3.isEmpty()){
        return -1
    }
    if (!oauth1Token_4.isEmpty()){
        return -1
    }
    if (oauth1Token_5.isEmpty()){
        return -1
    }
    return 0
}

// public init("token", "tokenSecret", "a=1&b=2&c=3") getToken()预期返回"2" getTokenSecret()预期返回"tokenSecret"
public func testOAuth1_03():Int32 {
    var oauth1AccessToken:OAuth1AccessToken = OAuth1AccessToken("token", "tokenSecret", "a=1&b=2&c=3")
    var rawResponse:String = oauth1AccessToken.getRawResponse()
    if (rawResponse != "a=1&b=2&c=3") {
        return -1
    } 
    var parameter:String = oauth1AccessToken.getParameter("b")
    if (parameter != "2") {
        return -1
    } 
    var token:String = oauth1AccessToken.getToken()
    if (token != "token") {
        return -1
    } 
    var tokenSecret:String = oauth1AccessToken.getTokenSecret()
    if (tokenSecret != "tokenSecret") {
        return -1
    } 
    return 0
}

// public func equals(object:Object) 预计类型相同token tokenSecret 都相同返回true
public func testOAuth1_04():Int32 {
    var oauth1Token_0:OAuth1AccessToken = OAuth1AccessToken("token", "tokenSecret", "rawResponse")
    var oauth1Token_1:OAuth1Token = OAuth1Token("token", "tokenSecret", "rawResponse")
    if (oauth1Token_0.equals(oauth1Token_1)){ //父类型返回false
        return -1
    }

    var oauth1Token_2:OAuth1RequestToken = OAuth1RequestToken("token", "tokenSecret", true, "rawResponse")
    if (oauth1Token_0.equals(oauth1Token_2)){ //不同类型返回false
        return -1
    }

    var oauth1Token_3:OAuth1AccessToken = OAuth1AccessToken("token", "tokenSecret")
    if (!oauth1Token_0.equals(oauth1Token_3)){ //相同类型token tokenSecret相同返回true
        return -1
    }

    var oauth1Token_4:OAuth1AccessToken = OAuth1AccessToken("token4", "tokenSecret", "rawResponse")
    if (oauth1Token_0.equals(oauth1Token_4)){ //相同类型token不同返回false
        return -1
    }
    
    var oauth1Token_5:OAuth1AccessToken = OAuth1AccessToken("token", "tokenSecret5", "rawResponse")
    if (oauth1Token_0.equals(oauth1Token_5)){ //相同类型tokenSecret不同返回false
        return -1
    }

    var oauth1Token_6:OAuth1AccessToken = OAuth1AccessToken("token", "tokenSecret", "rawResponse6")
    if (!oauth1Token_0.equals(oauth1Token_6)){ //相同类型rawResponse6不同返回true
        return -1
    }
    return 0
}

main() {
    var test_01 = testOAuth1_01()
    var test_02 = testOAuth1_02()
    var test_03 = testOAuth1_03()
    var test_04 = testOAuth1_04()

    var sum = test_01+test_02+test_03+test_04
    println(sum)
    println("test_01=${test_01}, test_02=${test_02}, test_03=${test_03}, test_04=${test_04}")
    return sum
}