/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights resvered.
 */

/**
 * @file The file declars the OAuth1RequestTokenExtractor class.
 */
package oauth4cj

/**
 * The class OAuth1RequestTokenExtractor implementation of the AbstractOAuth1TokenExtractor class.
 */
public class OAuth1RequestTokenExtractor <: AbstractOAuth1TokenExtractor<OAuth1RequestToken> {

    protected init() {}

    /**
     * Create an OAuth1RequestTokenExtractor instance.
     *
     * @since 0.38.2
     */
    public static func instance(): OAuth1RequestTokenExtractor {
        return OAuth1RequestTokenExtractor()
    }

    protected func createToken(token: String, secret: String, response: String): OAuth1RequestToken {
        return OAuth1RequestToken(token, secret, response);
    }
}
