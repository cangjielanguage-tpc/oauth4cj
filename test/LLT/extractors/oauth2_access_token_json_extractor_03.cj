
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from std import collection.*

from oauth4cj import extractors.*
from oauth4cj import model.*
from oauth4cj import exceptions.*

func ok(body: String): Response {
    return Response(200, "", HashMap<String, String>(), body)
}
func error(body: String): Response {
    return Response(400, "", HashMap<String, String>(), body)
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
        let response: Response = error(responseBody)
        let extracted: OAuth2AccessToken = extractor.extract(response)
    } catch (e: IllegalArgumentException) {
        e.printStackTrace()
        return 0
    }
    println(1)
    return 1
}
