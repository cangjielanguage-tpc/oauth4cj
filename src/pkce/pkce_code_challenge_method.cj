/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights reserved.
 * Description:
 */

/**
 * @file The file declars the PKCECodeChallengeMethod enum.
 */
package pkce

from cryptocj import sha256cj.*

import commons.*
import exceptions.*

public enum PKCECodeChallengeMethod <: ToString {
    | S256
    | PLAIN

    /**
     * Returns the processed string.
     *
     * @param codeVerifier of String to processed
     *
     * @return Type of String, returns the processed string.
     * @since 0.38.2
     */
    public func transform2CodeChallenge(codeVerifier: String): String {
        match(this) {
            case S256 =>
                let md: Array<UInt8> = Array<UInt8>(SHA256_DIGEST_LENGTH, item: 0)
                let arr: Array<UInt8> = codeVerifier.toUtf8Array()
                sha256(arr, md)
                return Base64Utils.encodeUrlWithoutPadding(md)
            case PLAIN => return codeVerifier
        }
    }

    /**
     * Convert the PKCECodeChallengeMethod name to a string.
     *
     * @Return String The converted string
     */
    public func toString(): String {
        match (this) {
            case S256 => "S256"
            case PLAIN => "PLAIN"
        }
    }
}
