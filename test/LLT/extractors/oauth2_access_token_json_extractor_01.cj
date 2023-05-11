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

    var test_01 = testOAuth2AccessTokenJsonExtractor_01()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testOAuth2AccessTokenJsonExtractor_02()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testOAuth2AccessTokenJsonExtractor_03()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testOAuth2AccessTokenJsonExtractor_04()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    return test_01
}

func testOAuth2AccessTokenJsonExtractor_01(): Int32 {
    let extractor: OAuth2AccessTokenJsonExtractor = OAuth2AccessTokenJsonExtractor.instance()
    let responseBody: String = 
        ##"{"access_token":"I0122HHJKLEM21F3WLPYHDKGKZULAUO4SGMV3ABKFTDT3T3X", "token_type":"example"}"##

    let response: Response = ok(responseBody)
    let extracted: OAuth2AccessToken = extractor.extract(response)
    let str: String = extracted.getAccessToken()
    let result: String = "I0122HHJKLEM21F3WLPYHDKGKZULAUO4SGMV3ABKFTDT3T3X"
                       //"I0122HHJKLEM21F3WLPYHDKGKZULAUO4SGMV3ABKFTDT3T3X"
    println(str)
    println(str.toUtf8Array())
    println(str.equals(result))
    println(result.toUtf8Array())

    if (!str.equals(result)) {
        println(1)
        return 1
    }
    return 0
}

func testOAuth2AccessTokenJsonExtractor_02(): Int32 {
    let extractor: OAuth2AccessTokenJsonExtractor = OAuth2AccessTokenJsonExtractor.instance()
    let responseBody: String = 
        ##"{"access_token":"I0122HHJKLEM21F3WLPYHDKGKZULAUO4SGMV3ABKFTDT3T4X","token_type":"example","scope":"s1"}"##

    let response: Response = ok(responseBody)
    let extracted: OAuth2AccessToken = extractor.extract(response)

    if (!extracted.getAccessToken().equals("I0122HHJKLEM21F3WLPYHDKGKZULAUO4SGMV3ABKFTDT3T4X")) {
        println(2)
        return 2
    }
    if (!extracted.getScope().equals("s1")) {
        println(3)
        return 3
    }
    return 0
}

func testOAuth2AccessTokenJsonExtractor_03(): Int32 {
    let extractor: OAuth2AccessTokenJsonExtractor = OAuth2AccessTokenJsonExtractor.instance()
    let responseBody: String = 
    ##"{"access_token":"I0122HHJKLEM21F3WLPYHDKGKZULAUO4SGMV3ABKFTDT3T5X", "token_type":"example","scope":"s1 s2"}"##

    let response: Response = ok(responseBody)
    let extracted: OAuth2AccessToken = extractor.extract(response)

    if (!extracted.getAccessToken().equals("I0122HHJKLEM21F3WLPYHDKGKZULAUO4SGMV3ABKFTDT3T5X")) {
        println(4)
        return 4
    }
    if (!extracted.getScope().equals("s1 s2")) {
        println(5)
        return 5
    }
    return 0
}

func testOAuth2AccessTokenJsonExtractor_04(): Int32 {
    let extractor: OAuth2AccessTokenJsonExtractor = OAuth2AccessTokenJsonExtractor.instance()
    let responseBody: String = ##"{"access_token":"I0122HHJKLEM21F3WLPYHDKGKZULAUO4SGMV3ABKFTDT3T6X",
                                "token_type":"example","scope":"s3 s4", "refresh_token":"refresh_token1"}"##

    let response: Response = ok(responseBody)
    let extracted: OAuth2AccessToken = extractor.extract(response)

    if (!extracted.getAccessToken().equals("I0122HHJKLEM21F3WLPYHDKGKZULAUO4SGMV3ABKFTDT3T6X")) {
        println(6)
        return 6
    }
    if (!extracted.getScope().equals("s3 s4")) {
        println(7)
        return 7
    }
    if (!extracted.getRefreshToken().equals("refresh_token1")) {
        println(8)
        return 8
    }
    return 0
}

