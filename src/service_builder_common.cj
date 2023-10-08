/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights reserved.
 */
package oauth4cj

/**
 * Service Builder Common
 */
public interface ServiceBuilderCommon {

    /**
     * Adds an OAuth callback url
     *
     * @param callback callback url. Must be a valid url or 'oob'
     * @return ServiceBuilderCommon ServiceBuilderCommon instance
     */
    func setCallback(callback: Option<String>): ServiceBuilderCommon

    /**
     * Configures the api key
     *
     * @param apiKey The api key for your application
     * @return ServiceBuilderCommon ServiceBuilderCommon instance
     */
    func setApiKey(apiKey: String): ServiceBuilderCommon

    /**
     * Configures the api secret
     *
     * @param apiSecret The api secret for your application
     * @return ServiceBuilderCommon ServiceBuilderCommon instance
     */
    func setApiSecret(apiSecret: String): ServiceBuilderCommon

    /**
     * Configures the api secret as "" (empty string).
     *
     * Used usually for a test environments or another strange cases. Not all providers support empty string as api key
     * and will throw an Exception in such cases.
     *
     * @return ServiceBuilderCommon ServiceBuilderCommon instance
     */
    func setApiSecretIsEmptyStringUnsafe(): ServiceBuilderCommon

    /**
     * Configures the HttpClientConfig
     *
     * @param httpClientConfig The Http Client Config
     * @return ServiceBuilderCommon ServiceBuilderCommon instance
     */
    func setHttpClientConfig(httpClientConfig: Option<HttpClientConfig>): ServiceBuilderCommon

    /**
     * Configures the HttpClient , takes precedence over httpClientConfig
     *
     * @param httpClient externally created HTTP client
     * @return ServiceBuilderCommon ServiceBuilderCommon instance
     */
    func setHttpClient(httpClient: Option<HttpClient>): ServiceBuilderCommon

    /**
     * Configures the HttpClientProvider
     *
     * @param httpClientProvider The Http Client Provider
     * @return ServiceBuilderCommon ServiceBuilderCommon instance
     */
    func setHttpClientProvider(httpClientProvider: Option<HttpClientProvider>): ServiceBuilderCommon

    /**
     * Configures the userAgent
     *
     * @param userAgent The user Agent
     * @return ServiceBuilderCommon ServiceBuilderCommon instance
     */
    func setUserAgent(userAgent: String): ServiceBuilderCommon
}

