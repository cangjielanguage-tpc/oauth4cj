/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights reserved.
 * 
 */
package model

/**
 * OAuth1 Request Token
 * @since 0.37.2
 */
public class OAuth1RequestToken <: OAuth1Token {
    private var oauthCallbackConfirmed: Bool = true

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
     * @Param rawResponse rawResponse
     * @since 0.37.2
     */
    public init(token: String, tokenSecret: String, rawResponse: String) {
        this(token, tokenSecret, true, rawResponse)
    }

    /**
     * Constructor
     *
     * @Param token token
     * @Param tokenSecret tokenSecret
     * @Param oauthCallbackConfirmed oauth callback confirmed flag
     * @Param rawResponse raw response information
     * @since 0.37.2
     */
    public init(token: String, tokenSecret: String, oauthCallbackConfirmed: Bool, rawResponse: String) {
        super(token, tokenSecret, rawResponse)
        this.oauthCallbackConfirmed = oauthCallbackConfirmed
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
     * the oauth callback has been confirmed
     *
     * @return Bool Must be present and set to "true", The parameter is used to 
     *              differentiate from previous versions of the protocol
     * @since 0.37.2
     */
    public func isOauthCallbackConfirmed(): Bool {
        return oauthCallbackConfirmed
    }

    /**
     * overwrite equals
     * 
     * @Param object object to compare
     * @return Bool if object is OAuth1RequestToken and token value is the same and 
     *              tokenSecret value is the same return true 
     * @since 0.37.2
     */
    public func equals(object: Object): Bool {
        let objectAS: Option<OAuth1RequestToken> = object as OAuth1RequestToken
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