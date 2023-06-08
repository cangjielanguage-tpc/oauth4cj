/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights reserved.
 */

/**
 * @file The file declars the HttpClientProvider interface.
 */
package httpclient

/**
 * Provide HttpClient based on HttpClient configuration.
 */
public interface HttpClientProvider {

    /**
     * Create HttpClient based on HttpClient configuration.
     *
     * @Param the HttpClient configuration
     *
     * @Return Option<HttpClient> Create HttpClient based on HttpClient configuration, return it.
     * @since 0.38.2
     */
    func createClient(httpClientConfig: HttpClientConfig): Option<HttpClient>
}
