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
    test_01 = testDeviceAuthorizationJsonExtractor_04()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    test_01 = testDeviceAuthorizationJsonExtractor_05()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    return test_01
}

func testDeviceAuthorizationJsonExtractor_01(): Int32 {
    let extractor: DeviceAuthorizationJsonExtractor = DeviceAuthorizationJsonExtractor.instance()

    let responseBody: String = ##"{"device_code": "","user_code": "user_code_v",
                                    "verification_uri": "Beijing","expires_in": 300}"##

    let response: OAuth4cjResponse = ok(responseBody)
    let da: DeviceAuthorization = extractor.extract(response)
    let str: String = da.toString()

    let result: String = "DeviceAuthorization{'deviceCode'='','userCode'='user_code_v'," +
        "'verificationUri'='Beijing','verificationUriComplete'='','expiresInSeconds'='300','intervalSeconds'='5'}"
    
    println("da.toString() = " + da.toString())

    if (str != result) {
        println(1)
        return 1
    }
    return 0
}

func testDeviceAuthorizationJsonExtractor_02(): Int32 {
    let extractor: DeviceAuthorizationJsonExtractor = DeviceAuthorizationJsonExtractor.instance()

    let responseBody: String = ##"{"device_code": "device_code_v","user_code": "user_code_v",
                                    "verification_uri": "Beijing","expires_in": 300}"##

    let response: OAuth4cjResponse = ok(responseBody)
    let da: DeviceAuthorization = extractor.extract(response)
    let str: String = da.toString()

    let result: String = "DeviceAuthorization{'deviceCode'='device_code_v','userCode'='user_code_v'," +
        "'verificationUri'='Beijing','verificationUriComplete'='','expiresInSeconds'='300','intervalSeconds'='5'}"

    println("da.toString() = " + da.toString())

    if (str != result) {
        println(2)
        return 2
    }
    return 0
}

func testDeviceAuthorizationJsonExtractor_03(): Int32 {
    let extractor: DeviceAuthorizationJsonExtractor = DeviceAuthorizationJsonExtractor.instance()

    let responseBody: String = ##"{"device_code": "device_code_v","user_code": "user_code_v",
                                    "verification_uri": "Beijing","expires_in": 300,"interval":10}"##

    let response: OAuth4cjResponse = ok(responseBody)
    let da: DeviceAuthorization = extractor.extract(response)
    let str: String = da.toString()

    let result: String = "DeviceAuthorization{'deviceCode'='device_code_v','userCode'='user_code_v'," +
        "'verificationUri'='Beijing','verificationUriComplete'='','expiresInSeconds'='300','intervalSeconds'='10'}"

    println("da.toString() = " + da.toString())

    if (str != result) {
        println(3)
        return 3
    }
    return 0
}


func testDeviceAuthorizationJsonExtractor_04(): Int32 {
    let extractor: DeviceAuthorizationJsonExtractor = DeviceAuthorizationJsonExtractor.instance()

    let responseBody: String = ##"{"device_code": ,"user_code": "user_code_v",
                                    "verification_uri": "Beijing","expires_in": 300,"interval":10}"##

    let response: OAuth4cjResponse = ok(responseBody)
    try {
        let da: DeviceAuthorization = extractor.extract(response)
        println(da.getDeviceCode())
    } catch (e: Exception) {
        //e.printStackTrace()
        return 0
    }
    println(4)
    return 4
}

func testDeviceAuthorizationJsonExtractor_05(): Int32 {
    let extractor: DeviceAuthorizationJsonExtractor = DeviceAuthorizationJsonExtractor.instance()

    let responseBody: String = ##"{"device_code": "","user_code": "user_code_v","verification_uri_complete": "123",
                                    "verification_uri": "Beijing","expires_in": 300}"##

    let response: OAuth4cjResponse = ok(responseBody)
    let da: DeviceAuthorization = extractor.extract(response)
    let str: String = da.toString()

    let result: String = "DeviceAuthorization{'deviceCode'='','userCode'='user_code_v'," +
        "'verificationUri'='Beijing','verificationUriComplete'='123','expiresInSeconds'='300','intervalSeconds'='5'}"

    println("da.toString() = " + da.toString())

    if (str != result) {
        println(5)
        return 5
    }
    return 0
}
