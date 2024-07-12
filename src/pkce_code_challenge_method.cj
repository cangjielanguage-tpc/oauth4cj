/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights resvered.
 */

/**
 * @file The file declars the PKCECodeChallengeMethod enum.
 */
package oauth4cj


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
                let SHA256Instance: SHA256 = SHA256()
                let md: Array<Byte> = digest(SHA256Instance, codeVerifier)
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
