// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import std.collection.*

public import oauth4cj.*

func ok(body: String): OAuth4cjResponse {
    return OAuth4cjResponse (200, "", HashMap<String, String>(), body)
}

main() {

    var test_01 = testOAuth2AccessTokenExtractor_01()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testOAuth2AccessTokenExtractor_02()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testOAuth2AccessTokenExtractor_03()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testOAuth2AccessTokenExtractor_04()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    return test_01
}

func testOAuth2AccessTokenExtractor_01(): Int32 {
    let extractor: OAuth2AccessTokenExtractor = OAuth2AccessTokenExtractor.instance()
    let responseBody: String = "access_token=166942940015970|2.2ltzWXYNDjCtg5ZDVVJJeg__.3600.1295816400-548517159" +
                               "|RsXNdKrpxg8L6QNLWcs2TVTmcaE"

    let response: OAuth4cjResponse = ok(responseBody)
    let extracted: OAuth2AccessToken = extractor.extract(response)

    let str:String = "166942940015970|2.2ltzWXYNDjCtg5ZDVVJJeg__.3600.1295816400-548517159|RsXNdKrpxg8L6QNLWcs2TVTmcaE"

    if (extracted.getAccessToken() != str) {
        println(1)
        return 1
    }
    println("--------------------------------------------------------")
    return 0
}

func testOAuth2AccessTokenExtractor_02(): Int32 {
    let extractor: OAuth2AccessTokenExtractor = OAuth2AccessTokenExtractor.instance()
    let responseBody: String = "access_token=166942940015970|2.2ltzWXYNDjCtg5ZDVVJJeg__.3600.1295816400-548517159" +
                               "|RsXNdKrpxg8L6QNLWcs2TVTmcaE&expires_in=5108"

    let response: OAuth4cjResponse = ok(responseBody)
    let extracted: OAuth2AccessToken = extractor.extract(response)

    let str:String = "166942940015970|2.2ltzWXYNDjCtg5ZDVVJJeg__.3600.1295816400-548517159|RsXNdKrpxg8L6QNLWcs2TVTmcaE"

    if (extracted.getAccessToken() != str) {
        println(2)
        return 2
    }
    print("extracted.getExpiresIn() = ")
    println(extracted.getExpiresIn())
    if (extracted.getExpiresIn() != 5108) {
        println(3)
        return 3
    }
    return 0
}

func testOAuth2AccessTokenExtractor_03(): Int32 {
    let extractor: OAuth2AccessTokenExtractor = OAuth2AccessTokenExtractor.instance()
    let responseBody: String = "access_token=166942940015970|2.2ltzWXYNDjCtg5ZDVVJJeg__.3600.1295816400-548517159" +
                     "|RsXNdKrpxg8L6QNLWcs2TVTmcaE&expires_in=5108&token_type=bearer&refresh_token=166942940015970"

    let response: OAuth4cjResponse = ok(responseBody)
    let extracted: OAuth2AccessToken = extractor.extract(response)

    let str:String = "166942940015970|2.2ltzWXYNDjCtg5ZDVVJJeg__.3600.1295816400-548517159|RsXNdKrpxg8L6QNLWcs2TVTmcaE"

    if (extracted.getAccessToken() != str) {
        println(4)
        return 4
    }
    if (extracted.getExpiresIn() != 5108) {
        println(5)
        return 5
    }
    if (extracted.getTokenType() != "bearer") {
        println(6)
        return 6
    }
    if (extracted.getRefreshToken() != "166942940015970") {
        println(7)
        return 7
    }
    return 0
}

func testOAuth2AccessTokenExtractor_04(): Int32 {
    let extractor: OAuth2AccessTokenExtractor = OAuth2AccessTokenExtractor.instance()
    let responseBody: String = "access_token=foo1234&other_stuff=yeah_we_have_this_too&number=42"

    let response: OAuth4cjResponse = ok(responseBody)
    let extracted: OAuth2AccessToken = extractor.extract(response)

    if (extracted.getAccessToken() != "foo1234") {
        println(8)
        return 8
    }
    return 0
}

