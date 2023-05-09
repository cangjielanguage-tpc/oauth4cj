/**
 * Copyright (c) Cangjie Library Team 2023-2023. All rights resvered.
 */

package oauth2.bearersignature

import model.OAuthConstants

/**
 * Authorization Request Header Field, RFC 6750 2.1.
 */
public class BearerSignatureAuthorizationRequestHeaderField {
    private static let INSTANCE = BearerSignatureAuthorizationRequestHeaderField()

    init() {}

    /**
     * Get BearerSignatureAuthorizationRequestHeaderField instance
     * 
     * @return BearerSignatureAuthorizationRequestHeaderField instance
     * @since 0.38.2
     */
    public static func instance(): BearerSignatureAuthorizationRequestHeaderField {
        return INSTANCE
    }
}

extend BearerSignatureAuthorizationRequestHeaderField <: BearerSignature {
    /**
     * Add accessToken to request
     *
     * @param accessToken access token
     * @param request oauth request
     *
     * @since 0.38.2
     */
    public func signRequest(accessToken: String, request: OAuth4cjRequest): Unit {
        request.addHeader(OAuthConstants.HEADER, "Bearer ${accessToken}")
    }
}

