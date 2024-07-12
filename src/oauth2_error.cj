/**
 * Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights resvered.
 */

package oauth4cj

/**
 * OAuth2Error 
 */
public enum OAuth2Error {
    | INVALID_REQUEST
    | UNAUTHORIZED_CLIENT
    | ACCESS_DENIED
    | UNSUPPORTED_RESPONSE_TYPE
    | INVALID_SCOPE
    | SERVER_ERROR
    | TEMPORARILY_UNAVAILABLE
    | INVALID_CLIENT
    | INVALID_GRANT
    | UNSUPPORTED_GRANT_TYPE
    | INVALID_TOKEN
    | INSUFFICIENT_SCOPE
    | UNSUPPORTED_TOKEN_TYPE
    | AUTHORIZATION_PENDING
    | SLOW_DOWN
    | EXPIRED_TOKEN

    /**
     * Parse error string into type OAuth2Error
     *
     * @return OAuth2Error OAuth2Error Type
     * @since 0.38.2
     */
    public static func parseFrom(errorString: String): OAuth2Error {
        match (errorString) {
            case "invalid_request" => INVALID_REQUEST
            case "unauthorized_client" => UNAUTHORIZED_CLIENT
            case "access_denied" => ACCESS_DENIED
            case "unsupported_response_type" => UNSUPPORTED_RESPONSE_TYPE
            case "invalid_scope" => INVALID_SCOPE
            case "server_error" => SERVER_ERROR
            case "temporarily_unavailable" => TEMPORARILY_UNAVAILABLE
            case "invalid_client" => INVALID_CLIENT
            case "invalid_grant" => INVALID_GRANT
            case "unsupported_grant_type" => UNSUPPORTED_GRANT_TYPE
            case "invalid_token" => INVALID_TOKEN
            case "insufficient_scope" => INSUFFICIENT_SCOPE
            case "unsupported_token_type" => UNSUPPORTED_TOKEN_TYPE
            case "authorization_pending" => AUTHORIZATION_PENDING
            case "slow_down" => SLOW_DOWN
            case "expired_token" => EXPIRED_TOKEN
            case _ => throw IllegalArgumentException("there is no knowlege about ${errorString} Error")
        }
    }

    /**
     * Get error string
     *
     * @return String error string
     * @since 0.38.2
     */
    public func getErrorString(): String {
        match (this) {
            case INVALID_REQUEST => "invalid_request"
            case UNAUTHORIZED_CLIENT => "unauthorized_client"
            case ACCESS_DENIED => "access_denied"
            case UNSUPPORTED_RESPONSE_TYPE => "unsupported_response_type"
            case INVALID_SCOPE => "invalid_scope"
            case SERVER_ERROR => "server_error"
            case TEMPORARILY_UNAVAILABLE => "temporarily_unavailable"
            case INVALID_CLIENT => "invalid_client"
            case INVALID_GRANT => "invalid_grant"
            case UNSUPPORTED_GRANT_TYPE => "unsupported_grant_type"
            case INVALID_TOKEN => "invalid_token"
            case INSUFFICIENT_SCOPE => "insufficient_scope"
            case UNSUPPORTED_TOKEN_TYPE => "unsupported_token_type"
            case AUTHORIZATION_PENDING => "authorization_pending"
            case SLOW_DOWN => "slow_down"
            case EXPIRED_TOKEN => "expired_token"
        }
    }
}

