/**
 * Copyright (c) Cangjie Library Team 2023-2023. All rights reserved.
 */
package oauth4cj

/**
 * OAuth2 Access Token Error Response 
 */
public class OAuth2AccessTokenErrorResponse <: OAuthResponseException {

    private let error: Option<OAuth2Error>
    private let errorDescription: String
    private let errorUrl: URL

    /**
     * Create a OAuth2AccessTokenErrorResponse instance
     *
     * @param error Option<OAuth2Error> instance
     * @param errorDescription  error descriuption
     * @param errorUrl error URL instance
     * @param rawResponse response information
     * @since 0.38.2
     */
    public init(error: Option<OAuth2Error>, errorDescription: String, errorUrl: URL, rawResponse: OAuth4cjResponse) {
        super(rawResponse)
        this.error = error
        this.errorDescription = errorDescription
        this.errorUrl = errorUrl
    }

    /**
     * Get the Option<OAuth2Error>
     *
     * @return Option<OAuth2Error> OAuth2Error instance
     * @since 0.38.2
     */
    public func getError(): Option<OAuth2Error> {
        return error
    }

    /**
     * Get the error descriuption
     *
     * @return String error descriuption
     * @since 0.38.2
     */
    public func getErrorDescription(): String {
        return errorDescription
    }

    /**
     * Get the error URL instance
     *
     * @return URL error URL instance
     * @since 0.38.2
     */
    public func getErrorUri(): URL {
        return errorUrl
    }
}

