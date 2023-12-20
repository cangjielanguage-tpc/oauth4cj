// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from oauth4cj import oauth4cj.*

main() {

    var test_01 = testBaseStringExtractor_01()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testBaseStringExtractor_02()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    test_01 = testBaseStringExtractor_03()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testBaseStringExtractor_04()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    test_01 = testBaseStringExtractor_05()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testBaseStringExtractor_06()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    test_01 = testBaseStringExtractor_07()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    test_01 = testBaseStringExtractor_08()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    return test_01
}

func testBaseStringExtractor_01(): Int32 {

    let extractor: BaseStringExtractorImpl = BaseStringExtractorImpl()
    let expected: String = "GET&http%3A%2F%2Fexample.com&oauth_callback%3Dhttp%253A%252F%252Fexample%252Fcallback" +
            "%26oauth_consumer_key%3DAS%2523%2524%255E%252A%2540%2526%26oauth_signature%3DOAuth-Signature" +
            "%26oauth_timestamp%3D123456"
    
    let request: OAuth4cjRequest = createSampleOAuthRequest()
    let baseString: String = extractor.extract(request)

    println("baseString == expected: ${baseString == expected}")

    if (baseString != expected) {
        println(1)
        return 1
    }

    return 0
}

func testBaseStringExtractor_02(): Int32 {
    let extractor: BaseStringExtractorImpl = BaseStringExtractorImpl()
    let expected: String = "GET&http%3A%2F%2Fexample.com&oauth_callback%3Dhttp%253A%252F%252Fexample%252Fcallback" +
                "%26oauth_consumer_key%3DAS%2523%2524%255E%252A%2540%2526%26oauth_signature%3DOAuth-Signature" +
                "%26oauth_timestamp%3D123456"

    let requestPort80: OAuth4cjRequest = createSampleOAuthRequestPort80()
    let baseString: String = extractor.extract(requestPort80)

    println("baseString == expected: ${baseString == expected}")
    if (baseString != expected) {
        println(2)
        return 2
    }
    return 0
}

func testBaseStringExtractor_03(): Int32 {
    let extractor: BaseStringExtractorImpl = BaseStringExtractorImpl()
    let expected: String = "GET&http%3A%2F%2Fexample.com%2Ftest&oauth_callback%3Dhttp%253A%252F%252Fexample" +
                "%252Fcallback%26oauth_consumer_key%3DAS%2523%2524%255E%252A%2540%2526%26oauth_signature" +
                "%3DOAuth-Signature%26oauth_timestamp%3D123456"

    let requestPort80v2: OAuth4cjRequest = createSampleOAuthRequestPort80v2()
    let baseString: String = extractor.extract(requestPort80v2)
    println("baseString == expected: ${baseString == expected}")
    if (baseString != expected) {
        println(3)
        return 3
    }
    return 0
}

func testBaseStringExtractor_04(): Int32 {

    let extractor: BaseStringExtractorImpl = BaseStringExtractorImpl()
    let expected: String = "GET&http%3A%2F%2Fexample.com%3A8080&oauth_callback%3Dhttp%253A%252F%252Fexample" +
                 "%252Fcallback%26oauth_consumer_key%3DAS%2523%2524%255E%252A%2540%2526%26oauth_signature" +
                 "%3DOAuth-Signature%26oauth_timestamp%3D123456"

    let requestPort8080: OAuth4cjRequest = createSampleOAuthRequestPort8080()
    let baseString: String = extractor.extract(requestPort8080)
    println("baseString == expected: ${baseString == expected}")
    if (baseString != expected) {
        println(4)
        return 4
    }
    return 0
}

func testBaseStringExtractor_05(): Int32 {
    let extractor: BaseStringExtractorImpl = BaseStringExtractorImpl()
    let expected: String = "GET&https%3A%2F%2Fexample.com&oauth_callback%3Dhttp%253A%252F%252Fexample%252Fcallback" +
                 "%26oauth_consumer_key%3DAS%2523%2524%255E%252A%2540%2526%26oauth_signature%3DOAuth-Signature" +
                 "%26oauth_timestamp%3D123456"

    let requestPort443: OAuth4cjRequest = createSampleOAuthRequestPort443()
    let baseString: String = extractor.extract(requestPort443)
    println("baseString == expected: ${baseString == expected}")
    if (baseString != expected) {
        println(1)
        return 1
    }
    return 0
}

func testBaseStringExtractor_06(): Int32 {

    let extractor: BaseStringExtractorImpl = BaseStringExtractorImpl()
    let expected: String = "GET&https%3A%2F%2Fexample.com%2Ftest&oauth_callback%3Dhttp%253A%252F%252Fexample" +
                 "%252Fcallback%26oauth_consumer_key%3DAS%2523%2524%255E%252A%2540%2526%26oauth_signature" +
                 "%3DOAuth-Signature%26oauth_timestamp%3D123456"

    let requestPort443v2: OAuth4cjRequest = createSampleOAuthRequestPort443v2()
    let baseString: String = extractor.extract(requestPort443v2)

    println("baseString == expected: ${baseString == expected}")

    if (baseString != expected) {
        println(6)
        return 6
    }

    return 0
}

