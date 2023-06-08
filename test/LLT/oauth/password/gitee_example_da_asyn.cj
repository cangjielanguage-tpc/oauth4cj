
from std import collection.*

from oauth4cj import utils.*
from oauth4cj import oauth.*
from oauth4cj import model.*
from oauth4cj import httpclient.*
from oauth4cj import builder.*
from oauth4cj import extractors.*
from oauth4cj import exceptions.*

main() {

    var test_01 = testDeviceAuthorization_01()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    return test_01
}

public func testDeviceAuthorization_01(): Int32 {
    let SCOP: String = "user_info emails"

    let NETWORK_NAME: String = "Gitee"
    let PROTECTED_RESOURCE_URL: String = "https://gitee.com/api/v5/emails"

    //将这些替换为您的客户端id和机密
    let clientId: String = "your client id"
    let clientSecret: String = "your client secret"

    //ServiceBuilder(clientId).
    let service: OAuth20Service = ServiceBuilderOAuth20(clientId).
            setApiSecret(clientSecret).
            setDefaultScope(SCOP).
            setCallback("http://www.example.com/oauth_callback/").
            build(GiteeApi.instance())

    //=== GitHub的OAuth工作流 ===

    //获取AccessToken设备授权授予流方法
    let res: Future<DeviceAuthorization> = service.getDeviceAuthorizationCodesAsync()
    let da: DeviceAuthorization = res.getResult()

    spawn {
        try {
            //let accessToken: OAuth2AccessToken = service.getAccessTokenDeviceAuthorizationGrant(da)
            let accessToken: OAuth2AccessToken = service.pollAccessTokenDeviceAuthorizationGrant(da)
            println("(原始响应如下：" + accessToken.getRawResponse() + "')")
        } catch (e: OAuth4cjException) {
            e.printStackTrace()
            //return 0
        }
    }
    sleep(2 * 1000 * 1000 * 1000)

    return 0
}
