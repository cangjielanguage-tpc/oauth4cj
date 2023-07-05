
from std import collection.*

from oauth4cj import commons.*
from oauth4cj import oauth.*
from oauth4cj import model.*
from oauth4cj import httpclient.*
from oauth4cj import builder.*
from oauth4cj import extractors.*
from oauth4cj import exceptions.*

main() {
    //将这些替换为在【授权服务器-华为】中生成的 client_id 和 client_secret
    let clientId: String = "your client id"
    let clientSecret: String = "your client secret"

    //替换成自己需要的权限范围
    //此授权范围是在【授权服务器-华为】申请的授权，多个权限用空格隔开
    let SCOP: String = "openid profile email"

    //替换成自己需要请求的，受保护的资源的链接
    //授权成功拿到访问令牌后，准备请求的受保护的资源的链接
    let PROTECTED_RESOURCE_URL: String = "https://account.cloud.huawei.com/rest.php?nsp_svc=GOpen.User.getInfo"

    let service: OAuth20Service = ServiceBuilderOAuth20(clientId).
            setApiSecret(clientSecret).
            setDefaultScope(SCOP).
            //设置回调url{redirect_uri}，用于后面获取授权码code
            setCallback("http://www.example.com/oauth_callback/").
            build(HuaweiApi.instance())

    //=== 华为的OAuth工作流 ===

    //1. 调用客户端模式，获取访问令牌！
    //RFC 6749 OAuth 2.0授权框架，客户端凭据授权授予
    let accessToken: OAuth2AccessToken = service.getAccessTokenClientCredentialsGrant()
    println("(原始响应如下：" + accessToken.getRawResponse() + "')")

    //2. 请求一个受保护的资源！
    let requestUrl: String = PROTECTED_RESOURCE_URL
    let request: OAuth4cjRequest = OAuth4cjRequest(Verb.POST, requestUrl)

    //2.1 请求签名
    service.signRequest(accessToken, request)

    //2.2 调用同步请求执行
    let response: Response = service.execute(request)
    println(response.getCode())
    println(response.getBody())
}
