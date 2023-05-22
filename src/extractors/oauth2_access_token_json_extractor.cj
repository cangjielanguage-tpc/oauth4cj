/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights reserved.
 * Description:
 */

/**
 * @file The file declars the OAuth2AccessTokenJsonExtractor class.
 */
package extractors

import oauth2.*

/**
 * The AbstractJsonExtractor class of OAuth 2.0 and the implementation class of the TokenExtractor interface.
 * JSON implementation of TokenExtractor for OAuth 2.0
 */
public class OAuth2AccessTokenJsonExtractor <: AbstractJsonExtractor & TokenExtractor<OAuth2AccessToken> {

    protected init() {}

    /**
     * Create an OAuth2AccessTokenJsonExtractor instance.
     *
     * @since 0.38.2
     */
    public static func instance(): OAuth2AccessTokenJsonExtractor {
        return OAuth2AccessTokenJsonExtractor()
    }

    /**
     * Extract specific types of tokens from the content of the HTTP response.
     *
     * @Param get token from the response
     *
     * @Return OAuth2AccessToken types of OAuth2AccessToken
     * @throws IOException problem retrieving body from response
     */
    public func extract(response: Response): OAuth2AccessToken {
        let body: String = response.getBody()
        Preconditions.checkEmptyString(body, "Response body is incorrect. Can't extract a token from an empty string")

        if (response.getCode() != 200) {
            generateError(response)
        }
        return createToken(body)
    }

    /**
     * Retrieve the field information of the error response from the response body,
     * encapsulate it into an OAuth2AccessTokenErrorResponse exception, and throw it.
     *
     * @Param check get error message from the response
     *
     * @throws IOException If an error occurs when obtaining the response body as a string,
     *                     an IOException will be thrown.
     * @throws OAuth2AccessTokenErrorResponse
     *                     Obtain the field information of the error response from the response body,
     *                     encapsulate and throw OAuth2AccessTokenErrorResponse.
     */
    public func generateError(response: Response): Unit {
        let responseBody: String = response.getBody()
        var responseBodyJson: JsonObject = JsonObject()
        let emptyErrorUri: URL = URL.parse("")
        try {
            responseBodyJson = JsonValue.fromStr(responseBody).asObject()
        } catch (ex: Exception) {
            throw OAuth2AccessTokenErrorResponse(None, "", emptyErrorUri, response)
        }

        var errorUriInString: String = ""
        if (responseBodyJson.containsKey("error_uri")) {
            errorUriInString = asTextOfJsonValue(responseBodyJson.get("error_uri").getOrThrow())
        }

        var errorUri: URL = emptyErrorUri
        try {
            errorUri = URL.parse(errorUriInString)
        } catch (iae: IllegalArgumentException) {
            errorUri = emptyErrorUri
        }

        var errorCode: Option<OAuth2Error> = None
        try {
            errorCode = OAuth2Error.parseFrom(
                        asTextOfJsonValue(extractRequiredParameter(responseBodyJson, "error", responseBody)))
        } catch (iaE: IllegalArgumentException) {
            errorCode = None
        }

        var errorDescription: String = ""
        if (responseBodyJson.containsKey("error_description")) {
            errorDescription = asTextOfJsonValue(responseBodyJson.get("error_description").getOrThrow())
        }

        throw OAuth2AccessTokenErrorResponse(errorCode, errorDescription, errorUri, response)
    }

    private func createToken(rawResponse: String): OAuth2AccessToken {
        let response: JsonObject = JsonValue.fromStr(rawResponse).asObject()

        var expiresInNode: Int32 = 0
        if (response.containsKey("expires_in")) {
            expiresInNode = asIntOfJsonValue(response.get("expires_in").getOrThrow(), 0)
        }

        var refreshToken: String = ""
        if (response.containsKey(OAuthConstants.REFRESH_TOKEN)) {
            refreshToken = asTextOfJsonValue(response.get(OAuthConstants.REFRESH_TOKEN).getOrThrow())
        }

        var scope: String = ""
        if (response.containsKey(OAuthConstants.SCOPE)) {
            scope = asTextOfJsonValue(response.get(OAuthConstants.SCOPE).getOrThrow())
        }

        var tokenType: String = ""
        if (response.containsKey("token_type")) {
            tokenType = asTextOfJsonValue(response.get("token_type").getOrThrow())
        }

        return createToken(
                asTextOfJsonValue(extractRequiredParameter(response, OAuthConstants.ACCESS_TOKEN, rawResponse)),
                tokenType, expiresInNode, refreshToken, scope, rawResponse)
    }

    protected func createToken(accessToken: String, tokenType: String, expiresIn: Int32,
            refreshToken: String, scope: String, rawResponse: String): OAuth2AccessToken {
        return OAuth2AccessToken(accessToken, tokenType, expiresIn, refreshToken, scope, rawResponse)
    }
}
