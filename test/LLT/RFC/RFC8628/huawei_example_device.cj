
import std.collection.*
import std.sync.*
import std.time.*

public import oauth4cj.*
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

    //RFC 8628 OAuth 2.0设备授权授予

    //1. 设备码Code请求
    //1.1 同步获取设备授权响应
    //let deviceAuthorization: DeviceAuthorization = service.getDeviceAuthorizationCodes()
    //1.2 异步获取设备授权响应
    let res: Future<DeviceAuthorization> = service.getDeviceAuthorizationCodes(Option<OAuthAsyncRequestCallback>.None)
    var deviceAuthorization: DeviceAuthorization = res.get()

    println("设备授权响应: " + deviceAuthorization.toString())

    //2.浏览器打开链接，手动授权
    let deviceAuthorizationUrl: String = getDeviceBaseUrl(deviceAuthorization.getUserCode())
    println("设备授权URL: " + deviceAuthorizationUrl)

    //2.1 等待，保证手动授权完成
    sleep(60 * 1000 * 1000 * 1000 * Duration.nanosecond)

    //3. 获取访问令牌！
    let accessToken: OAuth2AccessToken = service.getAccessTokenDeviceAuthorizationGrant(deviceAuthorization)
    println("(原始响应如下：" + accessToken.getRawResponse() + "')")

    //4. 请求一个受保护的资源！
    let requestUrl: String = PROTECTED_RESOURCE_URL
    let request: OAuth4cjRequest = OAuth4cjRequest(Verb.POST, requestUrl)

    //4.1 请求签名
    service.signRequest(accessToken, request)

    //4.2 调用同步请求执行
    let response: OAuth4cjResponse = service.execute(request)
    println(response.getCode())
    println(response.getBody())
}
