public import oauth4cj.*

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
