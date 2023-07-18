// DEPENDENCE: ./gitee_api_test.cj
// EXEC: cjc %import-path %L %l %f ./gitee_api_test.cj
// EXEC: ./main

from std import collection.*
from std import io.*

from oauth4cj import httpclient.multipart.*
from oauth4cj import httpclient.*
from oauth4cj import oauth.*
from oauth4cj import builder.*
from oauth4cj import pkce.*
from oauth4cj import revoke.*
from oauth4cj import extractors.*
from oauth4cj import exceptions.*
from oauth4cj import util.*

from httpclient4cj import httpclient4cj.*

//将这些替换为您的客户端id和机密
let clientId: String = "your client id"
let clientSecret: String = "your client secret"

//替换成自己需要的权限范围
let SCOP: String = "user_info emails"

main() {

    let debugStream: OutputStream = ByteArrayStream()

    let service: OAuth20Service = ServiceBuilderOAuth20(clientId).
                                  setApiSecret(clientSecret).
                                  setDefaultScope(SCOP).
                                  setCallback("http://www.example.com/oauth_callback/").
                                  setDebugStream(Some(debugStream)).
                                  build(GiteeApiTest.instance())

    //let test_01 = testOAuth20Service_15(service)
    //if (test_01 != 0){
    //    println(test_01)
    //    return test_01
    //}


    var test_01 = testOAuth20Service_01(service)
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testOAuth20Service_02(service)
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testOAuth20Service_03(service)
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testOAuth20Service_04(service)
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testOAuth20Service_05(service)
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    test_01 = testOAuth20Service_06(service)
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testOAuth20Service_07(service)
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testOAuth20Service_08(service)
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testOAuth20Service_09(service)
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testOAuth20Service_10(service)
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    test_01 = testOAuth20Service_11(service)
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testOAuth20Service_12(service)
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testOAuth20Service_13(service)
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testOAuth20Service_14(service)
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testOAuth20Service_15(service)
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    test_01 = testOAuth20Service_16(service)
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testOAuth20Service_17(service)
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testOAuth20Service_18(service)
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testOAuth20Service_19(service)
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testOAuth20Service_20(service)
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    test_01 = testOAuth20Service_21(service)
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testOAuth20Service_22(service)
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testOAuth20Service_23(service)
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testOAuth20Service_24(service)
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testOAuth20Service_25(service)
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    test_01 = testOAuth20Service_26(service)
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testOAuth20Service_27(service)
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testOAuth20Service_28(service)
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testOAuth20Service_29(service)
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testOAuth20Service_30(service)
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    test_01 = testOAuth20Service_31(service)
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testOAuth20Service_32(service)
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testOAuth20Service_33(service)
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    return test_01
}

func testOAuth20Service_01(service: OAuth20Service): Int32 {
    let version: String = service.getVersion()
    if (!version.equals("2.0")) {
        println(1)
        return 1
    }

    let additionalParams: HashMap<String, String> = HashMap<String, String>()
    additionalParams.put("access_type", "offline")
    additionalParams.put("prompt", "consent")//强制reget刷新令牌（如果不是第一次询问用户）

    let pkce: PKCE = PKCEService().generatePKCE()

    let url: String = service.getAuthorizationUrl()
    let url2: String = service.getAuthorizationUrl("ceshi")
    let url3: String = service.getAuthorizationUrl(additionalParams)
    let url4: String = service.getAuthorizationUrl(pkce)
    if (url.isEmpty() || url2.isEmpty() || url3.isEmpty() || url4.isEmpty()) {
        println(-2)
        return -2
    }

    let url5: String = service.getApi().getAccessTokenEndpoint()
    if (!url5.equals("http://127.0.0.1/token")) {
        println(-3)
        return -3
    }

    let redirectLocation: String = ##"https://gitee.com/oauth/authorize?code=code&state=secret184497"##
    let o2a: OAuth2Authorization = service.extractAuthorization(redirectLocation)
    let code: String = o2a.getCode()
    let state: String = o2a.getState()
    if (!code.equals("code") || !state.equals("secret184497")) {
        println(-4)
        return -4
    }

    let responseType: String = service.getResponseType()
    let defaultScope: String = service.getDefaultScope() ?? ""
    if (!responseType.equals("code") || !defaultScope.equals(SCOP)) {
        println(-5)
        return -5
    }

    return 0
}

func testOAuth20Service_02(service: OAuth20Service): Int32 {
    try {
        let res: Future<OAuth2AccessToken> = service.getAccessTokenAsync("test")
        res.get(1000 * 1000 * 1000)
    } catch (ex: Exception) {
        return 0
    }
    return 2
}

