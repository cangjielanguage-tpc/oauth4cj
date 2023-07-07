/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights reserved.
 */

/**
 * @file The file declars the CharacterUtil class.
 */
package commons


// '0'-'9': 48-57
let CHAR_0: Int64 = 48
let CHAR_9: Int64 = 57

// 'a'-'z': 97-122
let CHAR_a: Int64 = 97
let CHAR_z: Int64 = 122

// 'A'-'Z': 65-90
let CHAR_A: Int64 = 65
let CHAR_Z: Int64 = 90

let CHAR_SPACE: Int64 = 32 // ' '：32
let CHAR_B1: Int64 = 45 // '-'：45
let CHAR_B2: Int64 = 95 // '_'：95
let CHAR_B3: Int64 = 46 // '.'：46
let CHAR_B4: Int64 = 42 // '*'：42


/**
 * The class is CharacterUtil
 * @since 0.37.2
 */
class CharacterUtil  {

    // The minimum cardinality used to convert and from strings.
    public static let MIN_RADIX: Int64 = 2

    // The maximum cardinality used to convert and from strings.
    public static let MAX_RADIX: Int64 = 36

    /**
     * Determines the character representation of a specific number in a specified radix.
     * "If the base value is not a valid radix, or the numeric value is not a valid number in the specified radix,
     * a null character (" " u0000" ") is returned.".
     * If the cardinality parameter is greater than or equal to MIN_ Radix and less than or equal to MAX_ Radius,
     * the cardinality parameter is valid.
     * If 0<=number<cardinality, the numeric parameter is valid.
     * If the number is less than 10, "0"+a number is returned.
     * Otherwise, the value "a"+the number - 10 is returned.
     *
     * @param the number to convert to characters.
     * @param the radix.
     *
     * @return The return type of Char
     * @since 0.37.2
     */
    protected static func forDigit(digit: Int64, radix: Int64): Char {
        if ((digit >= radix) || (digit < 0)) {
            return '\0' // NUT - control character, first bit of ASK code table.
        }
        if ((radix < CharacterUtil.MIN_RADIX) || (radix > CharacterUtil.MAX_RADIX)) {
            return '\0'
        }
        if (digit < 10) {
            return Char(CHAR_0 + digit)
        }
        return Char(CHAR_a - 10 + digit)
    }
}
