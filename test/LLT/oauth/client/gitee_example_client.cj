
from std import collection.*

from oauth4cj import utils.*
from oauth4cj import oauth.*
from oauth4cj import model.*
from oauth4cj import httpclient.*
from oauth4cj import builder.*
from oauth4cj import extractors.*
from oauth4cj import exceptions.*

main() {
    //将这些替换为您的客户端id和机密
    let clientId: String = "your client id"
    let clientSecret: String = "your client secret"

    //替换成自己需要的权限范围
    let SCOP: String = "user_info emails"

    let NETWORK_NAME: String = "Gitee"
    let PROTECTED_RESOURCE_URL: String = "https://gitee.com/api/v5/emails"

    let service: OAuth20Service = ServiceBuilderOAuth20(clientId).
            setApiSecret(clientSecret).
            setDefaultScope(SCOP).
            setCallback("http://www.example.com/oauth_callback/").
            build(GiteeApi.instance())

    //=== GitHub的OAuth工作流 ===

    //调用客户端模式，获取访问令牌！
    let accessToken: OAuth2AccessToken = service.getAccessTokenClientCredentialsGrant()
    println("(原始响应如下：" + accessToken.getRawResponse() + "')")

    //现在让我们去请求一个受保护的资源！
    let requestUrl: String = PROTECTED_RESOURCE_URL
    let request: OAuth4cjRequest = OAuth4cjRequest(Verb.GET, requestUrl)
    service.signRequest(accessToken, request)

    let response: Response = service.execute(request)
    println(response.getCode())
    println(response.getBody())
}