func testOAuth20Service_03(service: OAuth20Service): Int32 {
    try {
        let res: Future<OAuth2AccessToken> = service.getAccessTokenAsync(AccessTokenRequestParams.create("code"))
        res.get(1000 * 1000 * 1000)
    } catch (ex: Exception) {
        return 0
    }
    return 3
}

func testOAuth20Service_04(service: OAuth20Service): Int32 {
    try {
        let res: Future<OAuth2AccessToken> = service.getAccessToken(AccessTokenRequestParams.create("code"), None)
        res.get(1000 * 1000 * 1000)
    } catch (ex: Exception) {
        return 0
    }
    return 4
}

func testOAuth20Service_05(service: OAuth20Service): Int32 {
    try {
        let res: Future<OAuth2AccessToken> = service.getAccessToken("code", None)
        res.get(1000 * 1000 * 1000)
    } catch (ex: Exception) {
        return 0
    }
    return 5
}

func testOAuth20Service_06(service: OAuth20Service): Int32 {
    try {
        let res: Future<OAuth2AccessToken> = service.refreshAccessTokenAsync("code")
        res.get(1000 * 1000 * 1000)
    } catch (ex: Exception) {
        return 0
    }
    return 6
}

func testOAuth20Service_07(service: OAuth20Service): Int32 {
    try {
        let res: Future<OAuth2AccessToken> = service.refreshAccessTokenAsync("code", "scope")
        res.get(1000 * 1000 * 1000)
    } catch (ex: Exception) {
        return 0
    }
    return 7
}

func testOAuth20Service_08(service: OAuth20Service): Int32 {
    try {
        let res: OAuth2AccessToken = service.refreshAccessToken("code")
        println(res.getAccessToken())
    } catch (ex: Exception) {
        return 0
    }
    return 8
}

func testOAuth20Service_09(service: OAuth20Service): Int32 {
    try {
        let res: OAuth2AccessToken = service.refreshAccessToken("code", "scope")
        println(res.getAccessToken())
    } catch (ex: Exception) {
        return 0
    }
    return 9
}

func testOAuth20Service_10(service: OAuth20Service): Int32 {
    try {
        let res: Future<OAuth2AccessToken> = service.refreshAccessToken("code", None)
        res.get(1000 * 1000 * 1000)
    } catch (ex: Exception) {
        return 0
    }
    return 10
}

func testOAuth20Service_11(service: OAuth20Service): Int32 {
    try {
        let res: Future<OAuth2AccessToken> = service.refreshAccessToken("code", "scope", None)
        res.get(1000 * 1000 * 1000)
    } catch (ex: Exception) {
        return 0
    }
    return 11
}

func testOAuth20Service_12(service: OAuth20Service): Int32 {
    try {
        let res: OAuth2AccessToken = service.getAccessTokenPasswordGrant("username", "password", "scope")
        println(res.getAccessToken())
    } catch (ex: Exception) {
        return 0
    }
    return 12
}

func testOAuth20Service_13(service: OAuth20Service): Int32 {
    try {
        let res: Future<OAuth2AccessToken> = service.getAccessTokenPasswordGrantAsync("username", "password", "scope")
        res.get(1000 * 1000 * 1000)
    } catch (ex: Exception) {
        return 0
    }
    return 13
}

func testOAuth20Service_14(service: OAuth20Service): Int32 {
    try {
        let res: Future<OAuth2AccessToken> =
                    service.getAccessTokenPasswordGrantAsync("username", "password", "scope", None)
        res.get(1000 * 1000 * 1000)
    } catch (ex: Exception) {
        return 0
    }
    return 14
}

func testOAuth20Service_15(service: OAuth20Service): Int32 {
    try {
        let res: Future<OAuth2AccessToken> = service.getAccessTokenClientCredentialsGrantAsync()
        res.get(1000 * 1000 * 1000)
    } catch (e: Exception) {
        return 0
    }
    return 15
}

func testOAuth20Service_16(service: OAuth20Service): Int32 {
    try {
        let res: Future<OAuth2AccessToken> = service.getAccessTokenClientCredentialsGrantAsync("scope")
        res.get(1000 * 1000 * 1000)
    } catch (ex: Exception) {
        return 0
    }
    return 16
}

func testOAuth20Service_17(service: OAuth20Service): Int32 {
    try {
        let res: OAuth2AccessToken = service.getAccessTokenClientCredentialsGrant("scope")
        println(res.getAccessToken())
    } catch (ex: Exception) {
        return 0
    }
    return 17
}

func testOAuth20Service_18(service: OAuth20Service): Int32 {
    try {
        let res: Future<OAuth2AccessToken> = service.getAccessTokenClientCredentialsGrant(None)
        res.get(1000 * 1000 * 1000)
    } catch (ex: Exception) {
        return 0
    }
    return 18
}

