// EXEC: cjc %import-path %L %l %f

//简化模式授权
import std.collection.*

public import oauth4cj.*

main() {
    //将这些替换为在【授权服务器-腾讯】中生成的 client_id 和 client_secret
    let clientId: String = "your client id"
    let clientSecret: String = "your client secret"

    //替换成自己需要的权限范围
    //此授权范围是在【授权服务器-腾讯】添加的应用的授权，多个权限请用逗号隔开
    let SCOP: String = "get_user_info"
    let redirect_uri=""//设置回调url{redirect_uri}，用于后面获取access_token
    let service: OAuth20Service = ServiceBuilderOAuth20(clientId).
            setApiSecret(clientSecret).
            setDefaultScope(SCOP).
            setCallback("${redirect_uri}").
            build(TengxunApi.instance())

    //=== 腾讯的OAuth工作流 ===
    let secretState=""
    //调用简化模式，获取访问令牌！
    let authorizationUrl: String = AuthorizationUrlBuilder(service).
            setState(secretState).
            build()
    println("授权URL: " + authorizationUrl)
}


/*
 * 准备 OAuth 协议 1.0a 版或者 2.0 版的默认实现：
 * 根据实际需求继承 DefaultApi10a 或者 DefaultApi20，实现抽象方法，覆盖不同的提取器或服务。
 */
public class TengxunApi <: DefaultApi20 {

    protected init() { }

    public static func instance(): TengxunApi {
        return TengxunApi()
    }

    //返回请求类型
    public func getAccessTokenVerb(): Verb {
        return Verb.GET
    }

    //返回接收访问令牌请求的 URL--PC网站
    public func getAccessTokenEndpoint(): String {
        return "https://graph.qq.com/oauth2.0/token"
    }

    //返回授权链接--PC网站
    protected func getAuthorizationBaseUrl(): String {
        return "https://graph.qq.com/oauth2.0/authorize"
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