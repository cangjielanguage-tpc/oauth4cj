// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj

import std.collection.*
import net.http.*
public import oauth4cj.*

@Test
public class TestRFC6749{
    @Skip
    @TestCase
    func testRFC674902(): Unit {
        let clientId: String = "your client id"
        let clientSecret: String = "your client secret"
        let SCOP: String = "repo,user"
        let PROTECTED_RESOURCE_URL: String = "https://api.github.com/user"
        let m: Random = Random()
        m.seed = 3
        let service: OAuth20Service = ServiceBuilderOAuth20(clientId).
                setApiSecret(clientSecret).
                setDefaultScope(SCOP).
                setCallback("http://www.example.com/oauth_callback/").
                build(GithubApi.instance())
        //9e39959cf411bdacc5c3，网页获取的授权码
        let redirectLocation: String = "http://www.example.com/oauth_callback/?code=9e39959cf411bdacc5c3"
        let o2a: OAuth2Authorization = service.extractAuthorization(redirectLocation)
        let code: String = o2a.getCode()
        let accessToken: OAuth2AccessToken = service.getAccessToken(code)
        let requestUrl: String = PROTECTED_RESOURCE_URL
        let request: OAuth4cjRequest = OAuth4cjRequest(Verb.GET, requestUrl)
        service.signRequest(accessToken, request)
        let response = service.execute(request)
        @Assert(response.getCode(),Int32(200))
   }
}