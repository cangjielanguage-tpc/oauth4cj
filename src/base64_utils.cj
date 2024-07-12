/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights resvered.
 */

/**
 * @file The file declars the Base64Utils class.
 */
package oauth4cj

from encoding import base64.*

public open class Base64Utils {

    /**
     * Encodes the specified byte array into a string using the Base64 encoding scheme.
     * note: 1. use "Table 1: The Base64 Alphabet" of RFC 2045 (and RFC 4648).
     *       2. use '=' fill in 1 or 2 remaining bytes.
     *
     * @param array of bytes to encode
     *
     * @return Type of String, a string containing the resulting Base64 encoded characters.
     * @since 0.37.2
     */
    public static func encode(bytes: Array<UInt8>): String {
        return toBase64String(bytes)
    }
    

    /**
     * Encodes the specified byte array into a string using the Base64 encoding scheme, without padding.
     * note: 1. use the Table 2 of the RFC 4648("URL and Filename safe Base64"),
     *          with the '+' and '/' changed to '-' and '_'.
     *       2. no use '=' fill in 1 or 2 remaining bytes.
     *
     * @param array of bytes to encode
     *
     * @return Type of String, a string containing the resulting Base64 encoded characters.
     * @since 0.37.2
     */
    public static func encodeUrlWithoutPadding(bytes: Array<UInt8>): String {
        return encode(bytes).replace("=", "").replace("+", "-").replace("/", "_")
    }
}
