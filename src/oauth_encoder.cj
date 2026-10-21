/**
 * @file The file declars the OAuthEncoder class.
 */
package oauth4cj

public class OAuthEncoder  {

    private static let CHARSET: String = "UTF-8"
    private static let ENCODING_RULES: HashMap<String, String> =
                                        HashMap<String, String>([("*", "%2A"), ("+", "%20"), ("%7E", "~")])

    /**
     * Convert strings to application/x-wwwww-form-urlencoded format using a specific character set.
     * only supported UTF-8 Character Set.
     *
     * @param the string to be encoded.
     *
     * @return The return type of String, returns the encoded string.
     * @since 0.37.2
     */
    public static func encode(src: String): String {
        if (src.isEmpty()) {
            return ""
        }
        var encoded: String = ""
        try {
            encoded = URLEncoder.encode(src, CHARSET)
        } catch (e: Exception) {
            throw OAuth4cjException("Charset not found while encoding string: " + CHARSET + e.message)
        }

        encoded = encoded.replace("*", "%2A")
        encoded = encoded.replace("+", "%20")
        encoded = encoded.replace("%7E", "~")
        return encoded
    }

    /**
     * Decode the application/x-www-form-urlencoded string using a specific encoding scheme.
     * only supported UTF-8 Character Set.
     *
     * @param the string to be decoded.
     *
     * @return The return type of String, returns the decoded string.
     * @since 0.37.2
     */
    public static func decode(encoded: String): String {
        if (encoded.isEmpty()) {
            return ""
        }
        try {
            return URLEncoder.decode(encoded, CHARSET)
        } catch (e: Exception) {
            throw OAuth4cjException("Charset not found while decoding string: " + CHARSET + e.message)
        }
    }
}
