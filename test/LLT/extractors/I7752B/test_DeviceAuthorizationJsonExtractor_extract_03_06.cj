// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from std import collection.*

from oauth4cj import oauth4cj.*

main() {

    var test_01 = testDeviceAuthorizationJsonExtractorExtract0306()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    return test_01
}

/***
    public func extract(response: Response): DeviceAuthorization
    测试场景:response的Code是200-body不包含device_code,user_code,verification_uri,expires_in,interval,verification_uri_complete中一个
    场景：不包含verification_uri_complete,且expires_in,interval不能转化为整数
***/
func testDeviceAuthorizationJsonExtractorExtract0306(): Int64 {
    var deviceAuthorizationJsonExtractor02=DeviceAuthorizationJsonExtractor.instance()
    var body=###"{
"device_code":"device_code",
"user_code":"user_code",
"verification_uri":"verification_uri",
"expires_in":"expires_in",
"interval":"interval"}"###
    var response01=OAuth4cjResponse(Int32(200),"message",HashMap<String,String>(),body)
    var re02=deviceAuthorizationJsonExtractor02.extract(response01)

    if (!re02.getDeviceCode().equals("device_code")) {
        println(1)
        return 1
    }
    if (!re02.getUserCode().equals("user_code")) {
        println(2)
        return 2
    }
    if (!re02.getVerificationUri().equals("verification_uri")) {
        println(3)
        return 3
    }
    if (!re02.getVerificationUriComplete().equals("")) {
        println(4)
        return 4
    }

    if (re02.getExpiresInSeconds() != 0) {
        println(5)
        return 5
    }
    if (re02.getIntervalSeconds() != 5) {
        println(6)
        return 6
    }
    return 0
}
