/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights resvered.
 */
package oauth4cj

/**
 * AccessToken Request Params
 */
public class AccessTokenRequestParams {

    private var code: String = ""
    private var pkceCodeVerifier: Option<String> = None
    private var scope: Option<String> = None
    private var extraParameters: HashMap<String, String> = HashMap<String, String>()

    /**
     * Create AccessTokenRequestParams instance.
     *
     * @param code request state code
     */
    public init(code: String) {
        this.code = code
    }

    /**
     * Create AccessTokenRequestParams instance.
     *
     * @param code request state code
     * @return AccessTokenRequestParams AccessTokenRequestParams instance
     */
    public static func create(code: String): AccessTokenRequestParams {
        return AccessTokenRequestParams(code)
    }

    /**
     * Set pkceCodeVerifier instance.
     *
     * @param pkceCodeVerifier pkce code verifier
     * @return AccessTokenRequestParams AccessTokenRequestParams instance
     */
    public func setPKCECodeVerifier(pkceCodeVerifier: String): AccessTokenRequestParams {
        this.pkceCodeVerifier = Some(pkceCodeVerifier)
        return this
    }

    /**
     * Set Scope
     *
     * @param scope scope string
     * @return AccessTokenRequestParams AccessTokenRequestParams instance
     */
    public func setScope(scope: String): AccessTokenRequestParams {
        this.scope = Some(scope)
        return this
    }

    /**
     * Set Scope
     *
     * @param scope ScopeBuilder instance
     * @return AccessTokenRequestParams AccessTokenRequestParams instance
     */
    public func setScope(scope: ScopeBuilder): AccessTokenRequestParams {
        this.scope = Some(scope.build())
        return this
    }

    /**
     * Add Extra Parameters.
     *
     * @param extraParameters extra parameters map
     * @return AccessTokenRequestParams AccessTokenRequestParams instance
     */
    public func addExtraParameters(extraParameters: HashMap<String, String>): AccessTokenRequestParams {
        if (extraParameters.isEmpty()) {
            return this
        }
        this.extraParameters.putAll(extraParameters)
        return this
    }

    /**
     * Add Extra OAuth4cjParameter.
     *
     * @param name parameter name
     * @param value parameter value
     * @return AccessTokenRequestParams AccessTokenRequestParams instance
     */
    public func addExtraParameter(name: String, value: String): AccessTokenRequestParams {
        this.extraParameters.put(name, value)
        return this
    }

    /**
     * Set Extra Parameters.
     *
     * @param extraParameters extra parameters map
     * @return AccessTokenRequestParams AccessTokenRequestParams instance
     */
    public func setExtraParameters(extraParameters: HashMap<String, String>): AccessTokenRequestParams {
        this.extraParameters = extraParameters
        return this
    }

    /**
     * Get Extra Parameters.
     *
     * @return HashMap<String, String> extra parameters map
     */
    public func getExtraParameters(): HashMap<String, String> {
        return extraParameters
    }

    /**
     * Get Code
     *
     * @return String request state code
     */
    public func getCode(): String {
        return code
    }

    /**
     * Get pkceCodeVerifier instance.
     *
     * @return String pkce code verifier String
     */
    public func getPkceCodeVerifier(): Option<String> {
        return pkceCodeVerifier
    }

    /**
     * Get String
     *
     * @return String scope string
     */
    public func getScope(): Option<String> {
        return scope
    }
}

