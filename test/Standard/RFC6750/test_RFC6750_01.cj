// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj

from std import collection.*
from oauth4cj import commons.*
from oauth4cj import oauth.*
from oauth4cj import model.*
from oauth4cj import httpclient.*
from oauth4cj import builder.*
from oauth4cj import extractors.*
from oauth4cj import exceptions.*

@Test
public class TestRFC6750{
    @Skip
    @TestCase
    func testRFC675001(): Unit {
        let USER_NAME: String = "your_username"
        let PASSWORD: String = "your_password"
        let clientId: String = "your client id"
        let clientSecret: String = "your client secret"
        let SCOP: String = "user_info emails"
        let PROTECTED_RESOURCE_URL: String = "https://gitee.com/api/v5/emails"
        let service: OAuth20Service = ServiceBuilderOAuth20(clientId).
                setApiSecret(clientSecret).
                setDefaultScope(SCOP).
                setCallback("http://www.example.com/oauth_callback/").
                build(GiteeApi.instance())
        let res: Future<OAuth2AccessToken> = service.getAccessTokenPasswordGrantAsync(USER_NAME, PASSWORD)
        let accessToken: OAuth2AccessToken = res.get()
        let requestUrl: String = PROTECTED_RESOURCE_URL
        let request: OAuth4cjRequest = OAuth4cjRequest(Verb.GET, requestUrl)
        service.signRequest(accessToken, request)
   }
}