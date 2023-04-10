// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from oauth4cj import model.*

// DeviceAuthorization OAuth2Authorization

public func testAuthorization_01():Int32 {
    var oauth2Authorization:OAuth2Authorization = OAuth2Authorization()
    if (!"".equals(oauth2Authorization.getCode())) {
        return -1
    } 
    if (!"".equals(oauth2Authorization.getState())) {
        return -1
    } 
    oauth2Authorization.setCode("code")
    oauth2Authorization.setState("state")
    if (!"code".equals(oauth2Authorization.getCode())) {
        return -1
    } 
    if (!"state".equals(oauth2Authorization.getState())) {
        return -1
    } 
    return 0
}

// public init("deviceCode", "userCode", "verificationUri", 50) getDeviceCode() getUserCode() getVerificationUri() getExpiresInSeconds()
public func testAuthorization_02():Int32 {
    var deviceAuthorization:DeviceAuthorization = DeviceAuthorization("deviceCode", "userCode", "verificationUri", 50)
    if (!"deviceCode".equals(deviceAuthorization.getDeviceCode())) {
        return -1
    } 
    if (!"userCode".equals(deviceAuthorization.getUserCode())) {
        return -1
    } 
    if (!"verificationUri".equals(deviceAuthorization.getVerificationUri())) {
        return -1
    } 
    if (deviceAuthorization.getExpiresInSeconds() != 50) {
        return -1
    } 
    return 0
}

// getVerificationUriComplete() getIntervalSeconds() setVerificationUriComplete("VerificationUriComplete") setIntervalSeconds(20)
public func testAuthorization_03():Int32 {
    var deviceAuthorization:DeviceAuthorization = DeviceAuthorization("deviceCode", "userCode", "verificationUri", 50)
    if (!"".equals(deviceAuthorization.getVerificationUriComplete())) {
        return -1
    } 
    if (deviceAuthorization.getIntervalSeconds() != 5) {
        return -1
    } 
    deviceAuthorization.setVerificationUriComplete("VerificationUriComplete")
    deviceAuthorization.setIntervalSeconds(20)
    if (!"VerificationUriComplete".equals(deviceAuthorization.getVerificationUriComplete())) {
        return -1
    } 
    if (deviceAuthorization.getIntervalSeconds() != 20) {
        return -1
    } 
    return 0
}

// toString()
public func testAuthorization_04():Int32 {
    var deviceAuthorization:DeviceAuthorization = DeviceAuthorization("deviceCode", "userCode", "verificationUri", 50)
    var str:String = deviceAuthorization.toString()
    if (!"DeviceAuthorization{'deviceCode'='deviceCode','userCode'='userCode','verificationUri'='verificationUri','verificationUriComplete'='','expiresInSeconds'='50','intervalSeconds'='5'}".equals(str)) {
        println(str)
        return -1
    } 
    return 0
}

main() {
    var test_01 = testAuthorization_01()
    var test_02 = testAuthorization_02()
    var test_03 = testAuthorization_03()
    var test_04 = testAuthorization_04()

    var sum = test_01+test_02+test_03+test_04
    println(sum)
    println("test_01=${test_01}, test_02=${test_02}, test_03=${test_03}, test_04=${test_04}")
    return sum
}