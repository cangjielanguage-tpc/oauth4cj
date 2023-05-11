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

    var test_01 = testOAuth1RequestTokenJSONExtractor_01()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testOAuth1RequestTokenJSONExtractor_02()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testOAuth1RequestTokenJSONExtractor_03()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testOAuth1RequestTokenJSONExtractor_04()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    return test_01
}

func testOAuth1RequestTokenJSONExtractor_01(): Int32 {
    let extractor: OAuth1RequestTokenJSONExtractor = OAuth1RequestTokenJSONExtractor.instance()
    let responseBody: String = ##"{"oauth_token": "hh5s93j4hdidpola","oauth_token_secret": "hdhd0244k9j7ao03"}"##

    let response: Response = ok(responseBody)
    let extracted: OAuth1RequestToken = extractor.extract(response)

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

func testOAuth1RequestTokenJSONExtractor_02(): Int32 {
    let extractor: OAuth1RequestTokenJSONExtractor = OAuth1RequestTokenJSONExtractor.instance()
    let responseBody: String = ##"{"oauth_token": "hdhd0244k9j7ao03","oauth_token_secret": "hh5s93j4hdidpola"}"##

    let response: Response = ok(responseBody)
    let extracted: OAuth1RequestToken = extractor.extract(response)

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

func testOAuth1RequestTokenJSONExtractor_03(): Int32 {
    let extractor: OAuth1RequestTokenJSONExtractor = OAuth1RequestTokenJSONExtractor.instance()
    let responseBody: String = ##"{"oauth_token": "hh5s93j4hdidpola","oauth_token_secret": "hdhd0244k9j7ao03"}"##

    let response: Response = ok(responseBody)
    let extracted: OAuth1RequestToken = extractor.extract(response)

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

func testOAuth1RequestTokenJSONExtractor_04(): Int32 {
    let extractor: OAuth1RequestTokenJSONExtractor = OAuth1RequestTokenJSONExtractor.instance()
    let responseBody: String = ##"{"oauth_token": "hh5s93j4hdidpola","oauth_token_secret": ""}"##

    let response: Response = ok(responseBody)
    let extracted: OAuth1RequestToken = extractor.extract(response)

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



