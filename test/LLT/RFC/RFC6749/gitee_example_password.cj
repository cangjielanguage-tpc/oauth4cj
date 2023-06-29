
from std import collection.*

from oauth4cj import utils.*
from oauth4cj import oauth.*
from oauth4cj import model.*
from oauth4cj import httpclient.*
from oauth4cj import builder.*
from oauth4cj import extractors.*
from oauth4cj import exceptions.*

main() {

    //将"your_username"和"your_password"替换成实际的 gitee 账户名和密码
    let USER_NAME: String = "your_username"
    let PASSWORD: String = "your_password"

    //将这些替换为在【授权服务器-gitee】中生成的 client_id 和 client_secret
    let clientId: String = "your client id"
    let clientSecret: String = "your client secret"

    //替换成自己需要的权限范围
    //此授权范围是在【授权服务器-gitee】成功创建的应用中对应的权限描述，多个权限用空格隔开
    let SCOP: String = "user_info emails"

    let NETWORK_NAME: String = "Gitee"

    //替换成自己需要请求的，受保护的资源的链接
    //授权成功拿到访问令牌后，准备请求的受保护的资源的链接
    let PROTECTED_RESOURCE_URL: String = "https://gitee.com/api/v5/emails"

    //ServiceBuilder(clientId).
    let service: OAuth20Service = ServiceBuilderOAuth20(clientId).
            setApiSecret(clientSecret).
            setDefaultScope(SCOP).
            setCallback("http://www.example.com/oauth_callback/").
            build(GiteeApi.instance())

    //=== Gitee的OAuth工作流 ===

    //1. 调用密码模式，获取访问令牌！
    //RFC 6749 OAuth 2.0授权框架，资源所有者密码凭据授权授予
    let accessToken: OAuth2AccessToken = service.getAccessTokenPasswordGrant(USER_NAME, PASSWORD)
    println("(原始响应如下：" + accessToken.getRawResponse() + "')")

    //2. 请求一个受保护的资源！
    let requestUrl: String = PROTECTED_RESOURCE_URL
    let request: OAuth4cjRequest = OAuth4cjRequest(Verb.GET, requestUrl)

    //2.1 请求签名
    service.signRequest(accessToken, request)

    //2.2 调用同步请求执行
    let response: Response = service.execute(request)
    println(response.getCode())
    println(response.getBody())

}
