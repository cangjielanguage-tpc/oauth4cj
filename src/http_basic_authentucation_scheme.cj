package oauth4cj


/**
 * НTTP Basic authentication scheme, RFC 6749 2.3.1
 */
public class HttpBasicAuthenticationScheme {
    private static let INSTANCE = HttpBasicAuthenticationScheme()

    init() {}

    /**
     * Get HttpBasicAuthenticationScheme instance
     * 
     * @return HttpBasicAuthenticationScheme instance
     * @since 0.38.2
     */
    public static func instance(): HttpBasicAuthenticationScheme {
        return INSTANCE
    }
}

extend HttpBasicAuthenticationScheme <: ClientAuthentication {
    /**
     * Add client authentication to request
     *
     * @param request oauth request
     * @param apiKey key
     * @param apiSecret secret
     *
     * @since 0.38.2
     */
    public func addClientAuthentication(request: OAuth4cjRequest, apiKey: String, apiSecret: String): Unit {
        let encodeString: String = Base64Utils.encode("${apiKey}:${apiSecret}".toArray())
        request.addHeader(OAuthConstants.HEADER_AUTHORIZATION, "${OAuthConstants.BASIC} ${encodeString}")
    }
}

