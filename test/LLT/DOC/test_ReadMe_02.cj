// EXEC: cjc %import-path %L %l %f

//密码模式授权
from std import collection.*
from oauth4cj import oauth4cj.*

main() {
    var test_01 = testPassword_01()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    return test_01
}

public func testPassword_01(): Int32 {
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
    let redirect_uri=""//设置回调url{redirect_uri}，用于后面获取授权码code
    let service: OAuth20Service = ServiceBuilderOAuth20(clientId).
            setApiSecret(clientSecret).
            setDefaultScope(SCOP).
            setCallback("${redirect_uri}").
            build(GiteeApi.instance())

    //=== Gitee的OAuth工作流 ===

    //1. 调用密码模式，获取访问令牌！
    let accessToken: OAuth2AccessToken = service.getAccessTokenPasswordGrant(USER_NAME, PASSWORD)
    println("(原始响应如下：" + accessToken.getRawResponse() + "')")

    //2. 请求一个受保护的资源！
    let requestUrl: String = PROTECTED_RESOURCE_URL
    let request: OAuth4cjRequest = OAuth4cjRequest(Verb.GET, requestUrl)

    //2.1 请求签名
    service.signRequest(accessToken, request)

    //2.2 调用同步请求执行
    let response: OAuth4cjResponse = service.execute(request)
    println(response.getCode())
    println(response.getBody())

    return 0
}

/*
 * 准备 OAuth 协议 1.0a 版或者 2.0 版的默认实现：
 * 根据实际需求继承 DefaultApi10a 或者 DefaultApi20，实现抽象方法，覆盖不同的提取器或服务。
 */
public class GiteeApi <: DefaultApi20 {

    protected init() { }

    public static func instance(): GiteeApi {
        return GiteeApi()
    }

    //返回请求类型
    public func getAccessTokenVerb(): Verb {
        return Verb.POST
    }

    //返回接收访问令牌请求的 URL
    public func getAccessTokenEndpoint(): String {
        return "https://gitee.com/oauth/token"
    }

    //返回授权链接
    protected func getAuthorizationBaseUrl(): String {
        return "https://gitee.com/oauth/authorize"
    }

    //指定访问令牌提取器并返回: 用于 OAuth 2.0 的 TokenExtractor 的 JSON 实现
    public func getAccessTokenExtractor(): TokenExtractor<OAuth2AccessToken> {
        return OAuth2AccessTokenJsonExtractor.instance()
    }

    //客户端身份验证: 在请求主体中写入 "client_id" 和 "client_secret" 及其对应的键值对信息
    public func getClientAuthentication(): ClientAuthentication {
        return RequestBodyAuthenticationScheme.instance()
    }

    //承载签名URI查询参数: 请求签名时,添加查询参数 "access_token" 及其对应的键值对信息
    public func getBearerSignature(): BearerSignature {
        return BearerSignatureURIQueryParameter.instance()
    }
}