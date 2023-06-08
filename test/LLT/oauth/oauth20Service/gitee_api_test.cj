
from oauth4cj import oauth2.clientauthentication.*
from oauth4cj import model.*

public class GiteeApiTest <: DefaultApi20 {

    protected init() { }

    public static func instance(): GiteeApiTest {
        return GiteeApiTest()
    }

    public func getAccessTokenVerb(): Verb {
        return Verb.POST
    }

    public func getAccessTokenEndpoint(): String {
        return "http://127.0.0.1/token"
    }

    protected func getAuthorizationBaseUrl(): String {
        return "http://127.0.0.1/authorize"
    }

    public func getAccessTokenExtractor(): TokenExtractor<OAuth2AccessToken> {
        return OAuth2AccessTokenJsonExtractor.instance()
    }

    public func getClientAuthentication(): ClientAuthentication {
        return RequestBodyAuthenticationScheme.instance()
    }
}
