package oauth4cj

/**
 * ServiceBuilderOAuth10a
 */
public class ServiceBuilderOAuth10a <: ServiceBuilderCommon {
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
     * @return ServiceBuilderOAuth10a ServiceBuilderOAuth10a instance
     */
    public func setCallback(callback: Option<String>): ServiceBuilderOAuth10a {
        this.callback = callback
        return this
    }

    /**
     * Set Api Key
     *
     * @param apiKey api key
     * @return ServiceBuilderOAuth10a ServiceBuilderOAuth10a instance
     */
    public func setApiKey(apiKey: String): ServiceBuilderOAuth10a {
        Preconditions.checkEmptyString(apiKey, "Invalid Api key")
        this.apiKey = apiKey
        return this
    }

    /**
     * Set Api Secret
     *
     * @param apiSecret api secret
     * @return ServiceBuilderOAuth10a ServiceBuilderOAuth10a instance
     */
    public func setApiSecret(apiSecret: String): ServiceBuilderOAuth10a {
        Preconditions.checkEmptyString(apiSecret, "Invalid Api secret")
        this.apiSecret = apiSecret
        return this
    }

    /**
     * Set Api Secret to ""
     *
     * @return ServiceBuilderOAuth10a ServiceBuilderOAuth10a instance
     */
    public func setApiSecretIsEmptyStringUnsafe(): ServiceBuilderOAuth10a {
        apiSecret = ""
        return this
    }
    
    private func setScope(scope: String): ServiceBuilderOAuth10a {
        Preconditions.checkEmptyString(scope, "Invalid OAuth scope")
        this.scope = Some(scope)
        return this
    }

    /**
     * Set Scope
     *
     * @param scope scope string
     * @return ServiceBuilderOAuth10a ServiceBuilderOAuth10a instance
     */
    public func withScope(scope: String): ServiceBuilderOAuth10a {
        return setScope(scope)
    }

    /**
     * Set HttpClientConfig
     *
     * @param httpClientConfig Option<HttpClientConfig> instance
     * @return ServiceBuilderOAuth10a ServiceBuilderOAuth10a instance
     */
    public func setHttpClientConfig(httpClientConfig: Option<HttpClientConfig>): ServiceBuilderOAuth10a {
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
     * @return ServiceBuilderOAuth10a ServiceBuilderOAuth10a instance
     */
    public func setHttpClient(httpClient: Option<HttpClient>): ServiceBuilderOAuth10a {
        this.httpClient = httpClient
        return this
    }

    public func setHttpClientProvider(httpClientProvider: Option<HttpClientProvider>): ServiceBuilderOAuth10a {
        this.httpClientProvider = httpClientProvider
        return this
    }

    /**
     * Set User Agent
     *
     * @param userAgent user agent string
     * @return ServiceBuilderOAuth10a ServiceBuilderOAuth10a instance
     */
    public func setUserAgent(userAgent: String): ServiceBuilderOAuth10a {
        this.userAgent = userAgent
        return this
    }

    /**
     * Build OAuth10aService with DefaultApi10a
     *
     * @param api DefaultApi10a instance
     * @return OAuth10aService OAuth10aService instance
     */
    public func build(api: DefaultApi10a): OAuth10aService {
        return api.createService(apiKey, apiSecret, callback, scope, debugStream, userAgent, httpClientConfig,
                httpClient, httpClientProvider)
    }

    /**
     * Set debug stream, reserved interface for optimization
     *
     * @param debugStream Option<OutputStream> instance
     * @return ServiceBuilderOAuth10a ServiceBuilderOAuth10a instance
     */
    public func setDebugStream(debugStream: Option<OutputStream>): ServiceBuilderOAuth10a {
        this.debugStream = debugStream
        return this
    }
}

