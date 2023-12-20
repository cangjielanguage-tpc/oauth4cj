// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj

from std import collection.*
from net import http.*
from oauth4cj import oauth4cj.*

@Test
public class TestRFC6749{
    @Skip
    @TestCase
    func testRFC674903(): Unit {
        let clientId: String = "your client id"
        let clientSecret: String = "your client secret"
        let SCOP: String = "user_info emails"
        let PROTECTED_RESOURCE_URL: String = "https://gitee.com/api/v5/emails"
        let m: Random = Random()
        m.seed = 3
        let service: OAuth20Service = ServiceBuilderOAuth20(clientId).
                setApiSecret(clientSecret).
                setDefaultScope(SCOP).
                setCallback("http://www.example.com/oauth_callback/").
                build(GiteeApi.instance())
          //${your code}为自己的授权码以及${your state}为自己的state
        let redirectLocation: String = "http://www.example.com/oauth_callback/?code=your code&state=your state"
        let o2a: OAuth2Authorization = service.extractAuthorization(redirectLocation)
        let code: String = o2a.getCode()
        var accessToken: OAuth2AccessToken = service.getAccessToken(code)
        accessToken = service.refreshAccessToken(accessToken.getRefreshToken())
        let requestUrl: String = PROTECTED_RESOURCE_URL
        let request: OAuth4cjRequest = OAuth4cjRequest(Verb.GET, requestUrl)
        service.signRequest(accessToken, request)
        let response = service.execute(request)
        @Assert(response.getCode(),Int32(200))
   }
}