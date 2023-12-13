// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from oauth4cj import oauth4cj.*

// public init(verb: Verb, url: String)   public func addOAuthParameter(key: String, value: String)
// public func getOauthParameters() 
public func testRequest_01():Int32 {
    var url = "http://test/test"
    var request = OAuth4cjRequest(Verb.GET, url)
    if (url != request.getUrl()) {
        return -1
    }
    if (Verb.GET.toString() != request.getVerb().toString()) {
        return -1
    }

    var flag = true
    try {
        request.addOAuthParameter("key1", "value1")
    } catch (e: OAuth4cjParametersMissingException) {
        flag = false
        println(e)
    }
    if (flag) {
        return -1
    }
    request.addOAuthParameter("oauth_key2", "value2")
    request.addOAuthParameter("scope", "value3")
    request.addOAuthParameter("realm", "value4")
    
    var result = request.getOauthParameters()
    if (result["oauth_key2"] != "value2") {
        return -1
    }
    if (result["scope"] != "value3") {
        return -1
    }
    if (result["realm"] != "value4") {
        return -1
    }
    return 0
}

// public func setCharset(charsetName: String)  public func getCharset()
public func testRequest_02():Int32 {
    var url = "http://test/test"
    var request = OAuth4cjRequest(Verb.GET, url)
    var charset_1 = "UTF8"
    request.setCharset(charset_1)
    if (charset_1 != request.getCharset()) {
        return -1
    }
    var charset_2 = "utf8"
    request.setCharset(charset_2)
    if (charset_2 != request.getCharset()) {
        return -1
    }
    var charset_3 = "utf-8"
    request.setCharset(charset_3)
    if (charset_3 != request.getCharset()) {
        return -1
    }
    var charset_4 = "UTF-8"
    request.setCharset(charset_4)
    if (charset_4 != request.getCharset()) {
        return -1
    }

    var flag = true
    try {
        request.setCharset("GBK")
    } catch (e: OAuth4cjException) {
        flag = false
        println(e)
    }
    if (flag) {
        return -1
    }

    return 0
}

// public func getHeaders()  public func addHeader(key: String, value: String)
public func testRequest_03():Int32 {
    var url = "http://test/test"
    var request = OAuth4cjRequest(Verb.GET, url)
    request.addHeader("key1", "value1")
    request.addHeader("key2", "value2")
    request.addHeader("key3", "value3")
    var result = request.getHeaders()

    // 为啥要转成大写？？
    if (result["key1"] != "value1") {
        return -1
    }
    if (result["key2"] != "value2") {
        return -1
    }
    if (result["key3"] != "value3") {
        return -1
    }
    return 0
}

// public func setRealm(realm: String)  public func getRealm() 
public func testRequest_04():Int32 {
    var url = "http://test/test"
    var request = OAuth4cjRequest(Verb.GET, url)
    if ("" != request.getRealm()) {
        return -1
    }
    request.setRealm("realm")
    if ("realm" != request.getRealm()) {
        return -1
    }
    return 0
}

// public func addQuerystringParameter(key: String, value: String)  public func getCompleteUrl()
public func testRequest_05():Int32 {
    var url = "http://test/test"
    var request = OAuth4cjRequest(Verb.GET, url)
    println("request.getCompleteUrl() = ${request.getCompleteUrl()}")
    if (url != request.getCompleteUrl()) {
        return -1
    }
    request.addQuerystringParameter("key1", "value1")
    request.addQuerystringParameter("key2", "value2")
    var newUrl = "http://test/test?key1=value1&key2=value2"
    println("request.getCompleteUrl() = ${request.getCompleteUrl()}")
    if (newUrl != request.getCompleteUrl()) {
        println(request.getCompleteUrl())
        return -1
    }

    return 0
}

main() {
    var test_01 = testRequest_01()
    var test_02 = testRequest_02()
    var test_03 = testRequest_03()
    var test_04 = testRequest_04()
    var test_05 = testRequest_05()

    var sum = test_01+test_02+test_03+test_04+test_05
    println(sum)
    println("test_01=${test_01}, test_02=${test_02}, test_03=${test_03}, test_04=${test_04}, test_05=${test_05}")
    return sum
}