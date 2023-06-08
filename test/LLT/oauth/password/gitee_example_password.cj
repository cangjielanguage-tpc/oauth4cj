
from std import collection.*

from oauth4cj import utils.*
from oauth4cj import oauth.*
from oauth4cj import model.*
from oauth4cj import httpclient.*
from oauth4cj import builder.*
from oauth4cj import extractors.*
from oauth4cj import exceptions.*

main() {

    var test_01 = testPassword_01()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    return test_01
}

public func testPassword_01(): Int32 {
    //将"your_username"和"your_password"替换成实际的账户名和密码
    let USER_NAME: String = "your_username"
    let PASSWORD: String = "your_password"
    let SCOP: String = "user_info emails"

    let NETWORK_NAME: String = "Gitee"
    let PROTECTED_RESOURCE_URL: String = "https://gitee.com/api/v5/emails"

    // Replace these with your client id and secret //将这些替换为您的客户端id和机密
    let clientId: String = "your client id"
    let clientSecret: String = "your client secret"

    //ServiceBuilder(clientId).
    let service: OAuth20Service = ServiceBuilderOAuth20(clientId).
            setApiSecret(clientSecret).
            setDefaultScope(SCOP).
            setCallback("http://www.example.com/oauth_callback/").
            build(GiteeApi.instance())

    //=== GitHub的OAuth工作流 ===

    //调用密码模式，获取访问令牌！
    let accessToken: OAuth2AccessToken = service.getAccessTokenPasswordGrant(USER_NAME, PASSWORD)
    println("(原始响应如下：" + accessToken.getRawResponse() + "')")

    //现在让我们去请求一个受保护的资源！
    let requestUrl: String = PROTECTED_RESOURCE_URL
    let request: OAuth4cjRequest = OAuth4cjRequest(Verb.GET, requestUrl)
    service.signRequest(accessToken, request)

    let response: Response = service.execute(request)
    println(response.getCode())
    println(response.getBody())

    return 0
}
