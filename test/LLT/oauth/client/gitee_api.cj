
public class GiteeApi <: DefaultApi20 {

    protected init() { }

    public static func instance(): GiteeApi {
        return GiteeApi()
    }

    public func getAccessTokenVerb(): Verb {
        return Verb.POST
    }

    public func getAccessTokenEndpoint(): String {
        return "https://gitee.com/oauth/token"
    }

    protected func getAuthorizationBaseUrl(): String {
        return "https://gitee.com/oauth/authorize"
    }

    public func getAccessTokenExtractor(): TokenExtractor<OAuth2AccessToken> {
        return OAuth2AccessTokenJsonExtractor.instance()
    }
}
