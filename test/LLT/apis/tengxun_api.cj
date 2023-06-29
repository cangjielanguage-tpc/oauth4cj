
public class TengxunApi <: DefaultApi20 {

    protected init() { }

    /**
     * Returns the access token extractor.
     *
     * @return access token extractor
     */
    public static func instance(): TengxunApi {
        return TengxunApi()
    }

    /**
     * Returns the verb for the access token endpoint
     * Return request type.
     *
     * @return access token endpoint verb
     */
    public func getAccessTokenVerb(): Verb {
        return Verb.GET
    }

    /**
     * Returns the URL that receives the access token requests.
     * notes: PC website
     *
     * @return access token URL
     */
    public func getAccessTokenEndpoint(): String {
        return "https://graph.qq.com/oauth2.0/token"
    }

    //Return to authorization link. -- PC website
    protected func getAuthorizationBaseUrl(): String {
        return "https://graph.qq.com/oauth2.0/authorize"
    }

    /**
     * Returns ClientAuthentication instance.
     * Client authentication:
     * Write "client_id" and "client_secret" and their corresponding key value pair information in the request body.
     *
     * @return ClientAuthentication ClientAuthentication instance
     */
    public func getClientAuthentication(): ClientAuthentication {
        return RequestBodyAuthenticationScheme.instance()
    }

    /**
     * Returns BearerSignature instance.
     * Bearer signature URI query parameter: When requesting signature,
     *          add the query parameter "access_token" and its corresponding key value pair information.
     *
     * @return BearerSignature BearerSignature instance
     */
    public func getBearerSignature(): BearerSignature {
        return BearerSignatureURIQueryParameter.instance()
    }
}
