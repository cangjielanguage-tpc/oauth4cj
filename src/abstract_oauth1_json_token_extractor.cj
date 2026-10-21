/**
 * @file The file declars the AbstractOAuth1JSONTokenExtractor class.
 */
package oauth4cj

/**
 * The class AbstractOAuth1JSONTokenExtractor implementation of the TokenExtractor interface.
 */
public abstract class AbstractOAuth1JSONTokenExtractor<T> <: TokenExtractor<T> where T <: OAuth1Token {

    /**
     * Extract specific types of tokens from the content of the HTTP response.
     *
     * @Param get token from the response
     *
     * @Return T specific types of Token
     * @throws IOException problem retrieving body from response
     */
    public func extract(response: OAuth4cjResponse): T {
        let rawBody: String = response.getBody()
        var err: String = "Response body is incorrect. Can't extract a token from an empty string."
        Preconditions.checkEmptyString(rawBody, err)

        let body: JsonObject = JsonValue.fromStr(rawBody).asObject()

        let flagToken: Bool = body.containsKey(OAuthConstants.TOKEN)
        let flagSecret: Bool = body.containsKey(OAuthConstants.TOKEN_SECRET)
        if (!flagToken || !flagSecret) {
            throw OAuth4cjException(
                "Response body is incorrect. Can't extract token and secret from this: '${rawBody}'")
        }

        let token: String = asTextOfJsonValue(body.get(OAuthConstants.TOKEN).getOrThrow())
        let secret: String = asTextOfJsonValue(body.get(OAuthConstants.TOKEN_SECRET).getOrThrow())
        return createToken(token, secret, rawBody)
    }

    protected func createToken(token: String, secret: String, response: String): T

}
