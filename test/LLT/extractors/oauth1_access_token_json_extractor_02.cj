
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from std import collection.*

from oauth4cj import extractors.*
from oauth4cj import model.*
from oauth4cj import exceptions.*

func ok(body: String): Response {
    return Response(200, "", HashMap<String, String>(), body)
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

    let response: Response = ok(responseBody)
    let extracted: OAuth1AccessToken = extractor.extract(response)

    println("extracted.getToken() = ${extracted.getToken()}")
    println("extracted.getTokenSecret() = ${extracted.getTokenSecret()}")
    if (!extracted.getToken().equals("")) {
        println(1)
        return 1
    }
    if (!extracted.getTokenSecret().equals("hdhd0244k9j7ao03")) {
        println(2)
        return 2
    }
    return 0
}

func testOAuth1AccessTokenJSONExtractor_02(): Int32 {
    let extractor: OAuth1AccessTokenJSONExtractor = OAuth1AccessTokenJSONExtractor.instance()
    let responseBody: String = ##"{"oauth_token": "hdhd0244k9j7ao03", "oauth_token_secret": ""}"##

    let response: Response = ok(responseBody)
    let extracted: OAuth1AccessToken = extractor.extract(response)

    if (!extracted.getToken().equals("hdhd0244k9j7ao03")) {
        println(3)
        return 3
    }
    if (!extracted.getTokenSecret().equals("")) {
        println(4)
        return 4
    }
    return 0
}