func testOAuth20Service_19(service: OAuth20Service): Int32 {
    try {
        let res: Future<OAuth2AccessToken> = service.getAccessTokenClientCredentialsGrant("scope", None)
        res.get(1000 * 1000 * 1000)
    } catch (ex: Exception) {
        return 0
    }
    return 19
}

func testOAuth20Service_20(service: OAuth20Service): Int32 {
    try {
        let res: Future<Unit> = service.revokeTokenAsync("scope")
        res.get(1000 * 1000 * 1000)
    } catch (ex: Exception) {
        return 0
    }
    return 20
}

func testOAuth20Service_21(service: OAuth20Service): Int32 {
    try {
        let res: Future<Unit> = service.revokeTokenAsync("scope", Some(TokenTypeHint.ACCESS_TOKEN_HINT))
        res.get(1000 * 1000 * 1000)
    } catch (ex: Exception) {
        return 0
    }
    return 21
}

func testOAuth20Service_22(service: OAuth20Service): Int32 {
    try {
        let res: Unit = service.revokeToken("scope")
        println(res is Unit)
    } catch (ex: Exception) {
        return 0
    }
    return 22
}

func testOAuth20Service_23(service: OAuth20Service): Int32 {
    try {
        let res: Unit = service.revokeToken("scope", Some(TokenTypeHint.ACCESS_TOKEN_HINT))
        println(res is Unit)
    } catch (ex: Exception) {
        return 0
    }
    return 23
}

func testOAuth20Service_24(service: OAuth20Service): Int32 {
    try {
        let res: Future<Unit> = service.revokeTokenAsync("scope", None)
        res.get(1000 * 1000 * 1000)
    } catch (ex: Exception) {
        return 0
    }
    return 24
}

func testOAuth20Service_25(service: OAuth20Service): Int32 {
    try {
        let res: Future<DeviceAuthorization> = service.getDeviceAuthorizationCodes(None)
        res.get(1000 * 1000 * 1000)
    } catch (ex: Exception) {
        return 0
    }
    return 25
}

func testOAuth20Service_26(service: OAuth20Service): Int32 {
    try {
        let res: Future<DeviceAuthorization> = service.getDeviceAuthorizationCodes(Some("scope"), None)
        res.get(1000 * 1000 * 1000)
    } catch (ex: Exception) {
        return 0
    }
    return 26
}

func testOAuth20Service_27(service: OAuth20Service): Int32 {
    try {
        let res: DeviceAuthorization = service.getDeviceAuthorizationCodes()
        println(res.getDeviceCode())
    } catch (ex: Exception) {
        return 0
    }
    return 27
}

func testOAuth20Service_28(service: OAuth20Service): Int32 {
    try {
        let res: DeviceAuthorization = service.getDeviceAuthorizationCodes(Some("scope"))
        println(res.getDeviceCode())
    } catch (ex: Exception) {
        return 0
    }
    return 28
}

func testOAuth20Service_29(service: OAuth20Service): Int32 {
    try {
        let res: Future<DeviceAuthorization> = service.getDeviceAuthorizationCodesAsync()
        res.get(1000 * 1000 * 1000)
    } catch (ex: Exception) {
        return 0
    }
    return 29
}

func testOAuth20Service_30(service: OAuth20Service): Int32 {
    try {
        let res: Future<DeviceAuthorization> = service.getDeviceAuthorizationCodesAsync(Some("scope"))
        res.get(1000 * 1000 * 1000)
    } catch (ex: Exception) {
        return 0
    }
    return 30
}

func testOAuth20Service_31(service: OAuth20Service): Int32 {
    try {
        let da: DeviceAuthorization = DeviceAuthorization("deviceCode", "userCode", "verificationUri", 0)
        let res: OAuth2AccessToken = service.getAccessTokenDeviceAuthorizationGrant(da)
        println(res.getAccessToken())
    } catch (ex: Exception) {
        return 0
    }
    return 31
}

func testOAuth20Service_32(service: OAuth20Service): Int32 {
    try {
        let da: DeviceAuthorization = DeviceAuthorization("deviceCode", "userCode", "verificationUri", 0)
        let res: Future<OAuth2AccessToken> = service.getAccessTokenDeviceAuthorizationGrant(da, None)
        res.get(1000 * 1000 * 1000)
    } catch (ex: Exception) {
        return 0
    }
    return 32
}

func testOAuth20Service_33(service: OAuth20Service): Int32 {
    try {
        let da: DeviceAuthorization = DeviceAuthorization("deviceCode", "userCode", "verificationUri", 0)
        let res: Future<OAuth2AccessToken> = service.getAccessTokenDeviceAuthorizationGrantAsync(da)
        res.get(1000 * 1000 * 1000)
    } catch (ex: Exception) {
        return 0
    }

    return 33
}
