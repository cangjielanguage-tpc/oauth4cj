/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights reserved.
 * 
 */
package model

/**
 * OAuth1 Access Token
 * @since 0.37.2
 */
public class OAuth1AccessToken <: OAuth1Token {
    /**
     * Constructor
     *
     * @Param token token
     * @Param tokenSecret tokenSecret
     * @since 0.37.2
     */
    public init(token: String, tokenSecret: String) {
        this(token, tokenSecret, "")
    }

    /**
     * Constructor
     *
     * @Param token token
     * @Param tokenSecret tokenSecret
     * @Param rawResponse raw response information
     * @since 0.37.2
     */
    public init(token: String, tokenSecret: String, rawResponse: String) {
        super(token, tokenSecret, rawResponse)
    }

    /**
     * get token
     *
     * @Return String token
     * @since 0.37.2
     */
    public override func getToken(): String {
        return super.getToken()
    }

    /**
     * get tokenSecret
     *
     * @Return String tokenSecret
     * @since 0.37.2
     */
    public override func getTokenSecret(): String {
        return super.getTokenSecret()
    }

    /**
     * overwrite equals
     * 
     * @Param object object to compare
     * @return Bool if object is OAuth1AccessToken and token value is the same and 
     *              tokenSecret value is the same return true 
     * @since 0.37.2
     */
    public func equals(object: Object): Bool {
        let objectAS: Option<OAuth1AccessToken> = object as OAuth1AccessToken
        match (objectAS) {
            case Some(token) =>
                if (!token.getToken().equals(getToken())){
                    return false
                } else {
                    return token.getTokenSecret().equals(getTokenSecret())
                }
            case None => return false
        }
    }
}