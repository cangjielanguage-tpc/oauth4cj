// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from oauth4cj import model.*
from oauth4cj import utils.*
from oauth4cj import oauth2.clientauthentication.*

func testClientAuthentication_01(): Int32 {
    var url = "http://test/test"
    var request = OAuth4cjRequest(Verb.POST, url)
    var apiKey = "apiKey"
    var apiSecret = "apiSecret"
    var encodeString = Base64Utils.encode("${apiKey}:${apiSecret}".toUtf8Array())

    var client = HttpBasicAuthenticationScheme.instance()
    client.addClientAuthentication(request, apiKey, apiSecret)

    var headers = request.getHeaders()
    var header = headers.get(OAuthConstants.HEADER.toAsciiUpper())

    if (!header.getOrThrow().equals("${OAuthConstants.BASIC} ${encodeString}")) {
        return -1
    }

    return 0
}

func testClientAuthentication_02(): Int32 {
    var url = "http://test/test"
    var request = OAuth4cjRequest(Verb.GET, url)
    var apiKey = "apiKey"
    var apiSecret = "apiSecret"
    var client = RequestBodyAuthenticationScheme.instance()
    client.addClientAuthentication(request, apiKey, apiSecret)

    var query = request.getQueryStringParams()
    var paramList = query.getParams()
    var param = paramList[0]
    if (!param.getKey().equals(OAuthConstants.CLIENT_ID)) {
        return -1
    }

    if (!param.getValue().equals(apiKey)) {
        return -1
    }

    var param2 = paramList[1]
    if (!param2.getKey().equals(OAuthConstants.CLIENT_SECRET)) {
        return -1
    }

    if (!param2.getValue().equals(apiSecret)) {
        return -1
    }

    return 0
}

main() {
    var test_01 = testClientAuthentication_01()
    var test_02 = testClientAuthentication_02()


    var sum = test_01+test_02 
    println(sum)
    println("test_01=${test_01}, test_02=${test_02}")
    return sum
}