
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from std import collection.*

from oauth4cj import oauth4cj.*
func ok(body: String): OAuth4cjResponse {
    return OAuth4cjResponse (200, "", HashMap<String, String>(), body)
}
func error(body: String): OAuth4cjResponse {
    return OAuth4cjResponse (400, "", HashMap<String, String>(), body)
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
        ##"{"error_description":"unknown, invalid, or expired refresh token","error":"invalid_grant"}"##

    try {
        let response: OAuth4cjResponse = error(responseBody)
        let extracted: OAuth2AccessToken = extractor.extract(response)
        println(extracted.getAccessToken())
    } catch (e: OAuth2AccessTokenErrorResponse) {
        //e.printStackTrace()
        if (!OAuth2Error.INVALID_GRANT.getErrorString().equals(e.getError().getOrThrow().getErrorString())) {
            println(1)
            return 1
        }

        println("e.getErrorDescription() = " + e.getErrorDescription())
        if (!e.getErrorDescription().equals("unknown, invalid, or expired refresh token")) {
            println(2)
            return 2
        }
        return 0
    }

    println(21)
    return 21
}

func testOAuth2AccessTokenJsonExtractor_02(): Int32 {
    let extractor: OAuth2AccessTokenJsonExtractor = OAuth2AccessTokenJsonExtractor.instance()
    let responseBody: String = ##"{ "access_token":"I0122HKLEM2/MV3ABKFTDT3T5X","token_type":"example"}"##

    let response: OAuth4cjResponse = ok(responseBody)
    let extracted: OAuth2AccessToken = extractor.extract(response)
    let str: String = extracted.getAccessToken()

    if (!str.equals("I0122HKLEM2/MV3ABKFTDT3T5X")) {
        println(3)
        return 3
    }
    return 0
}

func testOAuth2AccessTokenJsonExtractor_03(): Int32 {
    let extractor: OAuth2AccessTokenJsonExtractor = OAuth2AccessTokenJsonExtractor.instance()
    let responseBody: String = 
    ##"{"access_token":"I0122HHJKLEM21F3WLPYHDKGKZULAUO4SGMV3ABKFTDT3T5X", "token_type":"example","scope":"s1 s2"}"##

    let response: OAuth4cjResponse = ok(responseBody)
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

    let response: OAuth4cjResponse = ok(responseBody)
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

