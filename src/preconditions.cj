/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights reserved.
 * Description:
 */

/**
 * @file The file declars the Preconditions class.
 */
package oauth4cj

from std import unicode.*

/**
 * blank judgment tools.
 */
public class Preconditions {

    private static let DEFAULT_MESSAGE: String = "Received an invalid parameter"

    /**
     * Checks the string is empty.
     *
     * @param checks the string is empty.
     * @param exception message
     *
     * @throws IllegalArgumentException if the string is empty
     *             or if the characters in the string are Unicode whitespace characters.
     */
    public static func checkEmptyString(str: String, errorMsg: String): Unit {
        check(hasText(str), errorMsg)
    }

    /**
     * Check if the string is empty,
     * and then determine if the characters in the string are Unicode whitespace characters.
     *
     * @param checks the string.
     *
     * @return Type of Bool,
     *        if the string is not empty and the characters in the string are not Unicode whitespace characters,
     *        return true; otherwise, return false.
     * @since 0.37.2
     */
    public static func hasText(str: String): Bool {
        if (str.isEmpty()) {
            return false
        }
        let array = str.toRuneArray()
        for (c in array) {
            if (!c.isWhiteSpace()) {
                return true
            }
        }
        return false
    }

    private static func check(requirements: Bool, error: String): Unit {
        if (!requirements) {
            var err: String = DEFAULT_MESSAGE
            if (hasText(error)) {
                err = error
            }
            throw IllegalArgumentException(err)
        }
    }

}
