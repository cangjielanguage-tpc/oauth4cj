
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import std.collection.*
public import oauth4cj.*

func error(body: String): OAuth4cjResponse {
    return OAuth4cjResponse (400, "", HashMap<String, String>(), body)
}

main() {

    var test_01 = testOAuth2AccessTokenJsonExtractor_01()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    return test_01
}

func testOAuth2AccessTokenJsonExtractor_01(): Int32 {
    let extractor: OAuth2AccessTokenJsonExtractor = OAuth2AccessTokenJsonExtractor.instance()
    let responseBody: String = ""

    try {
        let response: OAuth4cjResponse = error(responseBody)
        let extracted: OAuth2AccessToken = extractor.extract(response)
        println(extracted.getAccessToken())
    } catch (e: IllegalArgumentException) {
        //e.printStackTrace()
        return 0
    }
    println(1)
    return 1
}
