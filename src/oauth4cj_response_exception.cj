/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights resvered.
 */

/**
 * @file The file declars the OAuthResponseException class.
 */
package oauth4cj


public open class OAuthResponseException <: OAuth4cjException {

    private let response: OAuth4cjResponse

    private let HASH_CODE_DEFAULT: Int64 = 29 * 5

    /**
     * Create a OAuthResponseException instance according to the parameter.
     *
     * @param map of Response
     * @since 0.37.2
     */
    public init(rawResponse: OAuth4cjResponse) {
        super(rawResponse.getBody())
        this.response = rawResponse
    }

    /**
     * Get the Response.
     *
     * @return Type of Response
     * @since 0.37.2
     */
    public func getResponse(): OAuth4cjResponse {
        return response
    }

    /**
     * Get hash code.
     *
     * @return Type of Int64
     * @since 0.37.2
     */
    public func hashCode(): Int64 {
        return HASH_CODE_DEFAULT + response.toString().hashCode()
    }

    /**
     * Determine whether two OAuthResponseException objects are equal.
     *
     * @param that of OAuthResponseException
     *
     * @return Type of Bool
     * @since 0.37.2
     */
    public func equals(obj: OAuthResponseException): Bool {
        if (refEq(this, obj)) {
            return true
        }
        return this.response.toString().equals(obj.getResponse().toString())
    }
}
