/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights reserved.
 */

/**
 * @file The file declars the OkHttpHttpClientConfig class.
 */
package httpclient

/**
 * OkHttpClient config interface.
 */
public class OkHttpHttpClientConfig <: HttpClientConfig {

    private let clientBuilder: OkHttpClientBuilder

    public init(clientBuilder: OkHttpClientBuilder) {
        this.clientBuilder = clientBuilder
    }

    public func getClientBuilder(): OkHttpClientBuilder {
        return this.clientBuilder
    }
    
    public func createDefaultConfig(): OkHttpHttpClientConfig {
        return defaultConfig()
    }

    public static func defaultConfig(): OkHttpHttpClientConfig {
        /* OkHttpClient.builder() is OkHttpClientBuilder */
        return OkHttpHttpClientConfig(OkHttpClient.builder())
    }
}
