/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights reserved.
 * Description:
 */

/**
 * @file The file declars the AbstractOAuth1JSONTokenExtractor class.
 */
package extractors

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
    public func extract(response: Response): T {
        let rawBody: String = response.getBody()
        var err: String = "Response body is incorrect. Can't extract a token from an empty string."
        Preconditions.checkEmptyString(rawBody, err)

        let body: JsonObject = JsonValue.fromStr(rawBody).asObject()

        var token: String = ""
        var secret: String = ""
        if (body.containsKey(OAuthConstants.TOKEN)) {
            token = body.get(OAuthConstants.TOKEN).getOrThrow().asString().getValue()
        }
        if (body.containsKey(OAuthConstants.TOKEN_SECRET)) {
            secret = body.get(OAuthConstants.TOKEN_SECRET).getOrThrow().asString().getValue()
        }
        return createToken(token, secret, rawBody)
    }

    protected func createToken(token: String, secret: String, response: String): T

}
