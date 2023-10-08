// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj

from std import collection.*
from std import sync.*
from std import time.*
from oauth4cj import oauth4cj.*

@Test
public class TestRFC8628{
    @Skip
    @TestCase
    func testRFC862801(): Unit {
        let clientId: String = "your client id"
        let clientSecret: String = "your client secret"
        let SCOP: String = "openid profile email"
        let PROTECTED_RESOURCE_URL: String = "https://account.cloud.huawei.com/rest.php?nsp_svc=GOpen.User.getInfo"

        let service: OAuth20Service = ServiceBuilderOAuth20(clientId).
                setApiSecret(clientSecret).
                setDefaultScope(SCOP).
                setCallback("http://www.example.com/oauth_callback/").
                build(HuaweiApi.instance())
        let res: Future<DeviceAuthorization> = service.getDeviceAuthorizationCodes(Option<OAuthAsyncRequestCallback>.None)
        var deviceAuthorization: DeviceAuthorization = res.get()
        //2.浏览器打开链接，手动授权
        let deviceAuthorizationUrl: String = getDeviceBaseUrl(deviceAuthorization.getUserCode())
        println("设备授权URL: " + deviceAuthorizationUrl)
        //2.1 等待，保证手动授权完成
        sleep(60 * 1000 * 1000 * 1000 * Duration.nanosecond)
        let accessToken: OAuth2AccessToken = service.getAccessTokenDeviceAuthorizationGrant(deviceAuthorization)
        let requestUrl: String = PROTECTED_RESOURCE_URL
        let request: OAuth4cjRequest = OAuth4cjRequest(Verb.POST, requestUrl)
        service.signRequest(accessToken, request)
        let response = service.execute(request)
        @Assert(response.getCode(),Int32(200))
    }
}
