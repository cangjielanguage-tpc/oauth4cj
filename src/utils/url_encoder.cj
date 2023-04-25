/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights reserved.
 */

/**
 * @file The file declars the URLEncoder class.
 */
package utils

from std import convert.*

/**
 * Utility class for HTML form encoding.
 * This class contains static methods for converting strings to the application/x-www-form-urlencoded MIME format.
 * For more information about HTML form encoding, see the HTML specification.
 * When encoding strings, the following rules apply:
 * The alphanumeric characters "a" through "z", "a" through "z", and "0" through "9" remain unchanged.
 * The special characters ".", "-", "*", and "_" remain unchanged.
 * The space character "" is converted to a plus sign "+".
 * All other characters are unsafe, first converting them to one or more bytes using some encoding scheme.
 * Then, each byte is represented by a 3-character string "% xy",
 * where xy is the two-digit hexadecimal representation of the byte.
 * It is recommended to use UTF-8 encoding scheme.
 * However, for compatibility reasons, if no encoding is specified, the platform's default encoding is used.
 *
 * For example: using UTF-8 as the encoding scheme,
 * the string “the stringü@foo bar” will be converted to “the+string+%C3%BC%40foo bar”,
 * Because in UTF-8, the character ü is encoded as two bytes C3 (hexadecimal) and BC (hexadecimal),
 * and the character is encoded as one byte 40 (hexadecimal).
 */
public class URLEncoder {

    static let DONT_NEED_ENCODING: BitSet = URLEncoder.getBitSet()
    static let CASE_DIFF: UInt32 = 32 // ('a' - 'A') = 32

    static func getBitSet(): BitSet {
        let bs: BitSet = BitSet(256)

        // 'a'-'z': 97-122
        for (i in CHAR_a..=CHAR_z) {
            bs.set(i)
        }
        // 'A'-'Z': 65-90
        for (i in CHAR_A..=CHAR_Z) {
            bs.set(i)
        }
        // '0'-'9': 48-57
        for (i in CHAR_0..=CHAR_9) {
            bs.set(i)
        }
        // encoding spaces as '+' is done in the encodes() method. '+' = 43
        bs.set(CHAR_SPACE) // ' '：32
        bs.set(CHAR_B1) // '-'：45
        bs.set(CHAR_B2) // '_'：95
        bs.set(CHAR_B3) // '.'：46
        bs.set(CHAR_B4) // '*'：42
        return bs
    }

    /**
     * Convert strings to application/x-www-form-urlencoded format using a specific encoding scheme.
     * only supported UTF-8.
     *
     * @param the string to be encoded.
     * @param the name of the supported character encoding.
     *
     * @return The return type of String, returns the encoded string.
     * @since 0.37.2
     */
    public static func encode(s: String, enc: String): String {
        if (enc.isEmpty()) {
            throw OAuth4cjException("charsetName can not be empty!")
        }
        if (!(enc.equals("UTF-8") || enc.equals("utf-8") || enc.equals("UTF8") || enc.equals("utf8"))) {
            throw OAuth4cjException("only UTF-8 is supported!")
        }

        try {
            return encode(s)
        } catch (e: Exception) {
            throw OAuth4cjException("encode fail: " + e.message)
        }
    }

    /**
     * Convert strings to application/x-wwwww-form-urlencoded format using a specific character set.
     * This method uses the provided character set to obtain the bytes of unsafe characters.
     * only supported UTF-8.
     *
     * @param the string to be encoded.
     *
     * @return The return type of String, returns the encoded string.
     * @since 0.37.2
     */
    public static func encode(s: String): String {
        var needToChange: Bool = false
        let out: StringBuilder = StringBuilder()
        let cas: CharArrayStream = CharArrayStream(512)

        let len: Int64 = s.size
        let charBuf: Array<Char> = s.toCharArray()
        var i: Int64 = 0
        while (i < len) {
            var ch: Char = charBuf[i]
            var c: Int64 = Int64(UInt32(ch))
            if (DONT_NEED_ENCODING.get(c)) {
                if (ch == ' ') {
                    ch = '+'
                    needToChange = true
                }
                out.append(ch)
                i++
            } else {
                i = convertToExternalEncoding(cas, ch, c, len, i, charBuf)

                handleCharArrayStream(out, cas)
                needToChange = true
            }
        }
        if (needToChange) {
            return out.toString()
        }
        return s
    }

    // Convert to external encoding before hexadecimal conversion.
    private static func convertToExternalEncoding(cas: CharArrayStream, char: Char, numCh: Int64,
                                                len: Int64, i: Int64, charBuf: Array<Char>): Int64 {
        var index: Int64 = i
        var ch: Char = char
        var numChar: Int64 = numCh
        do {
            cas.write(ch)
            if (numChar >= 0xD800 && numChar <= 0xDBFF && (index + 1) < len) {
                var dChar: Char = charBuf[index + 1]
                let dNum: Int64 = Int64(UInt32(dChar))
                if (dNum >= 0xDC00 && dNum <= 0xDFFF) {
                    cas.write(dChar)
                    index++
                }
            }
            index++

            if (index < len) {
                ch = charBuf[index]
                numChar = Int64(UInt32(ch))
            } else {
                break
            }
        } while (!DONT_NEED_ENCODING.get(numChar))
        return index
    }

