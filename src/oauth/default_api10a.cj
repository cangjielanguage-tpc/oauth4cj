/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights reserved.
 */
package oauth

from std import io.OutputStream

import extractors.*
import httpclient.HttpClientConfig
import httpclient.HttpClient
import model.OAuthConstants
import model.OAuth1AccessToken
import model.OAuth1RequestToken
import model.ParameterList
import model.Verb
import services.*
/**
 * Default Api 1.0a
 */
public abstract class DefaultApi10a {

    /**
     * Returns the access token extractor.
     *
     * @return access token extractor
     */
    public open func getAccessTokenExtractor(): TokenExtractor<OAuth1AccessToken> {
        return OAuth1AccessTokenExtractor.instance()
    }

    /**
     * Returns the base string extractor.
     *
     * @return base string extractor
     */
    public open func getBaseStringExtractor(): BaseStringExtractor {
        return BaseStringExtractorImpl()
    }

    /**
     * Returns the header extractor.
     *
     * @return header extractor
     */
    public open func getHeaderExtractor(): HeaderExtractor {
        return HeaderExtractorImpl()
    }

    /**
     * Returns the request token extractor.
     *
     * @return request token extractor
     */
    public open func getRequestTokenExtractor(): TokenExtractor<OAuth1RequestToken> {
        return OAuth1RequestTokenExtractor.instance()
    }

    /**
     * Returns the signature service.
     *
     * @return signature service
     */
    public open func getSignatureService(): SignatureService {
        return HMACSha1SignatureService()
    }

    /**
     * Returns the signature type.
     * 
     * @return the signature type, choose between header, querystring, etc. Defaults to Header
     */
    public open func getSignatureType(): OAuth1SignatureType {
        return OAuth1SignatureType.HEADER
    }

    /**
     * Returns the timestamp service.
     *
     * @return timestamp service
     */
    public open func getTimestampService(): TimestampService {
        return TimestampServiceImpl()
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
     * Returns the verb for the request token endpoint (defaults to POST)
     *
     * @return request token endpoint verb
     */
    public open func getRequestTokenVerb(): Verb {
        return Verb.POST
    }

    /**
     * Returns the URL that receives the request token requests.
     *
     * @return request token URL
     */
    public func getRequestTokenEndpoint(): String

    /**
     * Returns the URL that receives the access token requests.
     *
     * @return access token URL
     */
    public func getAccessTokenEndpoint(): String 

    protected func getAuthorizationBaseUrl(): String 

    /**
     * Returns the URL where you should redirect your users to authenticate your application.
     *
     * @param requestToken the request token you need to authorize
     * @return the URL where you should redirect your users
     */
    public open func getAuthorizationUrl(requestToken: OAuth1RequestToken): String {
        let parameters: ParameterList = ParameterList()
        parameters.add(OAuthConstants.TOKEN, requestToken.getToken())
        return parameters.appendTo(getAuthorizationBaseUrl())
    }

    /**
     * Create OAuth10aService instance.
     *
     * @param apiKey api key
     * @param apiSecret api secret
     * @param callback callback url
     * @param scope scope string
     * @param debugStream debug mode outputstream, set Option<OutputStream>.None when not in use
     * @param userAgent user agent
     * @param httpClientConfig Http Client Config
     * @param httpClient HTTP Client instance
     * @return OAuth10aService OAuth10aService instance
     */
    public func createService(apiKey:String, apiSecret: String, callback: String, scope: String,
            debugStream: Option<OutputStream>, userAgent: String, httpClientConfig: Option<HttpClientConfig>,
            httpClient: Option<HttpClient>): OAuth10aService {
        return OAuth10aService(this, apiKey, apiSecret, callback, scope, debugStream, userAgent,
            httpClientConfig, httpClient)
    }

    /**
     * whether to inlcude empty oauth_token param to the request
     * The client MAY omit the empty "oauth_token" protocol parameter from the request", 
     * but not all oauth servers support it.
     *
     * @return Bool whether to inlcude empty oauth_token param to the request
     */
    public open func isEmptyOAuthTokenParamIsRequired(): Bool {
        return false
    }
}

