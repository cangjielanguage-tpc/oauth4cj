
from oauth4cj import oauth4cj.*

public class GithubApi <: DefaultApi20 {

    protected init() { }

    public static func instance(): GithubApi {
        return GithubApi()
    }

    //返回请求类型
    public func getAccessTokenVerb(): Verb {
        return Verb.POST
    }

    //返回接收访问令牌请求的 URL
    public func getAccessTokenEndpoint(): String {
        return "https://github.com/login/oauth/access_token"
    }

    //返回授权链接
    protected func getAuthorizationBaseUrl(): String {
        return "https://github.com/login/oauth/authorize"
    }

    //指定访问令牌提取器并返回: 用于 OAuth 2.0 的 TokenExtractor 的自定义实现。
    //适合解析的数据类型：access_token=${access_token}&scope=${scope}&token_type=${token_type}
    public func getAccessTokenExtractor(): TokenExtractor<OAuth2AccessToken> {
        return OAuth2AccessTokenExtractor.instance()
    }

    //客户端身份验证: 在请求主体中写入 "client_id" 和 "client_secret" 及其对应的键值对信息
    public func getClientAuthentication(): ClientAuthentication {
        return RequestBodyAuthenticationScheme.instance()
    }

    //返回指定的, RFC 8628 OAuth 2.0 设备授权授予链接
    public func getDeviceAuthorizationEndpoint(): String {
        return "https://github.com/login/device/code"
    }

}
