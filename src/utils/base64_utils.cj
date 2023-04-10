/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights reserved.
 * Description:
 */

/**
 * @file The file declars the Base64Utils class.
 */
package utils

from encoding import base64.*

public open class Base64Utils {

    /**
     * Encodes the specified byte array into a string using the Base64 encoding scheme.
     *
     * @param array of bytes to encode
     *
     * @return Type of String, a string containing the resulting Base64 encoded characters.
     * @since 0.37.2
     */
    public static func encode(bytes: Array<UInt8>): String {
        return toBase64String(bytes)
    }
}