func testBaseStringExtractor_07(): Int32 {

    let extractor: BaseStringExtractorImpl = BaseStringExtractorImpl()
    let expected: String = "GET&http%3A%2F%2Fexample.com&body%3Dthis%2520param%2520has%2520whitespace" +
        "%26oauth_callback%3Dhttp%253A%252F%252Fexample%252Fcallback%26oauth_consumer_key" +
        "%3DAS%2523%2524%255E%252A%2540%2526%26oauth_signature%3DOAuth-Signature%26oauth_timestamp%3D123456"

    let request: OAuth4cjRequest = createSampleOAuthRequest()
    request.addBodyParameter("body", "this param has whitespace")

    let baseString: String = extractor.extract(request)

    println("baseString == expected: ${baseString == expected}")

    if (baseString != expected) {
        println(7)
        return 7
    }

    return 0
}

func testBaseStringExtractor_08(): Int32 {
    try {
        let extractor: BaseStringExtractorImpl = BaseStringExtractorImpl()

        let request: OAuth4cjRequest = OAuth4cjRequest(Verb.GET, "http://example.com")
        let baseString: String = extractor.extract(request)
        println(baseString.size)
    } catch (e: Exception) {
        //e.printStackTrace()
        return 0
    }

    println(8)
    return 8
}



func createSampleOAuthRequest(): OAuth4cjRequest {
    let request: OAuth4cjRequest = OAuth4cjRequest(Verb.GET, "http://example.com")
    request.addOAuthParameter(OAuthConstants.TIMESTAMP, "123456")
    request.addOAuthParameter(OAuthConstants.CONSUMER_KEY, "AS#$^*@&")
    request.addOAuthParameter(OAuthConstants.CALLBACK, "http://example/callback")
    request.addOAuthParameter(OAuthConstants.SIGNATURE, "OAuth-Signature")
    return request
}

func createSampleOAuthRequestPort80(): OAuth4cjRequest {
    let request: OAuth4cjRequest = OAuth4cjRequest(Verb.GET, "http://example.com:80")
    request.addOAuthParameter(OAuthConstants.TIMESTAMP, "123456")
    request.addOAuthParameter(OAuthConstants.CONSUMER_KEY, "AS#$^*@&")
    request.addOAuthParameter(OAuthConstants.CALLBACK, "http://example/callback")
    request.addOAuthParameter(OAuthConstants.SIGNATURE, "OAuth-Signature")
    return request
}

func createSampleOAuthRequestPort80v2(): OAuth4cjRequest {
    let request: OAuth4cjRequest = OAuth4cjRequest(Verb.GET, "http://example.com:80/test")
    request.addOAuthParameter(OAuthConstants.TIMESTAMP, "123456")
    request.addOAuthParameter(OAuthConstants.CONSUMER_KEY, "AS#$^*@&")
    request.addOAuthParameter(OAuthConstants.CALLBACK, "http://example/callback")
    request.addOAuthParameter(OAuthConstants.SIGNATURE, "OAuth-Signature")
    return request
}

func createSampleOAuthRequestPort8080(): OAuth4cjRequest {
    let request: OAuth4cjRequest = OAuth4cjRequest(Verb.GET, "http://example.com:8080")
    request.addOAuthParameter(OAuthConstants.TIMESTAMP, "123456")
    request.addOAuthParameter(OAuthConstants.CONSUMER_KEY, "AS#$^*@&")
    request.addOAuthParameter(OAuthConstants.CALLBACK, "http://example/callback")
    request.addOAuthParameter(OAuthConstants.SIGNATURE, "OAuth-Signature")
    return request
}

func createSampleOAuthRequestPort443(): OAuth4cjRequest {
    let request: OAuth4cjRequest = OAuth4cjRequest(Verb.GET, "https://example.com:443")
    request.addOAuthParameter(OAuthConstants.TIMESTAMP, "123456")
    request.addOAuthParameter(OAuthConstants.CONSUMER_KEY, "AS#$^*@&")
    request.addOAuthParameter(OAuthConstants.CALLBACK, "http://example/callback")
    request.addOAuthParameter(OAuthConstants.SIGNATURE, "OAuth-Signature")
    return request
}

func createSampleOAuthRequestPort443v2(): OAuth4cjRequest {
    let request: OAuth4cjRequest = OAuth4cjRequest(Verb.GET, "https://example.com:443/test")
    request.addOAuthParameter(OAuthConstants.TIMESTAMP, "123456")
    request.addOAuthParameter(OAuthConstants.CONSUMER_KEY, "AS#$^*@&")
    request.addOAuthParameter(OAuthConstants.CALLBACK, "http://example/callback")
    request.addOAuthParameter(OAuthConstants.SIGNATURE, "OAuth-Signature")
    return request
}
