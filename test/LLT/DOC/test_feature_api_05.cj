// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

//1.5.2 示例
from oauth4cj import oauth4cj.*

public func createSampleOAuthRequest(): OAuth4cjRequest {
    let request: OAuth4cjRequest = OAuth4cjRequest(Verb.GET, "http://example.com")
    request.addOAuthParameter(OAuthConstants.TIMESTAMP, "123456")
    request.addOAuthParameter(OAuthConstants.CONSUMER_KEY, "AS#$^*@&")
    request.addOAuthParameter(OAuthConstants.CALLBACK, "http://example/callback")
    request.addOAuthParameter(OAuthConstants.SIGNATURE, "OAuth-Signature")
    return request
}

public func testBaseStringExtractor_01(): Int32 {
    let extractor: BaseStringExtractorImpl = BaseStringExtractorImpl()
    let expected: String = "GET&http%3A%2F%2Fexample.com&oauth_callback%3Dhttp%253A%252F%252Fexample%252Fcallback" +
            "%26oauth_consumer_key%3DAS%2523%2524%255E%252A%2540%2526%26oauth_signature%3DOAuth-Signature" +
            "%26oauth_timestamp%3D123456"
    let request: OAuth4cjRequest = createSampleOAuthRequest()
    let baseString: String = extractor.extract(request)
    if (baseString != expected) {
        return 1
    }
    println("baseString.equals(expected) = ${baseString.equals(expected)}")
    return 0
}

main() {
    var test_01 = testBaseStringExtractor_01()
    if (test_01 != 0){
        return test_01
    }
    return test_01
}