    private static func handleCharArrayStream(out: StringBuilder, cas: CharArrayStream): Unit {
        let str: String = String(cas.toCharArray())
        let ba: Array<UInt8> = str.toUtf8Array()

        for (j in 0 .. ba.size) {
            out.append('%')
            var baChar: Char = CharacterUtil.forDigit(Int64((ba[j] >> 4) & 0xF), 16)
            // If ch is a letter, convert to using uppercase letters as part of the hexadecimal value.
            if (isLetter(baChar)) {
                baChar = Char(UInt32(baChar) - CASE_DIFF)
            }
            out.append(baChar)
            baChar = CharacterUtil.forDigit(Int64(ba[j] & 0xF), 16)
            if (isLetter(baChar)) {
                baChar = Char(UInt32(baChar) - CASE_DIFF)
            }
            out.append(baChar)
        }
        cas.reset()
    }

    private static func isLetter(ch: Char): Bool {
        return (ch >= 'a' && ch <= 'z') || (ch >= 'A' && ch <= 'Z')
    }

    /**
     * Decode the application/x-www-form-urlencoded string using a specific encoding scheme.
     * only supported UTF-8.
     *
     * @param the string to be decoded.
     * @param the name of the supported character decoding.
     *
     * @return The return type of String, returns the decoded string.
     * @since 0.37.2
     */
    public static func decode(s: String, enc: String): String {
        if (enc.isEmpty()) {
            throw OAuth4cjException("URLDecoder: empty string enc parameter.");
        }
        if (!(enc.equals("UTF-8") || enc.equals("utf-8") || enc.equals("UTF8") || enc.equals("utf8"))) {
            throw OAuth4cjException("only UTF-8 is supported!")
        }

        try {
            return decode(s)
        } catch (e: Exception) {
            throw OAuth4cjException("decode fail: " + e.message)
        }
    }

    /**
     * Decode the application/x-www-form-urlencoded string using a specific character set.
     * The provided character set is used to determine the characters represented by
     * any consecutive sequence of the form "% xy".
     * only supported UTF-8.
     *
     * @param the string to be decoded.
     *
     * @return The return type of String, returns the decoded string.
     * @since 0.37.2
     */
    public static func decode(s: String): String {
        var needToChange: Bool = false
        let numChars: Int64 = s.size
        let sb: StringBuilder = StringBuilder()
        var i: Int64 = 0

        var c: Char = ' '
        var bytes: Array<UInt8> = Array<UInt8>()

        let charBuf: Array<Char> = s.toCharArray()
        while (i < numChars) {
            c = charBuf[i]
            match (c) {
                case '+' =>
                    sb.append(' ')
                    i++
                    needToChange = true
                case '%' =>
                    try {
                        // (numChars-i)/3 is the upper limit of the remaining bytes.
                        if (bytes.size == 0) {
                            bytes = Array<UInt8>((numChars - i) / 3, item: 0)
                        }
                        i = handlePercentageSign(s, i, numChars, c, bytes, charBuf, sb)
                    } catch (e: Exception) {
                        let err: String = "URLDecoder: Illegal hex characters in escape (%) pattern - " + e.message
                        throw IllegalArgumentException(err)
                    }
                    needToChange = true
                case _ =>
                    sb.append(c)
                    i++
            }
        }
        if (needToChange) {
            return sb.toString()
        }
        return s
    }

    private static func handlePercentageSign(s: String, index: Int64, numChars: Int64, char: Char,
                                            bytes: Array<UInt8>, charBuf: Array<Char>, sb: StringBuilder): Int64 {
        var pos: Int64 = 0
        var i: Int64 = index
        var c: Char = char
        while ( ((i + 2) < numChars) && (c == '%')) {
            let strNum: String = "0X" + s.slice(i + 1, 2)
            let v: Int64 = Int64.parse(strNum)

            if (v < 0) {
                let err: String = "URLDecoder: Illegal hex characters in escape " + "(%) pattern - negative value"
                throw IllegalArgumentException(err)
            }
            bytes[pos] = UInt8(v)
            pos++
            i += 3
            if (i < numChars) {
                c = charBuf[i]
            }
        }

        // Trailing, incomplete byte encoding (such as "%x") will cause an exception to be thrown.
        if (i < numChars && c == '%') {
            throw IllegalArgumentException("URLDecoder: Incomplete trailing escape (%) pattern")
        }

        sb.append(String.fromUtf8(bytes[0..pos]))
        return i
    }
}
