// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from oauth4cj import extractors.*
from oauth4cj import model.*

main() {

    var test_01 = testHeaderExtractor_01()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testHeaderExtractor_02()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    test_01 = testHeaderExtractor_03()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    return test_01
}

func testHeaderExtractor_01(): Int32 {

    let extractor: HeaderExtractorImpl = HeaderExtractorImpl()
    let request: OAuth4cjRequest = createSampleOAuthRequest()

    let header: String = extractor.extract(request)

    println("header = [${header}]")

    let oauth: String = "OAuth "
    let callback: String = "oauth_callback=\"http%3A%2F%2Fexample%2Fcallback\""
    let signature: String = "oauth_signature=\"OAuth-Signature\""
    let key: String = "oauth_consumer_key=\"AS%23%24%5E%2A%40%26\""
    let timestamp: String = "oauth_timestamp=\"123456\""

    if (!header.startsWith(oauth)) {
        println(1)
        return 1
    }
    if (!header.contains(callback)) {
        println(2)
        return 2
    }
    if (!header.contains(signature)) {
        println(3)
        return 3
    }
    if (!header.contains(key)) {
        println(4)
        return 4
    }
    if (!header.contains(timestamp)) {
        println(5)
        return 5
    }

    var str: String = header.replace(oauth, "").replace(callback, "").replace(signature, "")
    str = str.replace(key, "").replace(timestamp, "")
    println("str = [${str}]")
    if (!str.equals(", , , ")) {
        println(6)
        return 6
    }

    return 0
}

func testHeaderExtractor_02(): Int32 {
    try {
        let extractor: HeaderExtractorImpl = HeaderExtractorImpl()

        let request: OAuth4cjRequest = OAuth4cjRequest(Verb.GET, "http://example.com")
        let baseString: String = extractor.extract(request)
        println(baseString.size)
    } catch (e: Exception) {
        //e.printStackTrace()
        return 0
    }

    println(7)
    return 7
}

func testHeaderExtractor_03(): Int32 {

    let extractor: HeaderExtractorImpl = HeaderExtractorImpl()
    let request: OAuth4cjRequest = createSampleOAuthRequest()
    request.setRealm("test realm")

    let header: String = extractor.extract(request)

    println("03-header = [${header}]")
    //03-header = [OAuth oauth_timestamp="123456", oauth_consumer_key="AS%23%24%5E%2A%40%26",
    //oauth_callback="http%3A%2F%2Fexample%2Fcallback", oauth_signature="OAuth-Signature", realm="test realm"]

    let oauth: String = "OAuth "
    let callback: String = "oauth_callback=\"http%3A%2F%2Fexample%2Fcallback\""
    let signature: String = "oauth_signature=\"OAuth-Signature\""
    let key: String = "oauth_consumer_key=\"AS%23%24%5E%2A%40%26\""
    let timestamp: String = "oauth_timestamp=\"123456\""
    let realm: String = "realm=\"test realm\""

    if (!header.startsWith(oauth)) {
        println(8)
        return 8
    }
    if (!header.contains(callback)) {
        println(9)
        return 9
    }
    if (!header.contains(signature)) {
        println(10)
        return 10
    }
    if (!header.contains(key)) {
        println(11)
        return 11
    }
    if (!header.contains(timestamp)) {
        println(12)
        return 12
    }

    var str: String = header.replace(oauth, "").replace(callback, "").replace(signature, "")
    str = str.replace(key, "").replace(timestamp, "").replace(realm, "")
    println("str = [${str}]")
    if (!str.equals(", , , , ")) {
        println(13)
        return 13
    }

    return 0
}


func createSampleOAuthRequest(): OAuth4cjRequest {
    let request: OAuth4cjRequest = OAuth4cjRequest(Verb.GET, "http://example.com")
    request.addOAuthParameter(OAuthConstants.TIMESTAMP, "123456")
    request.addOAuthParameter(OAuthConstants.CONSUMER_KEY, "AS#$^*@&")
    request.addOAuthParameter(OAuthConstants.CALLBACK, "http://example/callback")
    request.addOAuthParameter(OAuthConstants.SIGNATURE, "OAuth-Signature")
    return request
}
