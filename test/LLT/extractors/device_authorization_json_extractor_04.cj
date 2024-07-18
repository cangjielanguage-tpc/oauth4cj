
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import std.collection.*

public import oauth4cj.*

func ok(body: String): OAuth4cjResponse {
    return OAuth4cjResponse (200, "", HashMap<String, String>(), body)
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
    test_01 = testDeviceAuthorizationJsonExtractor_03()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }


    return test_01
}

func testDeviceAuthorizationJsonExtractor_01(): Int32 {
    let extractor: DeviceAuthorizationJsonExtractor = DeviceAuthorizationJsonExtractor.instance()

    let responseBody: String = ##"{"device_code": "device_code_v","user_code": "user_code_v",
                                    "verification_uri": "3","expires_in": "300","interval": "8",
                                    "verification_uri_complete": 6}"##

    let response: OAuth4cjResponse = ok(responseBody)
    let da: DeviceAuthorization = extractor.extract(response)
    let str: String = da.toString()

    let result: String = "DeviceAuthorization{'deviceCode'='device_code_v','userCode'='user_code_v'," +
        "'verificationUri'='3','verificationUriComplete'='6'," +
        "'expiresInSeconds'='0','intervalSeconds'='8'}"

    println("da.toString() = " + da.toString())

    if (str != result) {
        println(1)
        return 1
    }
    return 0
}

func testDeviceAuthorizationJsonExtractor_02(): Int32 {
    let extractor: DeviceAuthorizationJsonExtractor = DeviceAuthorizationJsonExtractor.instance()

    let responseBody: String = ##"{"device_code": 1,"user_code": 2,
                                    "verification_uri": 3,"expires_in": "300","interval": "8",
                                    "verification_uri_complete": 6}"##

    let response: OAuth4cjResponse = ok(responseBody)
    let da: DeviceAuthorization = extractor.extract(response)
    let str: String = da.toString()

    let result: String = "DeviceAuthorization{'deviceCode'='','userCode'=''," +
        "'verificationUri'='','verificationUriComplete'='6'," +
        "'expiresInSeconds'='0','intervalSeconds'='8'}"

    println("da.toString() = " + da.toString())

    if (str != result) {
        println(2)
        return 2
    }
    return 0
}

func testDeviceAuthorizationJsonExtractor_03(): Int32 {
    let extractor: DeviceAuthorizationJsonExtractor = DeviceAuthorizationJsonExtractor.instance()

    let responseBody: String = ##"{"device_code": 1,"user_code": 2,
                                    "verification_uri": 3,"expires_in": "300","interval": "++8",
                                    "verification_uri_complete": 6}"##

    let response: OAuth4cjResponse = ok(responseBody)
    let da: DeviceAuthorization = extractor.extract(response)
    let str: String = da.toString()

    let result: String = "DeviceAuthorization{'deviceCode'='','userCode'=''," +
        "'verificationUri'='','verificationUriComplete'='6'," +
        "'expiresInSeconds'='0','intervalSeconds'='8'}"

    println("da.toString() = " + da.toString())

    if (str != result) {
        println(3)
        return 3
    }
    return 0
}

