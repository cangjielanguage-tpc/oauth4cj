// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from oauth4cj import model.*
from oauth4cj import oauth2.bearersignature.*

func testBearerSignature_01(): Int32 {
    var url = "http://test/test"
    var request = OAuth4cjRequest(Verb.POST, url)
    var accessToken = "accessToken=123"
    var field = BearerSignatureAuthorizationRequestHeaderField.instance()
    field.signRequest(accessToken, request)

    var headers = request.getHeaders()
    var header = headers.get(OAuthConstants.HEADER_AUTHORIZATION)

    if (!header.getOrThrow().equals("Bearer ${accessToken}")) {
        return -1
    }

    return 0
}

func testBearerSignature_02(): Int32 {
    var url = "http://test/test"
    var request = OAuth4cjRequest(Verb.POST, url)
    var accessToken = "accessToken=123"
    var field = BearerSignatureURIQueryParameter.instance()
    field.signRequest(accessToken, request)

    var query = request.getQueryStringParams()
    var paramList = query.getParams()
    var param = paramList[0]
    if (!param.getKey().equals(OAuthConstants.ACCESS_TOKEN)) {
        return -1
    }

    if (!param.getValue().equals(accessToken)) {
        return -1
    }

    return 0
}

main() {
    var test_01 = testBearerSignature_01()
    var test_02 = testBearerSignature_02()

    var sum = test_01+test_02
    println(sum)
    println("test_01=${test_01}, test_02=${test_02}")
    return sum
}
