/**
 * Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights resvered.
 */

package oauth4cj


/**
 * request-body authentication scheme, RFC 6749 2.3.1 
 */
public class RequestBodyAuthenticationScheme {
    private static let INSTANCE = RequestBodyAuthenticationScheme()

    init() {}

    /**
     * Get RequestBodyAuthenticationScheme instance
     * 
     * @return RequestBodyAuthenticationScheme instance
     * @since 0.38.2
     */
    public static func instance(): RequestBodyAuthenticationScheme {
        return INSTANCE
    }
}

extend RequestBodyAuthenticationScheme <: ClientAuthentication {
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
        request.addParameter(OAuthConstants.CLIENT_ID, apiKey)
        request.addParameter(OAuthConstants.CLIENT_SECRET, apiSecret)
    }
}

