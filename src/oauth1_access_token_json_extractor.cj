/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights reserved.
 * Description:
 */

/**
 * @file The file declars the OAuth1AccessTokenJSONExtractor class.
 */
package oauth4cj

/**
 * The class OAuth1AccessTokenJSONExtractor implementation of the AbstractOAuth1JSONTokenExtractor class.
 */
public class OAuth1AccessTokenJSONExtractor <: AbstractOAuth1JSONTokenExtractor<OAuth1AccessToken> {

    protected init() {}

    protected func createToken(token: String, secret: String, response: String): OAuth1AccessToken {
        return OAuth1AccessToken(token, secret, response)
    }

    /**
     * Create an OAuth1AccessTokenJSONExtractor instance.
     *
     * @since 0.38.2
     */
    public static func instance(): OAuth1AccessTokenJSONExtractor {
        return OAuth1AccessTokenJSONExtractor()
    }
}
