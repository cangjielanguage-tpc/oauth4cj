/**
 * Copyright (c) Cangjie Library Team 2023-2023. All rights resvered.
 */

package oauth

/**
 * OAuth 2.0 Service
 */
public class OAuth20Service <: OAuthService {
    private static let VERSION: String = "2.0"

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
    public init(api: DefaultApi20, apiKey: String, apiSecret: String, callback: String, defaultScope: String,
            responseType: String, debugStream: Option<OutputStream>, userAgent: String, 
            httpClientConfig: Option<HttpClientConfig>, httpClient: Option<HttpClient>) {
        super(apiKey, apiSecret, callback, debugStream, userAgent, httpClientConfig, httpClient)
    }
}

