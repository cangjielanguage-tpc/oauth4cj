/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights reserved.
 */

/**
 * @file The file declars the OkHttpHttpClientConfig class.
 */
package httpclient

/**
 * OkHttpHttpClient config class.
 */
public class OkHttpHttpClientConfig <: HttpClientConfig {

    private let clientBuilder: OkHttpClientBuilder

    /**
     * Create a OkHttpHttpClientConfig instance according to the parameter.
     *
     * @param clientBuilder of OkHttpClientBuilder, the Builder for OkHttpClient.
     * @since 0.38.2
     */
    public init(clientBuilder: OkHttpClientBuilder) {
        this.clientBuilder = clientBuilder
    }

    /**
     * get the OkHttpClientBuilder.
     *
     * @Return OkHttpClientBuilder the Builder for OkHttpClient.
     * @since 0.38.2
     */
    public func getClientBuilder(): OkHttpClientBuilder {
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
        /* OkHttpClient.builder() is OkHttpClientBuilder */
        return OkHttpHttpClientConfig(OkHttpClient.builder())
    }
}
