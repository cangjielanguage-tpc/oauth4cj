/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights reserved.
 */

/**
 * @file The file declars the OkHttpProvider class.
 */
package httpclient

from okhttp import okhttp.*

/**
 * Provide HttpClient based on HttpClient configuration.
 */
public class OkHttpProvider <: HttpClientProvider {

    /**
     * Create HttpClient based on HttpClient configuration.
     *
     * @Param the HttpClient configuration
     *
     * @Return Option<HttpClient> Create HttpClient based on HttpClient configuration, return it;
     *                            If config is not of type OkHttpHttpClientConfig, return None.
     * @since 0.38.2
     */
    public func createClient(config: HttpClientConfig): Option<HttpClient> {
        if (config is OkHttpHttpClientConfig) {
            return OkHttpHttpClient((config as OkHttpHttpClientConfig).getOrThrow())
        }
        return None
    }
}
