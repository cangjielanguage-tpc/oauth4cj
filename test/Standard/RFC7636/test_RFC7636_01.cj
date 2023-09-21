// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj

from std import collection.*
from std import sync.*
from std import time.*
from oauth4cj import oauth4cj.*

@Test
public class TestRFC7636{
    @Skip
    @TestCase
    func testRFC763601(): Unit {
        let clientId: String = "your client id"
        let clientSecret: String = "your client secret"
        let SCOP: String = "openid profile"
        let PROTECTED_RESOURCE_URL: String = "https://account.cloud.huawei.com/rest.php?nsp_svc=GOpen.User.getInfo"

        let m: Random = Random()
        m.seed = 3
        let service: OAuth20Service = ServiceBuilderOAuth20(clientId).
                setApiSecret(clientSecret).
                setDefaultScope(SCOP).
                setCallback("http://www.example.com/oauth_callback/").
                build(HuaweiApi.instance())
        let strPkce: String = "ceshi20230612"
        let byte: Array<UInt8> = strPkce.toUtf8Array()
        let pkce: PKCE = PKCEService.defaultInstance().generatePKCE(byte)
        let codeVerifier: String = pkce.getCodeVerifier()
        println("codeVerifier = " + codeVerifier)
        let code: String = "ffa4482988ac884f7ce9a22436c8dc60ca800cc0eeef320fbe18dfc689d1442a"
        let params: AccessTokenRequestParams = AccessTokenRequestParams(code)
        params.setPKCECodeVerifier(codeVerifier)
        let accessToken: OAuth2AccessToken = service.getAccessToken(params)
        let requestUrl: String = PROTECTED_RESOURCE_URL
        let request: OAuth4cjRequest = OAuth4cjRequest(Verb.POST, requestUrl)
        service.signRequest(accessToken, request)
        let response = service.execute(request)
        @Assert(response.getCode(),Int32(200))
    }
}