/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights reserved.
 */
package oauth4cj

/*
 * Build Authorization Url
 */
public class AuthorizationUrlBuilder {

    private let oauth20Service: OAuth20Service
    private var state: Option<String> = Option<String>.None
    private var additionalParams: HashMap<String, String> = HashMap<String, String>()
    private var pkce: Option<PKCE> = Option<PKCE>.None
    private var scope: Option<String> = Option<String>.None

    /**
     * Create AuthorizationUrlBuilder instance.
     *
     * @param oauth20Service OAuth20Service instance
     */
    public init(oauth20Service: OAuth20Service) {
        this.oauth20Service = oauth20Service
    }

    /**
     * Set State
     *
     * @param state state string
     * @return AuthorizationUrlBuilder AuthorizationUrlBuilder instance
     */
    public func setState(state: Option<String>): AuthorizationUrlBuilder {
        this.state = state
        return this
    }

    /**
     * Set Additional Params.
     *
     * @param additionalParams additional params map
     * @return AuthorizationUrlBuilder AuthorizationUrlBuilder instance
     */
    public func setAdditionalParams(additionalParams: HashMap<String, String>): AuthorizationUrlBuilder {
        this.additionalParams = additionalParams
        return this
    }

    /**
     * Set PKCE
     *
     * @param pkce Option<PKCE> instance
     * @return AuthorizationUrlBuilder AuthorizationUrlBuilder instance
     */
    public func setPkce(pkce: Option<PKCE>): AuthorizationUrlBuilder {
        this.pkce = pkce
        return this
    }

    /**
     * Initialize PKCE
     *
     * @return AuthorizationUrlBuilder AuthorizationUrlBuilder instance
     */
    public func initPKCE(): AuthorizationUrlBuilder {
        this.pkce = PKCEService.defaultInstance().generatePKCE()
        return this
    }

    /**
     * Set Scope
     *
     * @param scope scope string
     * @return AuthorizationUrlBuilder AuthorizationUrlBuilder instance
     */
    public func setScope(scope: Option<String>): AuthorizationUrlBuilder {
        this.scope = scope
        return this
    }

    /**
     * Get PKCE
     *
     * @return Option<PKCE> Option<PKCE> instance
     */
    public func getPkce(): Option<PKCE> {
        return pkce
    }

    /**
     * Build AuthorizationUrl String
     *
     * @return String Authorization Url String
     */
    public func build(): String {
        build(oauth20Service, state, additionalParams, pkce, scope)
    }
}

func build(oauth20Service: OAuth20Service, state: Option<String>,
                additionalParams: HashMap<String, String>, pkce: Option<PKCE>, scope: Option<String>): String {
    var params: HashMap<String, String>
    match (pkce) {
        case Some(x) =>
            params = HashMap<String, String>(additionalParams)
            params.add(all: x.getAuthorizationUrlParams())
        case _ => params = additionalParams
    }

    let scopeBuild: Option<String> = scope ?? oauth20Service.getDefaultScope()

    return oauth20Service.getApi().getAuthorizationUrl(oauth20Service.getResponseType(), oauth20Service.getApiKey(),
            oauth20Service.getCallback(), scopeBuild, state, params)
}

