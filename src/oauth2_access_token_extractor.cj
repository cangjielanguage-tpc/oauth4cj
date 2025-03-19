/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights reserved.
 */

/**
 * @file The file declars the OAuth2AccessTokenExtractor class.
 */
package oauth4cj

/**
 * Custom Implementation of TokenExtractor for OAuth 2.0
 */
public class OAuth2AccessTokenExtractor <: TokenExtractor<OAuth2AccessToken> {

    private static let ACCESS_TOKEN_REGEX_PATTERN: Regex = Regex("access_token=([^&]+)")
    private static let TOKEN_TYPE_REGEX_PATTERN: Regex = Regex("token_type=([^&]+)")
    private static let EXPIRES_IN_REGEX_PATTERN: Regex = Regex("expires_in=([^&]+)")
    private static let REFRESH_TOKEN_REGEX_PATTERN: Regex = Regex("refresh_token=([^&]+)")
    private static let SCOPE_REGEX_PATTERN: Regex = Regex("scope=([^&]+)")

    protected init() {}

    /**
     * Create an OAuth2AccessTokenExtractor instance.
     *
     * @since 0.38.2
     */
    public static func instance(): OAuth2AccessTokenExtractor {
        return OAuth2AccessTokenExtractor()
    }

    /**
     * Extract specific types of tokens from the content of the HTTP response.
     *
     * @Param get token from the response
     *
     * @Return OAuth2AccessToken specific types of Token
     * @throws IOException problem retrieving body from response
     */
    public func extract(response: OAuth4cjResponse): OAuth2AccessToken {
        if (response.getCode() != 200) {
            throw OAuth4cjException("Response code is not 200 but '${response.getCode()}'")
        }
        let body: String = response.getBody()
        Preconditions.checkEmptyString(body, "Response body is incorrect. Can't extract a token from an empty string")

        let accessToken: String = extractParameter(body, ACCESS_TOKEN_REGEX_PATTERN, true)
        let tokenType: String = extractParameter(body, TOKEN_TYPE_REGEX_PATTERN, false)
        let expiresInString: String = extractParameter(body, EXPIRES_IN_REGEX_PATTERN, false)
        var expiresIn: Int32 = 0
        try {
            if (!expiresInString.isEmpty()) {
                expiresIn = Int32.parse(expiresInString)
            }
        } catch (nfe: Exception) {
            expiresIn = 0
        }
        let refreshToken: String = extractParameter(body, REFRESH_TOKEN_REGEX_PATTERN, false)
        let scope: String = extractParameter(body, SCOPE_REGEX_PATTERN, false)

        return OAuth2AccessToken(accessToken, tokenType, expiresIn, refreshToken, scope, body)
    }

    private static func extractParameter(response: String, regexPattern: Regex, required: Bool): String {

        let res: Option<MatchData> = regexPattern.find(response, group: true)
        match (res) {
            case Some(md) => return OAuthEncoder.decode(md.matchString(1))
            case None =>
                if (required) {
                    let err: String =
                    "Response body is incorrect. Can't extract a '${regexPattern.string()}' from this: '${response}'"
                    throw OAuth4cjException(err)
                }
                return ""
        }
    }
}
