/**
 * Copyright (c) Cangjie Library Team 2023-2023. All rights resvered.
 */

package oauth

import pkce.*
import util.*
import utils.*
import revoke.*
import exceptions.*
import model.*
import oauth2.*

/**
 * OAuth 2.0 Service
 */
public open class OAuth20Service <: OAuthService {
    private static let VERSION: String = "2.0"
    private var api: DefaultApi20
    private var responseType: String
    private var defaultScope: Option<String> = None
    private var httpClientProvider: Option<HttpClientProvider> = Option<HttpClientProvider>.None

    /**
     * Create OAuth20Service instance.
     *
     * @param api DefaultApi20 instance
     * @param apiKey api key 
     * @param apiSecret api secret
     * @param callback callback url
     * @param defaultScope default scope
     * @param responseType response type
     * @param debugStream debug mode outputstream, set Option<OutputStream>.None when not in use
     * @param userAgent user agent
     * @param httpClientConfig Http Client Config
     * @param httpClient Http Client instance
     */
    public init(api: DefaultApi20, apiKey: String, apiSecret: String, callback: String, defaultScope: ?String,
            responseType: String, debugStream: Option<OutputStream>, userAgent: String, 
            httpClientConfig: Option<HttpClientConfig>, httpClient: Option<HttpClient>,
            httpClientProvider: Option<HttpClientProvider>) {
        super(apiKey, apiSecret, callback, debugStream, userAgent, httpClientConfig, httpClient, httpClientProvider)
        this.responseType = responseType
        this.api = api
        this.defaultScope = defaultScope
    }

    public func getApi(): DefaultApi20 {
        return api
    }

    public func getDefaultScope(): Option<String> {
        return defaultScope
    }

    public func getResponseType(): String {
        return responseType
    }

    public func getVersion(): String {
        return VERSION
    }
}

