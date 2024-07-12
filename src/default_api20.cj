/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights resvered.
 */
package oauth4cj

from std import collection.HashMap

/**
 * Default Api 2.0
 */
public abstract class DefaultApi20 {

    /**
     * Returns the access token extractor.
     *
     * @return access token extractor
     */
    public open func getAccessTokenExtractor(): TokenExtractor<OAuth2AccessToken> {
        return OAuth2AccessTokenJsonExtractor.instance()
    }

    /**
     * Returns the verb for the access token endpoint (defaults to POST)
     *
     * @return access token endpoint verb
     */
    public open func getAccessTokenVerb(): Verb {
        return Verb.POST
    }

    /**
     * Returns the URL that receives the access token requests.
     *
     * @return access token URL
     */
    public func getAccessTokenEndpoint(): String

    /**
     * Returns the URL that receives the refresh token requests.
     *
     * @return refresh token URL
     */
    public open func getRefreshTokenEndpoint(): String {
        return getAccessTokenEndpoint()
    }

    /**
     * As stated in RFC 7009 OAuth 2.0 Token Revocation
     *
     * @return endpoint, which allows clients to notify the authorization server that a previously obtained refresh or
     * access token is no longer needed.
     */
    public open func getRevokeTokenEndpoint(): String {
        throw IllegalArgumentException ("This API doesn't support revoking tokens or we have no info about this")
    }

    protected func getAuthorizationBaseUrl(): String

    /**
     * Returns the URL where you should redirect your users to authenticate your application.
     *
     * @param responseType response type
     * @param apiKey api key
     * @param additionalParams any additional GET params to add to the URL
     * @param callback callback url
     * @param state state string
     * @param scope scope string
     * @return the URL where you should redirect your users
     */
    public open func getAuthorizationUrl(responseType: String, apiKey: String, callback: ?String, scope: ?String,
            state: ?String, additionalParams: HashMap<String, String>): String {
        let parameters: ParameterList = ParameterList(additionalParams)
        parameters.add(OAuthConstants.RESPONSE_TYPE, responseType)
        parameters.add(OAuthConstants.CLIENT_ID, apiKey)

        match(callback) {
             case Some(x) => parameters.add(OAuthConstants.REDIRECT_URI, x)
             case _ => ()
        }
        match(scope) {
             case Some(x) => parameters.add(OAuthConstants.SCOPE, x)
             case _ => ()
        }
        match(state) {
             case Some(x) => parameters.add(OAuthConstants.STATE, x)
             case _ => ()
        }
        return parameters.appendTo(getAuthorizationBaseUrl())
    }

    /**
     * Create OAuth20Service instance.
     *
     * @param apiKey api key
     * @param apiSecret api secret
     * @param callbackUrl callback url
     * @param defaultScope default scope
     * @param responseType response type
     * @param debugStream debug mode outputstream, set Option<OutputStream>.None when not in use
     * @param userAgent user agent
     * @param httpClientConfig Http Client Config
     * @param httpClient Http Client instance
     * @return OAuth20Service OAuth20Service instance
     */
    public open func createService(apiKey: String, apiSecret: String, callbackUrl: Option<String>, defaultScope: Option<String>,
            responseType: String, debugStream: Option<OutputStream>, userAgent: String, 
            httpClientConfig: Option<HttpClientConfig>, httpClient: Option<HttpClient>,
            httpClientProvider: Option<HttpClientProvider>): OAuth20Service {
        return OAuth20Service(this, apiKey, apiSecret, callbackUrl, defaultScope, responseType, debugStream, userAgent,
            httpClientConfig, httpClient, httpClientProvider)
    }

    /**
     * Returns BearerSignature instance.
     *
     * @return BearerSignature BearerSignature instance
     */
    public open func getBearerSignature(): BearerSignature {
        return BearerSignatureAuthorizationRequestHeaderField.instance()
    }

    /**
     * Returns ClientAuthentication instance.
     *
     * @return ClientAuthentication ClientAuthentication instance
     */
    public open func getClientAuthentication(): ClientAuthentication {
        return HttpBasicAuthenticationScheme.instance()
    }

    /**
     * RFC 8628 OAuth 2.0 Device Authorization Grant
     *
     * @return the device authorization endpoint
     */
    public open func getDeviceAuthorizationEndpoint(): String {
        throw IllegalArgumentException(
            "This API doesn't support device authorization grant or we have no info about this")
    }

    /**
     * Returns DeviceAuthorizationJsonExtractor instance.
     *
     * @return DeviceAuthorizationJsonExtractor DeviceAuthorizationJsonExtractor instance
     */
    public open func getDeviceAuthorizationExtractor(): DeviceAuthorizationJsonExtractor {
        return DeviceAuthorizationJsonExtractor.instance()
    }
}

