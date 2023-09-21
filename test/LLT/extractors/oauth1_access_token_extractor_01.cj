// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from std import collection.*

from oauth4cj import oauth4cj.*

func ok(body: String): OAuth4cjResponse {
    return OAuth4cjResponse (200, "", HashMap<String, String>(), body)
}

main() {

    var test_01 = testOAuth1AccessTokenExtractor_01()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testOAuth1AccessTokenExtractor_02()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testOAuth1AccessTokenExtractor_03()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testOAuth1AccessTokenExtractor_04()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    return test_01
}

func testOAuth1AccessTokenExtractor_01(): Int32 {
    let extractor: OAuth1AccessTokenExtractor = OAuth1AccessTokenExtractor.instance()
    let responseBody: String = "oauth_token=hh5s93j4hdidpola&oauth_token_secret=hdhd0244k9j7ao03"

    let response: OAuth4cjResponse = ok(responseBody)
    let extracted: OAuth1Token = extractor.extract(response)

    if (!extracted.getToken().equals("hh5s93j4hdidpola")) {
        println(1)
        return 1
    }
    if (!extracted.getTokenSecret().equals("hdhd0244k9j7ao03")) {
        println(2)
        return 2
    }
    return 0
}

func testOAuth1AccessTokenExtractor_02(): Int32 {
    let extractor: OAuth1AccessTokenExtractor = OAuth1AccessTokenExtractor.instance()
    let responseBody: String = "oauth_token_secret=hh5s93j4hdidpola&oauth_token=hdhd0244k9j7ao03"

    let response: OAuth4cjResponse = ok(responseBody)
    let extracted: OAuth1Token = extractor.extract(response)

    if (!extracted.getToken().equals("hdhd0244k9j7ao03")) {
        println(3)
        return 3
    }
    if (!extracted.getTokenSecret().equals("hh5s93j4hdidpola")) {
        println(4)
        return 4
    }
    return 0
}

func testOAuth1AccessTokenExtractor_03(): Int32 {
    let extractor: OAuth1AccessTokenExtractor = OAuth1AccessTokenExtractor.instance()
    let responseBody: String = "oauth_token=hh5s93j4hdidpola&oauth_token_secret=hdhd0244k9j7ao03" +
                               "&callback_confirmed=true"

    let response: OAuth4cjResponse = ok(responseBody)
    let extracted: OAuth1Token = extractor.extract(response)

    if (!extracted.getToken().equals("hh5s93j4hdidpola")) {
        println(5)
        return 5
    }
    if (!extracted.getTokenSecret().equals("hdhd0244k9j7ao03")) {
        println(6)
        return 6
    }
    return 0
}

func testOAuth1AccessTokenExtractor_04(): Int32 {
    let extractor: OAuth1AccessTokenExtractor = OAuth1AccessTokenExtractor.instance()
    let responseBody: String = "oauth_token=hh5s93j4hdidpola&oauth_token_secret="

    let response: OAuth4cjResponse = ok(responseBody)
    let extracted: OAuth1Token = extractor.extract(response)

    if (!extracted.getToken().equals("hh5s93j4hdidpola")) {
        println(7)
        return 7
    }
    if (!extracted.getTokenSecret().equals("")) {
        println(8)
        return 8
    }
    return 0
}



