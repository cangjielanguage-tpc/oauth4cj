
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import std.collection.*

public import oauth4cj.*

func ok(body: String): OAuth4cjResponse {
    return OAuth4cjResponse (200, "", HashMap<String, String>(), body)
}

main() {

    var test_01 = testOAuth1AccessTokenJSONExtractor_01()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testOAuth1AccessTokenJSONExtractor_02()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    return test_01
}

func testOAuth1AccessTokenJSONExtractor_01(): Int32 {
    let extractor: OAuth1AccessTokenJSONExtractor = OAuth1AccessTokenJSONExtractor.instance()
    let responseBody: String = ##"{"oauth_token": "", "oauth_token_secret": "hdhd0244k9j7ao03"}"##

    let response: OAuth4cjResponse = ok(responseBody)
    let extracted: OAuth1AccessToken = extractor.extract(response)

    println("extracted.getToken() = ${extracted.getToken()}")
    println("extracted.getTokenSecret() = ${extracted.getTokenSecret()}")
    if (extracted.getToken() != "") {
        println(1)
        return 1
    }
    if (extracted.getTokenSecret() != "hdhd0244k9j7ao03") {
        println(2)
        return 2
    }
    return 0
}

func testOAuth1AccessTokenJSONExtractor_02(): Int32 {
    let extractor: OAuth1AccessTokenJSONExtractor = OAuth1AccessTokenJSONExtractor.instance()
    let responseBody: String = ##"{"oauth_token": "hdhd0244k9j7ao03", "oauth_token_secret": ""}"##

    let response: OAuth4cjResponse = ok(responseBody)
    let extracted: OAuth1AccessToken = extractor.extract(response)

    if (extracted.getToken() != "hdhd0244k9j7ao03") {
        println(3)
        return 3
    }
    if (extracted.getTokenSecret() != "") {
        println(4)
        return 4
    }
    return 0
}
