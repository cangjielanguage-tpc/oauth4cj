/**
 * @file The file declars the AbstractOAuth1TokenExtractor class.
 */
package oauth4cj

/**
 * The class AbstractOAuth1TokenExtractor implementation of the TokenExtractor interface for OAuth 1.0a.
 * The process of extracting access tokens and request tokens is similar, so this class can do both.
 * <T> - The specific type of OAuth1Token. Access or request.
 */
public abstract class AbstractOAuth1TokenExtractor<T> <: TokenExtractor<T> where T <: OAuth1Token {

    private let OAUTH_TOKEN_REGEXP_PATTERN: Regex = Regex("oauth_token=([^&]+)")
    private let OAUTH_TOKEN_SECRET_REGEXP_PATTERN: Regex = Regex("oauth_token_secret=([^&]*)")

    /**
     * Extract specific types of tokens from the content of the HTTP response.
     *
     * @Param get token from the response
     *
     * @Return T specific types of Token
     * @throws IOException problem retrieving body from response
     */
    public func extract(response: OAuth4cjResponse): T {
        let body: String = response.getBody()
        Preconditions.checkEmptyString(body, "Response body is incorrect. Can't extract a token from an empty string")
        let token: String = extract(body, OAUTH_TOKEN_REGEXP_PATTERN)
        let secret: String = extract(body, OAUTH_TOKEN_SECRET_REGEXP_PATTERN)
        return createToken(token, secret, body)
    }

    private func extract(response: String, p: Regex): String {
        let res: Option<MatchData> = p.find(response, group: true)
        match (res) {
            case Some(md) =>
                if (md.groupCount() == 0) {
                    return OAuthEncoder.decode("")
                }
                return OAuthEncoder.decode(md.matchString(1))
            case None =>
                let err: String = "Response body is incorrect. Can't extract token and secret from this: '${response}'"
                throw OAuth4cjException(err)
        }
    }

    protected func createToken(token: String, secret: String, response: String): T
}
