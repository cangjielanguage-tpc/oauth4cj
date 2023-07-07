/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights reserved.
 */
package builder

/**
 * Service Builder OAuth20
 */
public class ServiceBuilderOAuth20 <: ServiceBuilderCommon {
    private var debugStream: Option<OutputStream> = Option<OutputStream>.None
    private var callback: Option<String> = Option<String>.None
    private var apiKey: String = ""
    private var apiSecret: String = ""
    private var scope: Option<String> = Option<String>.None
    private var responseType: String = "code"
    private var userAgent: String = ""

    private var httpClientConfig: Option<HttpClientConfig> = Option<HttpClientConfig>.None
    private var httpClient: Option<HttpClient> = Option<HttpClient>.None
    private var httpClientProvider: Option<HttpClientProvider> = Option<HttpClientProvider>.None

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
     * @return ServiceBuilderOAuth20 ServiceBuilderOAuth20 instance
     */
    public func setCallback(callback: Option<String>): ServiceBuilderOAuth20 {
        this.callback = callback
        return this
    }

    /**
     * Set Api Key
     *
     * @param apiKey api key
     * @return ServiceBuilderOAuth20 ServiceBuilderOAuth20 instance
     */
    public func setApiKey(apiKey: String): ServiceBuilderOAuth20 {
        Preconditions.checkEmptyString(apiKey, "Invalid Api key")
        this.apiKey = apiKey
        return this
    }

    /**
     * Set Api Secret
     *
     * @param apiSecret api secret
     * @return ServiceBuilderOAuth20 ServiceBuilderOAuth20 instance
     */
    public func setApiSecret(apiSecret: String): ServiceBuilderOAuth20 {
        Preconditions.checkEmptyString(apiSecret, "Invalid Api secret")
        this.apiSecret = apiSecret
        return this
    }

    /**
     * Set Api Secret to ""
     *
     * @return ServiceBuilderOAuth20 ServiceBuilderOAuth20 instance
     */
    public func setApiSecretIsEmptyStringUnsafe(): ServiceBuilderOAuth20 {
        apiSecret = ""
        return this
    }

    private func setScope(scope: String): ServiceBuilderOAuth20 {
        Preconditions.checkEmptyString(scope, "Invalid OAuth scope")
        this.scope = Some(scope)
        return this
    }

    /**
     * Set Scope
     *
     * @param defaultScope Scope string
     * @return ServiceBuilderOAuth20 ServiceBuilderOAuth20 instance
     */
    public func setDefaultScope(defaultScope: String): ServiceBuilderOAuth20 {
        return setScope(defaultScope)
    }

    /**
     * Set Scope 
     *
     * @param scopeBuilder ScopeBuilder instance
     * @return ServiceBuilderOAuth20 ServiceBuilderOAuth20 instance
     */
    public func setDefaultScope(scopeBuilder: ScopeBuilder): ServiceBuilderOAuth20 {
        return setScope(scopeBuilder.build())
    }

    /**
     * Set Response Type
     *
     * @param responseType response type string
     * @return ServiceBuilderOAuth20 ServiceBuilderOAuth20 instance
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
     * @return ServiceBuilderOAuth20 ServiceBuilderOAuth20 instance
     */
    public func setHttpClientConfig(httpClientConfig: Option<HttpClientConfig>): ServiceBuilderOAuth20 {
        httpClientConfig.getOrThrow(insideSetHttpClientConfig)
        this.httpClientConfig = httpClientConfig
        return this
    }

    private func insideSetHttpClientConfig(): Exception {
    	return IllegalArgumentException("httpClientConfig can't be null")
    }

    /**
     * Set HttpClient
     *
     * @param httpClient Option<HttpClient> instance
     * @return ServiceBuilderOAuth20 ServiceBuilderOAuth20 instance
     */
    public func setHttpClient(httpClient: Option<HttpClient>): ServiceBuilderOAuth20 {
        this.httpClient = httpClient
        return this
    }

    /**
     * Set HttpClient Provider
     *
     * @param httpClientProvider Option<HttpClientProvider> instance
     * @return ServiceBuilderOAuth20 ServiceBuilderOAuth20 instance
     */
    public func setHttpClientProvider(httpClientProvider: Option<HttpClientProvider>): ServiceBuilderOAuth20 {
        this.httpClientProvider = httpClientProvider
        return this
    }

    /**
     * Set User Agent
     *
     * @param userAgent user agent string
     * @return ServiceBuilderOAuth20 ServiceBuilderOAuth20 instance
     */
    public func setUserAgent(userAgent: String): ServiceBuilderOAuth20 {
        this.userAgent = userAgent
        return this
    }

    /**
     * Build OAuth20Service with DefaultApi20
     *
     * @param api DefaultApi20 instance
     * @return OAuth20Service OAuth20Service instance
     */
    public func build(api: DefaultApi20): OAuth20Service {
        return api.createService(apiKey, apiSecret, callback, scope, responseType, debugStream, userAgent,
                httpClientConfig, httpClient, httpClientProvider)
    }

    /**
     * Set debug stream, reserved interface for optimization
     *
     * @param debugStream Option<OutputStream> instance
     * @return ServiceBuilderOAuth20 ServiceBuilderOAuth20 instance
     */
    public func setDebugStream(debugStream: Option<OutputStream>): ServiceBuilderOAuth20 {
        this.debugStream = debugStream
        return this
    }
}

