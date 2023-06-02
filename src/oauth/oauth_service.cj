/**
 * Copyright (c) Cangjie Library Team 2023-2023. All rights resvered.
 */

package oauth

public open class OAuthService <: Resource {
    private var apiKey: String
    private var apiSecret: String
    private var callback: String
    private var userAgent: String
    private var httpClient: Option<HttpClient> = Option<HttpClient>.None
    private var debugStream: Option<OutputStream> = Option<OutputStream>.None

    public init(apiKey: String, apiSecret: String, callback: String, debugStream: Option<OutputStream>,
            userAgent: String, httpClientConfig: Option<HttpClientConfig>, httpClient: Option<HttpClient>) {
        this.apiKey = apiKey
        this.apiSecret = apiSecret
        this.callback = callback
        this.debugStream = debugStream
        this.userAgent = userAgent
    }

    public func getApiKey(): String {
        return apiKey
    }

    public func getApiSecret(): String {
        return apiSecret
    }

    public func getCallback(): String {
        return callback
    }

    public func close(): Unit {}

    public func isClosed(): Bool {
        return false
    }
}

