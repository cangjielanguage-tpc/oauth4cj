/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights reserved.
 */
package builder

from std import io.OutputStream

import utils.Preconditions

/**
 * Service Builder
 */
public class ServiceBuilder <: ServiceBuilderOAuth10a & ServiceBuilderOAuth20 {

    private var debugStream: Option<OutputStream> = Option<OutputStream>.None
    private var callback: String = ""
    private var apiKey: String = ""
    private var apiSecret: String = ""
    private var scope: String = ""
    private var responseType: String = "code"
    private var userAgent: String = ""

    private var httpClientConfig: Option<HttpClientConfig> = Option<HttpClientConfig>.None
    private var httpClient: Option<HttpClient> = Option<HttpClient>.None

    /**
     * Create ServiceBuilder instance
     *
     * @param apiKey api key
     * @param exception message
     */
    public init(apiKey: String) {
        setApiKey(apiKey)
    }

    /**
     * Set Callback String
     *
     * @param callback callback string
     * @return ServiceBuilder ServiceBuilder instance
     */
    public func setCallback(callback: String): ServiceBuilder {
        this.callback = callback
        return this
    }

    /**
     * Set Api Key
     *
     * @param apiKey api key
     * @return ServiceBuilder ServiceBuilder instance
     */
    public func setApiKey(apiKey: String): ServiceBuilder {
        Preconditions.checkEmptyString(apiKey, "Invalid Api key")
        this.apiKey = apiKey
        return this
    }

    /**
     * Set Api Secret
     *
     * @param apiSecret api secret
     * @return ServiceBuilder ServiceBuilder instance
     */
    public func setApiSecret(apiSecret: String): ServiceBuilder {
        Preconditions.checkEmptyString(apiSecret, "Invalid Api secret")
        this.apiSecret = apiSecret
        return this
    }

    /**
     * Set Api Secret to ""
     *
     * @return ServiceBuilder ServiceBuilder instance
     */
    public func setApiSecretIsEmptyStringUnsafe(): ServiceBuilder {
        apiSecret = ""
        return this
    }
    
    private func setScope(scope: String): ServiceBuilder {
        Preconditions.checkEmptyString(scope, "Invalid OAuth scope")
        this.scope = scope
        return this
    }

    /**
     * Set Scope
     *
     * @param defaultScope Scope string
     * @return ServiceBuilder ServiceBuilder instance
     */
    public func setDefaultScope(defaultScope: String): ServiceBuilderOAuth20 {
        return setScope(defaultScope)
    }

    /**
     * Set Scope 
     *
     * @param scopeBuilder ScopeBuilder instance
     * @return ServiceBuilder ServiceBuilder instance
     */
    public func setDefaultScope(scopeBuilder: ScopeBuilder): ServiceBuilderOAuth20 {
        return setScope(scopeBuilder.build())
    }

    /**
     * Set Scope
     *
     * @param scope scope string
     * @return ServiceBuilder ServiceBuilder instance
     */
    public func withScope(scope: String): ServiceBuilderOAuth10a {
        return setScope(scope)
    }

    /**
     * Set Response Type
     *
     * @param responseType response type string
     * @return ServiceBuilder ServiceBuilder instance
     */
    public func setResponseType(responseType: String): ServiceBuilderOAuth20 {
        Preconditions.checkEmptyString(responseType, "Invalid OAuth responseType")
        this.responseType = responseType
        return this
    }

    /**
     * Set HttpClientConfig
     *
     * @param httpClientConfig Option<HttpClientConfig> instance
     * @return ServiceBuilder ServiceBuilder instance
     */
    public func setHttpClientConfig(httpClientConfig: Option<HttpClientConfig>): ServiceBuilder {
        match (httpClientConfig) {
            case Some(v) => 
                this.httpClientConfig = httpClientConfig
                return this
            case None => throw IllegalArgumentException("httpClientConfig can't be null")
        }
    }

    /**
     * Set HttpClient
     *
     * @param httpClient Option<HttpClient> instance
     * @return ServiceBuilder ServiceBuilder instance
     */
    public func setHttpClient(httpClient: Option<HttpClient>): ServiceBuilder {
        this.httpClient = httpClient
        return this
    }

    /**
     * Set User Agent
     *
     * @param userAgent user agent string
     * @return ServiceBuilder ServiceBuilder instance
     */
    public func setUserAgent(userAgent: String): ServiceBuilder {
        this.userAgent = userAgent
        return this
    }

    /**
     * Build OAuth10aService with DefaultApi10a
     *
     * @param api DefaultApi10a instance
     * @return ServiceBuilder ServiceBuilder instance
     */
    public func build(api: DefaultApi10a): OAuth10aService {
        return api.createService(apiKey, apiSecret, callback, scope, debugStream, userAgent, httpClientConfig,
                httpClient)
    }

    /**
     * Build OAuth20Service with DefaultApi20
     *
     * @param api DefaultApi20 instance
     * @return ServiceBuilder ServiceBuilder instance
     */
    public func build(api: DefaultApi20): OAuth20Service {
        return api.createService(apiKey, apiSecret, callback, scope, responseType, debugStream, userAgent,
                httpClientConfig, httpClient)
    }
        
    func setDebugStream(debugStream: Option<OutputStream>): ServiceBuilder {
        match (debugStream) {
            case Some(v) => 
                this.debugStream = debugStream
                return this
            case None => throw IllegalArgumentException("debugStream can't be null") 
        }
    }
        
    func debug(): ServiceBuilder {
        var stream: Option<OutputStream> = Option<OutputStream>.None
        return setDebugStream(stream)
    }
}

