/**
 * Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights resvered.
 */

package oauth4cj

public abstract class OAuthService <: Resource {
    private var apiKey: String
    private var apiSecret: String
    private var callbackUrl: Option<String> = Option<String>.None
    private var userAgent: String
    private var httpClient: Option<HttpClient> = Option<HttpClient>.None
    private var debugStream: Option<OutputStream> = Option<OutputStream>.None
    private var isClosedFlag: Bool = false
    var hasClient: Bool = false
    var hasConfig: Bool = false
    var hasProvider: Bool = false

    /**
     * Create OAuthService instance.
     *
     * @param apiKey api key
     * @param apiSecret api secret
     * @param callbackUrl callback url
     * @param debugStream debug mode outputstream, set Option<OutputStream>.None when not in use
     * @param userAgent user agent
     * @param httpClientConfig Http Client Config
     * @param httpClient HTTP Client instance
     * @param httpClientProvider HTTP Client Provider instance
     */
    public init(apiKey: String, apiSecret: String, callbackUrl: Option<String>, debugStream: Option<OutputStream>,
            userAgent: String, httpClientConfig: Option<HttpClientConfig>, httpClient: Option<HttpClient>,
            httpClientProvider: Option<HttpClientProvider>) {
        this.apiKey = apiKey
        this.apiSecret = apiSecret
        this.callbackUrl = callbackUrl
        this.debugStream = debugStream
        this.userAgent = userAgent

        match (httpClient) {
            case None => hasClient = false
            case Some(data) => hasClient = true
        }

        match (httpClientConfig) {
            case None => hasConfig = false
            case Some(data) => hasConfig = true
        }

        match (httpClientProvider) {
            case None => hasProvider = false
            case Some(data) => hasProvider = true
        }

        if (hasClient) {
            this.httpClient = httpClient
        } else if (hasConfig && hasProvider) {
            this.httpClient = getClient(httpClientConfig.getOrThrow(), httpClientProvider.getOrThrow())
        } else if (hasConfig && !hasProvider) {
            this.httpClient = Option<HttpClient>.None
        } else {
            this.httpClient = Some(OkHttpHttpClient(OkHttpHttpClientConfig.defaultConfig()))
        }
    }

    private static func getClient(config: HttpClientConfig, provider: HttpClientProvider): Option<HttpClient> {
        return provider.createClient(config)
    }

    /**
     * Get apiKey
     *
     * @return String apiKey string
     */
    public open func getApiKey(): String {
        return apiKey
    }

    /**
     * Get apiSecret
     *
     * @return String apiSecret string
     */
    public open func getApiSecret(): String {
        return apiSecret
    }

    /**
     * Get callback url
     *
     * @return Option<String> callback string
     */
    public open func getCallback(): Option<String> {
        return callbackUrl
    }

    /**
     * Is Closed
     *
     * @return Bool deflaut true
     */
    public open func isClosed(): Bool {
        return isClosedFlag
    }

    /**
     * Close httpClient
     */
    public open func close(): Unit {
        httpClient.getOrThrow().close()
        isClosedFlag = true
    }

    /**
     * Get version
     *
     * @return String version string
     */
    public func getVersion(): String

    /**
     * Async request execute
     * 
     * @param request OAuth4cjRequest instance
     * @return Future<Any> response data
     */
    public func executeAsync(request: OAuth4cjRequest): Future<Any> {
        return execute(request, Option<OAuthAsyncRequestCallback>.None)
    }

    /**
     * Execute
     * 
     * @param request OAuth4cjRequest instance
     * @param callback OAuthAsyncRequestCallback instance, allow as None
     * @return Future<Any> response data
     */
    public func execute(request: OAuth4cjRequest, callback: Option<OAuthAsyncRequestCallback>): Future<Any> {
        return execute(request, callback, Option<ResponseConverter>.None)
    }

    /**
     * Execute
     * 
     * @param request OAuth4cjRequest instance
     * @param callback OAuthAsyncRequestCallback instance, allow as None
     * @param converter ResponseConverter instance, allow as None
     * @return Future<Any> response data
     */
    public func execute(request: OAuth4cjRequest, callback: Option<OAuthAsyncRequestCallback>,
            converter: Option<ResponseConverter>): Future<Any> {

        let filePayload: Option<File> = request.getFilePayload()
        let stringPayload: String = request.getStringPayload()

        var hasFile: Bool = false
        match (filePayload) {
            case None => hasFile = false
            case Some(data) => hasFile = true
        }

        if (hasFile) {
            return httpClient.getOrThrow().executeAsync(userAgent, request.getHeaders(), request.getVerb(),
                request.getCompleteUrl(), filePayload.getOrThrow().readToEnd(), callback, converter)
        } else if (!stringPayload.isEmpty()) {
            return httpClient.getOrThrow().executeAsync(userAgent, request.getHeaders(), request.getVerb(),
                request.getCompleteUrl(), stringPayload.toArray(), callback, converter)
        } else {
            return httpClient.getOrThrow().executeAsync(userAgent, request.getHeaders(), request.getVerb(),
                request.getCompleteUrl(), request.getByteArrayPayload(), callback, converter)
        }
    }

    /**
     * Sync request execute
     * 
     * @param request OAuth4cjRequest instance
     * @return Response response data
     */
    public func execute(request: OAuth4cjRequest): OAuth4cjResponse {
        let filePayload: Option<File> = request.getFilePayload()
        let stringPayload: String = request.getStringPayload()
        let multipartPayload: Option<MultipartPayload> = request.getMultipartPayload()

        var hasFile: Bool = false
        match (filePayload) {
            case None => hasFile = false
            case Some(data) => hasFile = true
        }

        var hasMultipart: Bool = false
        match (multipartPayload) {
            case None => hasMultipart = false
            case Some(data) => hasMultipart = true
        }

        if (hasFile) {
            return httpClient.getOrThrow().execute(userAgent, request.getHeaders(), request.getVerb(),
                request.getCompleteUrl(), filePayload.getOrThrow().readToEnd())
        } else if (!stringPayload.isEmpty()) {
            return httpClient.getOrThrow().execute(userAgent, request.getHeaders(), request.getVerb(),
                request.getCompleteUrl(), stringPayload.toArray())
        } else if (hasMultipart) {
            return httpClient.getOrThrow().execute(userAgent, request.getHeaders(), request.getVerb(),
                request.getCompleteUrl(), multipartPayload.getOrThrow())
        } else {
            return httpClient.getOrThrow().execute(userAgent, request.getHeaders(), request.getVerb(),
                request.getCompleteUrl(), request.getByteArrayPayload())
        }
    }

    protected func log(message: String): Unit {
        if (isDebug()) {
            log(message, Array<String>())
        }
    }

    protected func log(messagePattern: String, params: Array<String>): Unit {
        for (para in params) {
            println("${messagePattern}: ${para}")
        }
    }

    protected func isDebug(): Bool {
        match (debugStream) {
            case None => return false
            case Some(data) => return true
        }
    }
}

