from oauth4cj import oauth2.clientauthentication.*
from oauth4cj import oauth2.bearersignature.*

public class HuaweiApi <: DefaultApi20 {

    protected init() { }

    public static func instance(): HuaweiApi {
        return HuaweiApi()
    }

    //返回请求类型
    public func getAccessTokenVerb(): Verb {
        return Verb.POST
    }

    //返回接收访问令牌请求的 URL
    public func getAccessTokenEndpoint(): String {
        return "https://oauth-login.cloud.huawei.com/oauth2/v3/token"
    }

    //返回授权链接
    protected func getAuthorizationBaseUrl(): String {
        return "https://oauth-login.cloud.huawei.com/oauth2/v3/authorize"
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

    //返回指定的, RFC 8628 OAuth 2.0 设备授权授予链接
    public func getDeviceAuthorizationEndpoint(): String {
        return getAccessTokenEndpoint()
    }

    //返回指定的, RFC 7009 OAuth 2.0 令牌撤销链接
    public func getRevokeTokenEndpoint(): String {
        return getAccessTokenEndpoint()
    }
}
