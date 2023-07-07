
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from std import collection.*

from oauth4cj import extractors.*
from oauth4cj import model.*
from oauth4cj import exceptions.*

func ok(body: String): Response {
    return Response(200, "", HashMap<String, String>(), body)
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
    test_01 = testDeviceAuthorizationJsonExtractor_06()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    test_01 = testDeviceAuthorizationJsonExtractor_07()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    test_01 = testDeviceAuthorizationJsonExtractor_08()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testDeviceAuthorizationJsonExtractor_09()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testDeviceAuthorizationJsonExtractor_10()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    test_01 = testDeviceAuthorizationJsonExtractor_11()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testDeviceAuthorizationJsonExtractor_12()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    return test_01
}

func testDeviceAuthorizationJsonExtractor_01(): Int32 {
    let extractor: DeviceAuthorizationJsonExtractor = DeviceAuthorizationJsonExtractor.instance()

    let responseBody: String = ##"{"device_code": "device_code_v","user_code": "user_code_v",
                                    "verification_uri": "Beijing","expires_in": "300","interval": "2"}"##

    let response: Response = ok(responseBody)
    let da: DeviceAuthorization = extractor.extract(response)
    let str: String = da.toString()

    let result: String = "DeviceAuthorization{'deviceCode'='device_code_v','userCode'='user_code_v'," +
        "'verificationUri'='Beijing','verificationUriComplete'='','expiresInSeconds'='0','intervalSeconds'='2'}"

    println("da.toString() = " + da.toString())

    if (!str.equals(result)) {
        println(1)
        return 1
    }
    return 0
}

func testDeviceAuthorizationJsonExtractor_02(): Int32 {
    let extractor: DeviceAuthorizationJsonExtractor = DeviceAuthorizationJsonExtractor.instance()

    let responseBody: String = ##"{"device_code": "device_code_v","user_code": "user_code_v",
                                    "verification_uri": "Beijing","expires_in": "abc","interval": ""}"##

    let response: Response = ok(responseBody)
    let da: DeviceAuthorization = extractor.extract(response)
    let str: String = da.toString()

    let result: String = "DeviceAuthorization{'deviceCode'='device_code_v','userCode'='user_code_v'," +
        "'verificationUri'='Beijing','verificationUriComplete'='','expiresInSeconds'='0','intervalSeconds'='5'}"

    println("da.toString() = " + da.toString())

    if (!str.equals(result)) {
        println(2)
        return 2
    }
    return 0
}

func testDeviceAuthorizationJsonExtractor_03(): Int32 {
    let extractor: DeviceAuthorizationJsonExtractor = DeviceAuthorizationJsonExtractor.instance()

    let responseBody: String = ##"{"device_code": "device_code_v","user_code": "user_code_v",
                                    "verification_uri": "Beijing","expires_in":}"##

    let response: Response = ok(responseBody)
    try {
        let da: DeviceAuthorization = extractor.extract(response)
        println(da.getDeviceCode())
    } catch (e: Exception) {
        //e.printStackTrace()
        return 0
    }
    println(3)
    return 3
}

func testDeviceAuthorizationJsonExtractor_04(): Int32 {
    let extractor: DeviceAuthorizationJsonExtractor = DeviceAuthorizationJsonExtractor.instance()

    let responseBody: String = ##"{"device_code": "device_code_v","user_code": "user_code_v",
                                    "verification_uri": "Beijing","expires_in": abc}"##

    let response: Response = ok(responseBody)
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

    let responseBody: String = ##"{"device_code": "device_code_v","user_code": "user_code_v",
                                    "verification_uri": "Beijing","expires_in": null,"interval": null}"##

    let response: Response = ok(responseBody)
    let da: DeviceAuthorization = extractor.extract(response)
    let str: String = da.toString()

    let result: String = "DeviceAuthorization{'deviceCode'='device_code_v','userCode'='user_code_v'," +
        "'verificationUri'='Beijing','verificationUriComplete'='','expiresInSeconds'='0','intervalSeconds'='5'}"

    println("da.toString() = " + da.toString())

    if (!str.equals(result)) {
        println(5)
        return 5
    }
    return 0
}

func testDeviceAuthorizationJsonExtractor_06(): Int32 {
    let extractor: DeviceAuthorizationJsonExtractor = DeviceAuthorizationJsonExtractor.instance()

    let responseBody: String = ##"{"device_code": "device_code_v","user_code": "user_code_v",
                                    "verification_uri": "Beijing","expires_in": 6,"interval": "8"}"##

    let response: Response = ok(responseBody)
    let da: DeviceAuthorization = extractor.extract(response)
    let str: String = da.toString()

    let result: String = "DeviceAuthorization{'deviceCode'='device_code_v','userCode'='user_code_v'," +
        "'verificationUri'='Beijing','verificationUriComplete'='','expiresInSeconds'='6','intervalSeconds'='8'}"

    println("da.toString() = " + da.toString())

    if (!str.equals(result)) {
        println(6)
        return 6
    }
    return 0
}

