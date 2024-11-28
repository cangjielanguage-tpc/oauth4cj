/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights reserved.
 * 
 */
package oauth4cj

/**
 * OAuth2 Access Token
 * @since 0.37.2
 */
public class OAuth2AccessToken <: Token {
    private var accessToken: String = ""
    private var tokenType: String = ""
    private var expiresIn: Int32 = 0
    private var refreshToken: String = ""
    private var scope: String = ""

    /**
     * Constructor
     *
     * @Param accessToken access token
     * @since 0.37.2
     */
    public init(accessToken: String) {
        this(accessToken, "")
    }

    /**
     * Constructor
     *
     * @Param accessToken access token
     * @Param rawResponse raw response information
     * @since 0.37.2
     */
    public init(accessToken: String, rawResponse: String) {
        this(accessToken, "", 0, "", "", rawResponse)
    }

    /**
     * Constructor
     *
     * @Param accessToken access token
     * @Param tokenType token type
     * @Param expiresIn effective time of the access token
     * @Param refreshToken refresh token
     * @Param scope access scope
     * @Param rawResponse raw response information
     * @since 0.37.2
     */
    public init(accessToken: String, tokenType: String, expiresIn: Int32, refreshToken: String, scope: String,
            rawResponse: String) {
        super(rawResponse)
        if (expiresIn < 0) {
            throw OAuth4cjException("The effective time cannot be negative")
        }
        this.accessToken = accessToken
        this.tokenType = tokenType
        this.expiresIn = expiresIn
        this.refreshToken = refreshToken
        this.scope = scope
    }

    /**
     * get access token
     *
     * @return String access token
     * @since 0.37.2
     */
    public func getAccessToken(): String {
        return accessToken
    }

    /**
     * get token type
     *
     * @return String token type
     * @since 0.37.2
     */
    public func getTokenType(): String {
        return tokenType
    }

    /**
     * get effective time of the access token
     *
     * @return Int32 effective time of the access token
     * @since 0.37.2
     */
    public func getExpiresIn(): Int32 {
        return expiresIn
    }

    /**
     * get refresh token
     *
     * @return String refresh token
     * @since 0.37.2
     */
    public func getRefreshToken(): String {
        return refreshToken
    }

    /**
     * get access scope
     *
     * @return String access scope
     * @since 0.37.2
     */
    public func getScope(): String {
        return scope
    }

    /**
     * overwrite equals
     * 
     * @Param object object to compare
     * @return Bool if object is OAuth2AccessToken and each parameter value is the same return true 
     * @since 0.37.2
     */
    public func equals(object: Object): Bool {
        let objectAS: Option<OAuth2AccessToken> = object as OAuth2AccessToken
        match (objectAS) {
            case Some(token) =>
                if (!(token.getAccessToken() == accessToken)){
                    return false
                } 
                if (!(token.getTokenType() == tokenType)){
                    return false
                } 
                if (!(token.getRefreshToken() == refreshToken)){
                    return false
                } 
                if (!(token.getScope() == scope)){
                    return false
                } 
                return token.getExpiresIn() == expiresIn
            case None => return false
        }
    }
}