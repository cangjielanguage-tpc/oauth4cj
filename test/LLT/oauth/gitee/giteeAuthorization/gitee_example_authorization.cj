
//from std import console.*
from std import random.*
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

    //替换成自己的一次性授权码
    let CODE: String = "your code"

    //替换成自己需要的权限范围
    let SCOP: String = "user_info emails"

    let NETWORK_NAME: String = "Gitee"
    let PROTECTED_RESOURCE_URL: String = "https://gitee.com/api/v5/emails"

    let m: Random = Random()
    m.setSeed(3)
    let c: UInt32 = m.nextUInt32()

    let secretState: String = "secret" + c.toString()
    let service: OAuth20Service = ServiceBuilderOAuth20(clientId).
            setApiSecret(clientSecret).
            setDefaultScope(SCOP).
            setCallback("http://www.example.com/oauth_callback/").
            build(GiteeApi.instance())


    //=== GitHub的OAuth工作流 ===

    //获取授权URL
    //https://developers.google.com/identity/protocols/OAuth2WebServer#preparing-to-start-the-oauth-20-flow
    let additionalParams: HashMap<String, String> = HashMap<String, String>()
    additionalParams.put("access_type", "offline")//pass access_type=offline 以获取刷新令牌
    additionalParams.put("prompt", "consent")//强制reget刷新令牌（如果不是第一次询问用户）
    let authorizationUrl: String = AuthorizationUrlBuilder(service).
            setState(secretState).
            setAdditionalParams(additionalParams).
            build()
    println("授权URL: " + authorizationUrl)

    //替换成自己的一次性授权码
    let code: String = CODE

    //获取访问令牌！
    var accessToken: OAuth2AccessToken = service.getAccessToken(code)
    println("(访问令牌-原始响应如下：" + accessToken.getRawResponse() + "')")

    //刷新访问令牌...
    accessToken = service.refreshAccessToken(accessToken.getRefreshToken())
    println("(刷新令牌-原始响应如下：" + accessToken.getRawResponse() + "')")


    //现在让我们去请求一个受保护的资源！
    let requestUrl: String = PROTECTED_RESOURCE_URL
    let request: OAuth4cjRequest = OAuth4cjRequest(Verb.GET, requestUrl)
    service.signRequest(accessToken, request)

    let response: Response = service.execute(request)
    println(response.getCode())
    println(response.getBody())
}
