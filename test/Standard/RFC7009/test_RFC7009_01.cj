// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj

from std import random.*
from std import collection.*
from encoding import json.*
from oauth4cj import commons.*
from oauth4cj import oauth.*
from oauth4cj import model.*
from oauth4cj import httpclient.*
from oauth4cj import builder.*
from oauth4cj import extractors.*
from oauth4cj import exceptions.*

@Test
public class TestRFC7009{
    @Skip
    @TestCase
    func testRFC700901(): Unit {
        let clientId: String = "your client id"
        let clientSecret: String = "your client secret"
        let PROTECTED_RESOURCE_URL_0: String = "https://api.weibo.com/2/users/show.json"
        let PROTECTED_RESOURCE_URL: String = "https://api.weibo.com/2/account/get_uid.json"
        let service: OAuth20Service = ServiceBuilderOAuth20(clientId).
                setApiSecret(clientSecret).
                //设置回调url{redirect_uri}，用于后面获取授权码code
                setCallback("http://www.example.com/response").
                build(WeiboApi.instance())
        let authorizationUrl: String = AuthorizationUrlBuilder(service).build()
        println("授权URL: " + authorizationUrl)
        let code: String = "ffa4482988ac884f7ce9a22436c8dc60ca800cc0eeef320fbe18dfc689d1442a"
        let accessToken: OAuth2AccessToken = service.getAccessToken(code)
        let rawResponse: String = accessToken.getRawResponse()
        let jsonResponse = JsonValue.fromStr(rawResponse).asObject()
        let uid: String = jsonResponse.get("uid").getOrThrow().asString().getValue()
        let requestUrl: String = PROTECTED_RESOURCE_URL_0
        let request: OAuth4cjRequest = OAuth4cjRequest(Verb.GET, requestUrl)
        request.addQuerystringParameter("uid", uid)
        service.signRequest(accessToken, request)
        service.execute(request)
        let res: Future<Unit> = service.revokeTokenAsync(accessToken.getAccessToken())
        res.get()
        let requestUrl2: String = PROTECTED_RESOURCE_URL
        let request2: OAuth4cjRequest = OAuth4cjRequest(Verb.GET, requestUrl2)
        service.signRequest(accessToken, request2)
        let response02 = service.execute(request2)
        @Assert(response02.getCode(),Int32(4.3))
   }
}
