/**
 * @file The file declars the OAuth1RequestTokenJSONExtractor class.
 */
package oauth4cj

/**
 * The class OAuth1RequestTokenJSONExtractor implementation of the AbstractOAuth1JSONTokenExtractor class.
 */
public class OAuth1RequestTokenJSONExtractor <: AbstractOAuth1JSONTokenExtractor<OAuth1RequestToken> {

    protected init() {}

    /**
     * Create an OAuth1RequestTokenJSONExtractor instance.
     *
     * @since 0.38.2
     */
    public static func instance():OAuth1RequestTokenJSONExtractor {
        return OAuth1RequestTokenJSONExtractor()
    }

    protected func createToken(token: String, secret: String, response: String): OAuth1RequestToken {
        return OAuth1RequestToken(token, secret, response)
    }
}
