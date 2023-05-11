/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights reserved.
 */
package builder

import oauth.DefaultApi10a
import oauth.OAuth10aService

/**
 * ServiceBuilderOAuth10a
 */
public interface ServiceBuilderOAuth10a <: ServiceBuilderCommon {

    /**
     * Configures the OAuth 1.0a scope. This is only necessary in some APIs
     *
     * @param scope The OAuth scope
     * @return ServiceBuilderOAuth10a ServiceBuilderOAuth10a instance
     */
    func withScope(scope: String): ServiceBuilderOAuth10a

    /**
     * Build OAuth10aService instance
     *
     * @param api The DefaultApi10a instance
     * @return OAuth10aService OAuth10aService instance
     */
    func build(api: DefaultApi10a): OAuth10aService
}

