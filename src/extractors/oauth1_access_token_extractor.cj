/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights reserved.
 * Description:
 */

/**
 * @file The file declars the OAuth1AccessTokenExtractor class.
 */
package extractors

/**
 * The class OAuth1AccessTokenExtractor implementation of the AbstractOAuth1TokenExtractor class.
 */
public class OAuth1AccessTokenExtractor <: AbstractOAuth1TokenExtractor<OAuth1AccessToken> {

    protected init() {}

    /**
     * Create an OAuth1AccessTokenExtractor instance.
     *
     * @since 0.38.2
     */
    public static func instance(): OAuth1AccessTokenExtractor {
        return OAuth1AccessTokenExtractor()
    }

    protected func createToken(token: String, secret: String, response: String): OAuth1AccessToken {
        return OAuth1AccessToken(token, secret, response)
    }

}
