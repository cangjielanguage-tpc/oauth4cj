/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights reserved.
 */
package apis

public class HuaweiApi <: DefaultApi20 {

    protected init() { }

    /**
     * Returns the access token extractor.
     *
     * @return access token extractor
     */
    public static func instance(): HuaweiApi {
        return HuaweiApi()
    }

    /**
     * Returns the verb for the access token endpoint (defaults to POST)
     * Return request type.
     *
     * @return access token endpoint verb
     */
    public func getAccessTokenVerb(): Verb {
        return Verb.POST
    }

    /**
     * Returns the URL that receives the access token requests.
     *
     * @return access token URL
     */
    public func getAccessTokenEndpoint(): String {
        return "https://oauth-login.cloud.huawei.com/oauth2/v3/token"
    }

    //Return to authorization link.
    protected func getAuthorizationBaseUrl(): String {
        return "https://oauth-login.cloud.huawei.com/oauth2/v3/authorize"
    }

    /**
     * Returns ClientAuthentication instance.
     * Client authentication:
     * Write "client_id" and "client_secret" and their corresponding key value pair information in the request body.
     *
     * @return ClientAuthentication ClientAuthentication instance
     */
    public func getClientAuthentication(): ClientAuthentication {
        return RequestBodyAuthenticationScheme.instance()
    }

    /**
     * Returns BearerSignature instance.
     * Bearer signature URI query parameter: When requesting signature,
     *          add the query parameter "access_token" and its corresponding key value pair information.
     *
     * @return BearerSignature BearerSignature instance
     */
    public func getBearerSignature(): BearerSignature {
        return BearerSignatureURIQueryParameter.instance()
    }
}