func testDeviceAuthorizationJsonExtractor_07(): Int32 {
    let extractor: DeviceAuthorizationJsonExtractor = DeviceAuthorizationJsonExtractor.instance()

    let responseBody: String = ##"{"device_code": "device_code_v","user_code": "user_code_v",
                                    "verification_uri": "Beijing","expires_in": 6,"interval": "abc"}"##

    let response: Response = ok(responseBody)
    let da: DeviceAuthorization = extractor.extract(response)
    let str: String = da.toString()

    let result: String = "DeviceAuthorization{'deviceCode'='device_code_v','userCode'='user_code_v'," +
        "'verificationUri'='Beijing','verificationUriComplete'='','expiresInSeconds'='6','intervalSeconds'='5'}"

    println("da.toString() = " + da.toString())

    if (!str.equals(result)) {
        println(7)
        return 7
    }
    return 0
}

func testDeviceAuthorizationJsonExtractor_08(): Int32 {
    let extractor: DeviceAuthorizationJsonExtractor = DeviceAuthorizationJsonExtractor.instance()

    let responseBody: String = ##"{"device_code": "device_code_v","user_code": "user_code_v",
                                    "verification_uri": "Beijing","expires_in": 6,"interval": "+6"}"##

    let response: Response = ok(responseBody)
    let da: DeviceAuthorization = extractor.extract(response)
    let str: String = da.toString()

    let result: String = "DeviceAuthorization{'deviceCode'='device_code_v','userCode'='user_code_v'," +
        "'verificationUri'='Beijing','verificationUriComplete'='','expiresInSeconds'='6','intervalSeconds'='6'}"

    println("da.toString() = " + da.toString())

    if (!str.equals(result)) {
        println(8)
        return 8
    }
    return 0
}

func testDeviceAuthorizationJsonExtractor_09(): Int32 {
    let extractor: DeviceAuthorizationJsonExtractor = DeviceAuthorizationJsonExtractor.instance()

    let responseBody: String = ##"{"device_code": "device_code_v","user_code": "user_code_v",
                                    "verification_uri": "Beijing","expires_in": 6,"interval": "-9"}"##

    let response: Response = ok(responseBody)
    let da: DeviceAuthorization = extractor.extract(response)
    let str: String = da.toString()

    let result: String = "DeviceAuthorization{'deviceCode'='device_code_v','userCode'='user_code_v'," +
        "'verificationUri'='Beijing','verificationUriComplete'='','expiresInSeconds'='6','intervalSeconds'='-9'}"

    println("da.toString() = " + da.toString())

    if (!str.equals(result)) {
        println(9)
        return 9
    }
    return 0
}

func testDeviceAuthorizationJsonExtractor_10(): Int32 {
    let extractor: DeviceAuthorizationJsonExtractor = DeviceAuthorizationJsonExtractor.instance()

    let responseBody: String = ##"{"device_code": "device_code_v","user_code": "user_code_v",
                                    "verification_uri": "Beijing","expires_in": 6,"interval": -8}"##

    let response: Response = ok(responseBody)
    let da: DeviceAuthorization = extractor.extract(response)
    let str: String = da.toString()

    let result: String = "DeviceAuthorization{'deviceCode'='device_code_v','userCode'='user_code_v'," +
        "'verificationUri'='Beijing','verificationUriComplete'='','expiresInSeconds'='6','intervalSeconds'='-8'}"

    println("da.toString() = " + da.toString())

    if (!str.equals(result)) {
        println(10)
        return 10
    }
    return 0
}

func testDeviceAuthorizationJsonExtractor_11(): Int32 {
    let extractor: DeviceAuthorizationJsonExtractor = DeviceAuthorizationJsonExtractor.instance()

    let responseBody: String = ##"{"device_code": "device_code_v","user_code": "user_code_v",
                                    "verification_uri": "Beijing","expires_in": 6,"interval": +8}"##

    let response: Response = ok(responseBody)
    try {
        let da: DeviceAuthorization = extractor.extract(response)
        println(da.getDeviceCode())
    } catch (e: Exception) {
        //e.printStackTrace()
        return 0
    }
    println(11)
    return 11
}

func testDeviceAuthorizationJsonExtractor_12(): Int32 {
    let extractor: DeviceAuthorizationJsonExtractor = DeviceAuthorizationJsonExtractor.instance()

    let responseBody: String = ##"{"device_code": "device_code_v","user_code": "user_code_v",
                                    "verification_uri": "Beijing","expires_in": "abc","interval": "0xFF"}"##

    let response: Response = ok(responseBody)
    let da: DeviceAuthorization = extractor.extract(response)
    let str: String = da.toString()

    let result: String = "DeviceAuthorization{'deviceCode'='device_code_v','userCode'='user_code_v'," +
        "'verificationUri'='Beijing','verificationUriComplete'='','expiresInSeconds'='0','intervalSeconds'='5'}"

    println("da.toString() = " + da.toString())

    if (!str.equals(result)) {
        println(12)
        return 12
    }
    return 0
}



