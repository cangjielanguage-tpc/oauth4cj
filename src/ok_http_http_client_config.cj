/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights resvered.
 */

/**
 * @file The file declars the OkHttpHttpClientConfig class.
 */
package oauth4cj

/**
 * OkHttpHttpClient config class.
 */
public class OkHttpHttpClientConfig <: HttpClientConfig {

    private let clientBuilder: HttpClientBuilder

    /**
     * Create a OkHttpHttpClientConfig instance according to the parameter.
     *
     * @param clientBuilder of HttpClientBuilder, the Builder for HttpClient.
     * @since 0.38.2
     */
    public init(clientBuilder: HttpClientBuilder) {
        this.clientBuilder = clientBuilder
    }

    /**
     * get the HttpClientBuilder.
     *
     * @Return HttpClientBuilder the Builder for HttpClient.
     * @since 0.38.2
     */
    public func getClientBuilder(): HttpClientBuilder {
        return this.clientBuilder
    }
    
    /**
     * Generate default OkHttpHttpClientConfig and return it.生成默认的OkHttpHttpClientConfig并返回
     *
     * @Return OkHttpHttpClientConfig generate default the OkHttpHttpClient config.
     * @since 0.38.2
     */
    public func createDefaultConfig(): OkHttpHttpClientConfig {
        return defaultConfig()
    }

    /**
     * Generate default OkHttpHttpClientConfig and return it.生成默认的OkHttpHttpClientConfig并返回
     *
     * @Return OkHttpHttpClientConfig generate default the OkHttpHttpClient config.
     * @since 0.38.2
     */
    public static func defaultConfig(): OkHttpHttpClientConfig {
        /* Httpclient4cjHttpClient.builder() is HttpClientBuilder */
        return OkHttpHttpClientConfig(Httpclient4cjHttpClient.builder())
    }
}
