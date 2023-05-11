/**
 * Copyright (c) Cangjie Library Team 2023-2023. All rights resvered.
 */

package oauth

from std import io.OutputStream

import model.Closeable
import httpclient.HttpClientConfig
import httpclient.HttpClient

public open class OAuthService <: Closeable {

    public init(apiKey: String, apiSecret: String, callback: String, debugStream: Option<OutputStream>,
            userAgent: String, httpClientConfig: Option<HttpClientConfig>, httpClient: Option<HttpClient>) {
    }
}

