/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights reserved.
 * 
 */
package oauth4cj

/**
 * OAuth1 Token
 * @since 0.37.2
 */
public open class OAuth1Token <: Token {
    private var token: String = ""
    private var tokenSecret: String = ""

    public init() {}

    /**
     * Constructor
     *
     * @Param token token
     * @Param tokenSecret tokenSecret
     * @Param rawResponse raw response information
     * @since 0.37.2
     */
    public init(token: String, tokenSecret: String, rawResponse: String) {
        super(rawResponse)
        this.token = token
        this.tokenSecret = tokenSecret
    }

    /**
     * get token
     *
     * @Return String token
     * @since 0.37.2
     */
    public open func getToken(): String {
        return token
    }

    /**
     * get tokenSecret
     *
     * @Return String tokenSecret
     * @since 0.37.2
     */
    public open func getTokenSecret(): String {
        return tokenSecret
    }

    /**
     * whether the OAuth1Token is empty
     * 
     * @return Bool if token is "" and tokenSecret is "" return true
     * @since 0.37.2
     */
    public func isEmpty(): Bool {
        return token.isEmpty() && tokenSecret.isEmpty()
    }
}