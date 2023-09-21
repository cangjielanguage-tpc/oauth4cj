
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from std import collection.*

from oauth4cj import oauth4cj.*

func ok(body: String): OAuth4cjResponse {
    return OAuth4cjResponse (400, "", HashMap<String, String>(), body)
}

main() {

    var test_01 = testDeviceAuthorizationJsonExtractor_01()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testDeviceAuthorizationJsonExtractor_02()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    return test_01
}

func testDeviceAuthorizationJsonExtractor_01(): Int32 {
    let extractor: DeviceAuthorizationJsonExtractor = DeviceAuthorizationJsonExtractor.instance()
    let responseBody: String = ##"{"error_uri": "","error": "404","error_description": "ceshi20230508"}"##
    let response: OAuth4cjResponse = ok(responseBody)
    try {
        let da: DeviceAuthorization = extractor.extract(response)
        println(da.getDeviceCode())
    } catch (e: Exception) {
        //e.printStackTrace()
        return 0
    }
    println(1)
    return 1
}

func testDeviceAuthorizationJsonExtractor_02(): Int32 {
    let extractor: DeviceAuthorizationJsonExtractor = DeviceAuthorizationJsonExtractor.instance()

    let responseBody: String = ##"{"user_code": "user_code_v",
                                    "verification_uri": "Beijing","expires_in": 300,"interval":10}"##

    let response: OAuth4cjResponse = ok(responseBody)
    try {
        let da: DeviceAuthorization = extractor.extract(response)
        println(da.getDeviceCode())
    } catch (e: Exception) {
        //e.printStackTrace()
        return 0
    }
    println(2)
    return 2
}
