/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights resvered.
 */

/**
 * @file The file declars the HttpClientConfig interface.
 */
package oauth4cj

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
