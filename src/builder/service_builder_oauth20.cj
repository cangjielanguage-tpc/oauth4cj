/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights reserved.
 */
package builder

import oauth.DefaultApi20
import oauth.OAuth20Service

/**
 * Service Builder OAuth20
 */
public interface ServiceBuilderOAuth20 <: ServiceBuilderCommon {

    /**
     * Configures the Response Type
     *
     * @param responseType Response Type String
     * @return ServiceBuilderOAuth20 ServiceBuilderOAuth20 instance
     */
    func setResponseType(responseType: String): ServiceBuilderOAuth20

    /**
     * Configures the default OAuth 2.0 scope.<br>
     *
     * You can request any uniq scope per each access token request using
     * {@link com.github.scribejava.core.oauth.AuthorizationUrlBuilder#scope(java.lang.String) }.<br><br>
     *
     * In case you're requesting always the same scope,<br>
     * you can just set it here and do not provide scope param nowhere more.
     *
     * @param defaultScope The OAuth scope, used as deafult
     * @return ServiceBuilderOAuth20 ServiceBuilderOAuth20 instance
     */
    func setDefaultScope(defaultScope: String): ServiceBuilderOAuth20

    /**
     * Configures the default OAuth 2.0 scope.<br>
     *
     * @param scopeBuilder The OAScopeBuilderuth instance
     * @return ServiceBuilderOAuth20 ServiceBuilderOAuth20 instance
     */
    func setDefaultScope(scopeBuilder: ScopeBuilder): ServiceBuilderOAuth20

    /**
     * Build OAuth20Service instance
     *
     * @param api The DefaultApi20 instance
     * @return OAuth20Service OAuth20Service instance
     */
    func build(api: DefaultApi20): OAuth20Service
}

