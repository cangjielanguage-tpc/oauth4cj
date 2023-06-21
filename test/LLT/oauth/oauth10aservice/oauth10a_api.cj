
class OAuth10aApi <: DefaultApi10a {
    private var useTypeQuery: Bool = false
    init(useTypeQuery: Bool) {
        this.useTypeQuery = useTypeQuery
    }

    public func getRequestTokenEndpoint(): String {
        return "http://localhost:8080/requesttoken"
    }

    public func getAccessTokenEndpoint(): String {
        return "http://localhost:8080/asscesstoken"
    }

    protected func getAuthorizationBaseUrl(): String {
        return "http://localhost:8080/authorize"
    }

    public func getSignatureType(): OAuth1SignatureType {
        if (useTypeQuery) {
            return OAuth1SignatureType.QUERY_STRING_SIGNATURE
        } else {
            return OAuth1SignatureType.HEADER_SIGNATURE
        }
    }

    public func isEmptyOAuthTokenParamIsRequired(): Bool {
        return useTypeQuery
    }
}