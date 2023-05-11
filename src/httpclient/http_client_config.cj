/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights reserved.
 */

/**
 * @file The file declars the HttpClientConfig interface.
 */
package httpclient

/**
 * HttpClient config interface.
 */
public interface HttpClientConfig {

    /**
     * Return the HttpClientConfig.
     *
     * @Return HttpClientConfig the HttpClient config
     * @since 0.38.2
     */
    func createDefaultConfig(): HttpClientConfig
}
