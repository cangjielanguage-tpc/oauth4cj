// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from std import collection.*

from oauth4cj import oauth4cj.*

func ok(body: String): OAuth4cjResponse {
    return OAuth4cjResponse (200, "", HashMap<String, String>(), body)
}

main() {

    var test_01 = testAbstractOAuth1JSONTokenExtractor_01()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testAbstractOAuth1JSONTokenExtractor_02()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testAbstractOAuth1JSONTokenExtractor_03()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    return test_01
}

func testAbstractOAuth1JSONTokenExtractor_01(): Int32 {
    let extractor: OAuth1RequestTokenJSONExtractor = OAuth1RequestTokenJSONExtractor.instance()
    let responseBody: String = ##"{"oauth_token_secret": "hdhd0244k9j7ao03"}"##
    let response: OAuth4cjResponse = ok(responseBody)
    try {
        let extracted: OAuth1RequestToken = extractor.extract(response)
        println(extracted.getToken())
    } catch (e: OAuth4cjException) {
        //e.printStackTrace()
        return 0
    }
    println(1)
    return 1
}


func testAbstractOAuth1JSONTokenExtractor_02(): Int32 {
    let extractor: OAuth1RequestTokenJSONExtractor = OAuth1RequestTokenJSONExtractor.instance()
    let responseBody: String = ##"{"oauth_token": "hh5s93j4hdidpola"}"##
    let response: OAuth4cjResponse = ok(responseBody)
    try {
        let extracted: OAuth1RequestToken = extractor.extract(response)
        println(extracted.getToken())
    } catch (e: OAuth4cjException) {
        //e.printStackTrace()
        return 0
    }
    println(2)
    return 2
}

func testAbstractOAuth1JSONTokenExtractor_03(): Int32 {
    let extractor: OAuth1RequestTokenJSONExtractor = OAuth1RequestTokenJSONExtractor.instance()
    let responseBody: String = ##"{"oauth_token": 8,"oauth_token_secret": -8}"##

    let response: OAuth4cjResponse = ok(responseBody)
    let extracted: OAuth1RequestToken = extractor.extract(response)

    if (extracted.getToken() != "8" || extracted.getTokenSecret() != "-8") {
        println(3)
        return 3
    }
    return 0
}
