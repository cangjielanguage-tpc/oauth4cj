/**
 * Copyright (c) Cangjie Library Team 2023-2023. All rights resvered.
 */
package revoke

/**
 * as stated in RFC 7009 2.1. Revocation Request
 */
public enum TokenTypeHint {
    | ACCESS_TOKEN_HINT
    | REFRESH_TOKEN_HINT

    /**
     * get token type string
     * 
     * @Return String token type string
     */
    public func getValue(): String {
        match (this) {
            case ACCESS_TOKEN_HINT => "access_token_hint"
            case REFRESH_TOKEN_HINT => "refresh_token_hint" 
        }
    }
}

