/**
 * Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights resvered.
 */
package oauth4cj

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
            case ACCESS_TOKEN_HINT => "access_token"
            case REFRESH_TOKEN_HINT => "refresh_token" 
        }
    }
}

