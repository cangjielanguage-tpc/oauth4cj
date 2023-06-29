// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from std import collection.*
from std import time.*
from oauth4cj import oauth.*
from oauth4cj import model.*
from oauth4cj import extractors.*
from oauth4cj import services.*

func testAPI10a_01(): Int32 {
    var apiA: A = A()
    var tokenEAccess: TokenExtractor<OAuth1AccessToken> = apiA.getAccessTokenExtractor()
    var tokenERequest: TokenExtractor<OAuth1RequestToken> = apiA.getRequestTokenExtractor()
    let responseBody: String = "oauth_token=access_token&oauth_token_secret=123456"
    let response: Response = Response(200, "", HashMap<String, String>(), responseBody)
    let oauth1AccessToken: OAuth1Token = tokenEAccess.extract(response)
    let oauth1RequestToken: OAuth1Token = tokenERequest.extract(response)

    if (!oauth1AccessToken.getToken().equals("access_token")) {
        return -1
    }
    if (!oauth1AccessToken.getTokenSecret().equals("123456")) {
        return -1
    }
    if (!oauth1RequestToken.getToken().equals("access_token")) {
        return -1
    }
    if (!oauth1RequestToken.getTokenSecret().equals("123456")) {
        return -1
    }
    return 0
}

func testAPI10a_02(): Int32 {
    var apiA: A = A()
    var baseStringE: BaseStringExtractor = apiA.getBaseStringExtractor()
    let expected: String = "GET&http%3A%2F%2Fexample.com&oauth_callback%3Dhttp%253A%252F%252Fexample%252Fcallback" +
            "%26oauth_consumer_key%3DAS%2523%2524%255E%252A%2540%2526%26oauth_signature%3DOAuth-Signature" +
            "%26oauth_timestamp%3D123456"
    let requestBaseString: OAuth4cjRequest = createSampleOAuthRequest()
    let baseString: String = baseStringE.extract(requestBaseString)
    if (!baseString.equals(expected)) {
        return -1
    }

    var headerE: HeaderExtractor =  apiA.getHeaderExtractor()
    let requestHeader: OAuth4cjRequest = createSampleOAuthRequest()
    let headerString = headerE.extract(requestHeader)
    if (!headerString.startsWith("OAuth")) {
        return -1
    }
    return 0
}

func testAPI10a_03(): Int32 {
    var apiA: A = A()
    var sign: SignatureService = apiA.getSignatureService()
    if (!sign.getSignatureMethod().equals("HMAC-SHA1")) {
        return -1
    }

    var oauth1Sign: OAuth1SignatureType = apiA.getSignatureType()
    if (!oauth1Sign.toString().equals("HEADER")) {
        return -1
    }

    if (oauth1Sign.toString().equals(OAuth1SignatureType.QUERY_STRING_SIGNATURE.toString())) {
        return -1
    }

    var timeS: TimestampService = apiA.getTimestampService()
    let timeResult: String = (getCurrentTimeMillis() / 1000).toString()
    if (!timeS.getTimestampInSeconds().equals(timeResult)) {
        return -1
    }

    return 0
}

func testAPI10a_04(): Int32 {
    var apiA: A = A()
    var verbAccess: Verb = apiA.getAccessTokenVerb()
    if (!verbAccess.toString().equals("POST")) {
        return -1
    }

    var verbRequest: Verb = apiA.getRequestTokenVerb()
    if (!verbRequest.toString().equals("POST")) {
        return -1
    }

    var isRequired: Bool = apiA.isEmptyOAuthTokenParamIsRequired()
    if (isRequired) {
        return -1
    }
    return 0
}

func testAPI10a_05(): Int32 {
    var apiA: A = A()
    var tokenERequest: TokenExtractor<OAuth1RequestToken> = apiA.getRequestTokenExtractor()
    let responseBody: String = "oauth_token=access_token&oauth_token_secret=123456"
    let response: Response = Response(200, "", HashMap<String, String>(), responseBody)
    let oauth1RequestToken = tokenERequest.extract(response) as OAuth1RequestToken
    var url = ""
    match (oauth1RequestToken) {
        case Some(x) => url = apiA.getAuthorizationUrl(x)
        case _ => return -1
    }
    
    let requestUrl = "getAuthorizationBaseUrl?oauth_token=access_token"
    if (!url.equals(requestUrl)) {
        println(url)
        return -1
    }
    return 0
}

class A <: DefaultApi10a {
    public init(){}
    public func getRequestTokenEndpoint(): String {
        return "getRequestTokenEndpoint"
    }

    public func getAccessTokenEndpoint(): String {
        return "getAccessTokenEndpoint"
    }

    protected func getAuthorizationBaseUrl(): String {
        return "getAuthorizationBaseUrl"
    }
}

func createSampleOAuthRequest(): OAuth4cjRequest {
    let request: OAuth4cjRequest = OAuth4cjRequest(Verb.GET, "http://example.com")
    request.addOAuthParameter(OAuthConstants.TIMESTAMP, "123456")
    request.addOAuthParameter(OAuthConstants.CONSUMER_KEY, "AS#$^*@&")
    request.addOAuthParameter(OAuthConstants.CALLBACK, "http://example/callback")
    request.addOAuthParameter(OAuthConstants.SIGNATURE, "OAuth-Signature")
    return request
}

func getCurrentTimeMillis(): Int64 {
    let res: Duration = Time.now() - Time(1970, Month.January, 1)
    return res.milliseconds()
}

main() {
    var test_01 = testAPI10a_01()
    var test_02 = testAPI10a_02()
    var test_03 = testAPI10a_03()
    var test_04 = testAPI10a_04()
    var test_05 = testAPI10a_05()

    var sum = test_01+test_02+test_03+test_04+test_05
    println(sum)
    println("test_01=${test_01}, test_02=${test_02}, test_03=${test_03}, test_04=${test_04}"+
            ", test_05=${test_05}")
    return sum
}