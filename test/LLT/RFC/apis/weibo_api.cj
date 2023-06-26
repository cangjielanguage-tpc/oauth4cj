
from oauth4cj import oauth2.clientauthentication.*
from oauth4cj import oauth2.bearersignature.*

public class WeiboApi <: DefaultApi20 {

    protected init() { }

    public static func instance(): WeiboApi {
        return WeiboApi()
    }

    //返回请求类型
    public func getAccessTokenVerb(): Verb {
        return Verb.POST
    }

    //返回接收访问令牌请求的 URL
    public func getAccessTokenEndpoint(): String {
        return "https://api.weibo.com/oauth2/access_token"
    }

    //返回授权链接
    protected func getAuthorizationBaseUrl(): String {
        return "https://api.weibo.com/oauth2/authorize"
    }

    //返回指定的, RFC 7009 OAuth 2.0 令牌撤销链接
    public func getRevokeTokenEndpoint(): String {
        return "https://api.weibo.com/oauth2/revokeoauth2"
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
