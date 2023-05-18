/**
 * Copyright (c) Cangjie Library Team 2023-2023. All rights resvered.
 */

package oauth2.bearersignature

/**
 * URI Query Parameter, RFC 6750 2.3.
 */
public class BearerSignatureURIQueryParameter {
    private static let INSTANCE = BearerSignatureURIQueryParameter()

    init() {}
    
    /**
     * Get BearerSignatureURIQueryParameter instance
     * 
     * @return BearerSignatureURIQueryParameter instance
     * @since 0.38.2
     */
    public static func instance(): BearerSignatureURIQueryParameter {
        return INSTANCE
    }
}

extend BearerSignatureURIQueryParameter <: BearerSignature {
    /**
     * Add accessToken to request
     *
     * @param accessToken access token
     * @param request oauth request
     *
     * @since 0.38.2
     */
    public func signRequest(accessToken: String, request: OAuth4cjRequest): Unit {
        request.addQuerystringParameter(OAuthConstants.ACCESS_TOKEN, accessToken)
    }
}

