/**
 * Copyright (c) Cangjie Library Team 2023-2023. All rights resvered.
 */

package oauth

public class OAuth10aService <: OAuthService {
    private static let VERSION: String = "1.0"

    /**
     * Create OAuth10aService instance.
     *
     * @param api DefaultApi10a instance
     * @param apiKey api key
     * @param apiSecret api secret
     * @param callback callback url
     * @param scope scope string
     * @param debugStream debug mode outputstream, set Option<OutputStream>.None when not in use
     * @param userAgent user agent
     * @param httpClientConfig Http Client Config
     * @param httpClient HTTP Client instance
     */
    public init(api: DefaultApi10a, apiKey: String, apiSecret: String, callback: String, scope: String,
            debugStream: Option<OutputStream>, userAgent: String, httpClientConfig: Option<HttpClientConfig>,
            httpClient: Option<HttpClient>) {
        super(apiKey, apiSecret, callback, debugStream, userAgent, httpClientConfig, httpClient)
    }
}

