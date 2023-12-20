/**
 * Copyright (c) Cangjie Library Team 2023-2023. All rights resvered.
 */

package oauth4cj

from std import sync.*
from std import time.*

/**
 * OAuth 2.0 Service
 */
public class OAuth20Service <: OAuthService {
    private static let VERSION: String = "2.0"
    private var api: DefaultApi20
    private var responseType: String
    private var defaultScope: Option<String> = None
    private var httpClientProvider: Option<HttpClientProvider> = Option<HttpClientProvider>.None

    /**
     * Create OAuth20Service instance according to the parameters.
     *
     * @param api of DefaultApi20 instance
     * @param apiKey of String, api key
     * @param apiSecret of String, api secret
     * @param callbackUrl of String, callback url
     * @param defaultScope of Option<String>, default scope
     * @param responseType of String, response type
     * @param debugStream of Option<OutputStream>, debug mode outputstream, None when not in use
     * @param userAgent of String, user agent
     * @param httpClientConfig of Option<HttpClientConfig>, Http Client Config
     * @param httpClient of Option<HttpClient>, Http Client instance
     * @param httpClientProvider of Option<HttpClientProvider>, Http Client provider
     */
    public init(api: DefaultApi20, apiKey: String, apiSecret: String, callbackUrl: Option<String>, defaultScope: Option<String>,
            responseType: String, debugStream: Option<OutputStream>, userAgent: String, 
            httpClientConfig: Option<HttpClientConfig>, httpClient: Option<HttpClient>,
            httpClientProvider: Option<HttpClientProvider>) {
        super(apiKey, apiSecret, callbackUrl, debugStream, userAgent, httpClientConfig, httpClient, httpClientProvider)
        this.responseType = responseType
        this.api = api
        this.defaultScope = defaultScope
    }

    /**
     * Get version
     *
     * @return String version string
     */
    public func getVersion(): String {
        return VERSION
    }

    /**
     * Sign request
     *
     * @param accessToken of String
     * @param request of OAuth4cjRequest, OAuth4cjRequest instance
     */
    public func signRequest(accessToken: String, request: OAuth4cjRequest): Unit {
        api.getBearerSignature().signRequest(accessToken, request)
    }

    /**
     * Sign request
     *
     * @param accessToken of OAuth2AccessToken, OAuth2AccessToken instance
     * @param request of OAuth4cjRequest, OAuth4cjRequest instance
     */
    public func signRequest(accessToken: OAuth2AccessToken, request: OAuth4cjRequest): Unit {
        signRequest(accessToken.getAccessToken(), request)
    }

    /**
     * Return the URL that should redirect the user to verify the application.
     *
     * @return String the user's URL should be redirected
     */
    public func getAuthorizationUrl(): String {
        return build(this, None, HashMap<String, String>(), None, None)
    }

    /**
     * Return the URL that should redirect the user to verify the application.
     *
     * @param state of String, status value
     *
     * @return String the user's URL should be redirected
     */
    public func getAuthorizationUrl(state: Option<String>): String {
        return build(this, state, HashMap<String, String>(), None, None)
    }

    /**
     * Return the URL that should redirect the user to verify the application.
     *
     * @param additionalParams of HashMap<String, String>, any other GET parameters to add to the URL.
     *
     * @return String the user's URL should be redirected
     */
    public func getAuthorizationUrl(additionalParams: HashMap<String, String>): String {
        return build(this, None, additionalParams, None, None)
    }

    /**
     * Return the URL that should redirect the user to verify the application.
     *
     * @param pkce of PKCE, PKCE instance.
     *
     * @return String the user's URL should be redirected
     */
    public func getAuthorizationUrl(pkce: Option<PKCE>): String {
        return build(this, None, HashMap<String, String>(), pkce, None)
    }

    /**
     * Get api
     *
     * @return DefaultApi20 the DefaultApi20 instance
     */
    public func getApi(): DefaultApi20 {
        return api
    }

    /**
     * extract authorization.
     *
     * @param redirectLocation of String, redirect location.
     *
     * @return OAuth2Authorization the OAuth2 authorization
     */
    public func extractAuthorization(redirectLocation: String): OAuth2Authorization {
        let authorization: OAuth2Authorization = OAuth2Authorization()
        var end: Int64 = redirectLocation.indexOf("#") ?? -1
        if (end == -1) {
            end = redirectLocation.size
        }
        let start: Int64 = (redirectLocation.indexOf("?") ?? -1) + 1
        let subStr: String = redirectLocation[start..end]
        let params: Array<String> = subStr.split("&")
        for (param in params) {
            let keyValue: Array<String> = param.split("=")
            if (keyValue.size == 2) {
                try {
                    if (keyValue[0] == "code") {
                        authorization.setCode(URLEncoder.decode(keyValue[1], "UTF-8"))
                    } else if (keyValue[0] == "state") {
                        authorization.setState(URLEncoder.decode(keyValue[1], "UTF-8"))
                    }
                } catch (ueE: Exception) {
                    throw OAuth4cjException("unsupported decoding. " + ueE.message)
                }
            }
        }
        return authorization
    }

    /**
     * get responseType.
     *
     * @return String response type
     */
    public func getResponseType(): String {
        return responseType
    }

    /**
     * get defaultScope.
     *
     * @return Option<String> default scope
     */
    public func getDefaultScope(): Option<String> {
        return defaultScope
    }

    protected func logRequestWithParams(requestDescription: String, request: OAuth4cjRequest): Unit {
        if (isDebug()) {
            let body: String = request.getBodyParams().asFormUrlEncodedString()
            let query: String = request.getQueryStringParams().asFormUrlEncodedString()
            log("created ${requestDescription} request with body params [${body}], query string params [${query}]")
        }
    }

    protected func sendAccessTokenRequestSync(request: OAuth4cjRequest): OAuth2AccessToken {
        if (isDebug()) {
            log("send request for access token synchronously to ${request.getCompleteUrl()}")
        }

        let response: OAuth4cjResponse = execute(request)
        if (isDebug()) {
            log("response status code: ${response.getCode()}")
            log("response body: ${response.getBody()}")
        }

        return api.getAccessTokenExtractor().extract(response)
    }

    //protected to facilitate mocking.
    protected func sendAccessTokenRequestAsync(request: OAuth4cjRequest): Future<OAuth2AccessToken> {
        return sendAccessTokenRequestAsync(request, None)
    }

    //protected to facilitate mocking.
    protected func sendAccessTokenRequestAsync(request: OAuth4cjRequest,
            callback: Option<OAuthAsyncRequestCallback>): Future<OAuth2AccessToken> {
        if (isDebug()) {
            log("send request for access token asynchronously to ${request.getCompleteUrl()}")
        }

        let rc: ResponseConverterOAuth2AccessToken = ResponseConverterOAuth2AccessToken(api)
        let res: Future<Any> = execute(request, callback, Some(rc))

        let nowFuture: Future<OAuth2AccessToken> = spawn {
            let result = res.get()
            let token: Option<OAuth2AccessToken> = result as OAuth2AccessToken
            match(token) {
                case Some(v) => return v
                case None =>
                    let err: String = "Exception in parsing OAuth2AccessToken, response is: ${rc.responseString}"
                    let ex: Exception = (result as Exception) ?? OAuth4cjException(err)
                    throw OAuth4cjException(ex.message)
            }
        }
        return nowFuture
    }


    // ===== get AccessToken authorisation code flow methods =====
    protected func createAccessTokenRequest(params: AccessTokenRequestParams): OAuth4cjRequest {
        let request: OAuth4cjRequest = OAuth4cjRequest(api.getAccessTokenVerb(), api.getAccessTokenEndpoint())

        api.getClientAuthentication().addClientAuthentication(request, getApiKey(), getApiSecret())

        request.addParameter(OAuthConstants.CODE, params.getCode())

        let callback: Option<String> = getCallback()
        match(callback) {
            case Some(v) => request.addParameter(OAuthConstants.REDIRECT_URI, v)
            case None => ()
        }

        let scope: Option<String> = params.getScope()
        match(scope) {
            case Some(v) => request.addParameter(OAuthConstants.SCOPE, v)
            case None =>
                    match(defaultScope) {
                        case Some(val) => request.addParameter(OAuthConstants.SCOPE, val)
                        case None => ()
                    }
        }
        request.addParameter(OAuthConstants.GRANT_TYPE, OAuthConstants.AUTHORIZATION_CODE)

        let pkceCodeVerifier: Option<String> = params.getPkceCodeVerifier()
        match(pkceCodeVerifier) {
            case Some(v) => request.addParameter(PKCE.PKCE_CODE_VERIFIER_PARAM, v)
            case None => ()
        }

        let extraParameters: HashMap<String, String> = params.getExtraParameters()
        if (!extraParameters.isEmpty()) {
            for ((k, v) in extraParameters) {
                request.addParameter(k, v)
            }
        }

        logRequestWithParams("access token", request)
        return request
    }

    /**
     * Asynchronous acquisition of OAuth2AccessToken.
     *
     * @param code of String, the authorization code
     *
     * @return Future<OAuth2AccessToken> asynchronously obtain the return value of OAuth2AccessToken.
     */
    public func getAccessTokenAsync(code: String): Future<OAuth2AccessToken> {
        return getAccessToken(AccessTokenRequestParams.create(code), None)
    }

    /**
     * Asynchronous acquisition of OAuth2AccessToken.
     *
     * @param params of AccessTokenRequestParams, the access token request params
     *
     * @return Future<OAuth2AccessToken> asynchronously obtain the return value of OAuth2AccessToken.
     */
    public func getAccessTokenAsync(params: AccessTokenRequestParams): Future<OAuth2AccessToken> {
        return getAccessToken(params, None)
    }

    /**
     * get the OAuth2AccessToken.
     *
     * @param code of String, the authorization code
     *
     * @return OAuth2AccessToken return the OAuth2AccessToken.
     */
    public func getAccessToken(code: String): OAuth2AccessToken {
        return getAccessToken(AccessTokenRequestParams.create(code))
    }

    /**
     * get the OAuth2AccessToken.
     *
     * @param params of AccessTokenRequestParams, the access token request params
     *
     * @return OAuth2AccessToken return the OAuth2AccessToken.
     */
    public func getAccessToken(params: AccessTokenRequestParams): OAuth2AccessToken {
        return sendAccessTokenRequestSync(createAccessTokenRequest(params))
    }

    /**
     * Initiate a request to retrieve the access token.
     * The optional callback provided will be called using the token when it is available.
     *
     * @param params of AccessTokenRequestParams, the access token request params
     * @param callback of Option<OAuthAsyncRequestCallback>, optional callback, the access async request callback
     *
     * @return Future<OAuth2AccessToken> asynchronously obtain the return value of OAuth2AccessToken.
     */
    public func getAccessToken(params: AccessTokenRequestParams,
            callback: Option<OAuthAsyncRequestCallback>): Future<OAuth2AccessToken> {
        return sendAccessTokenRequestAsync(createAccessTokenRequest(params), callback)
    }

    /**
     * Initiate a request to retrieve the access token.
     * The optional callback provided will be called using the token when it is available.
     *
     * @param code of String, the authorization code
     * @param callback of Option<OAuthAsyncRequestCallback>, optional callback, the access async request callback
     *
     * @return Future<OAuth2AccessToken> asynchronously obtain the return value of OAuth2AccessToken.
     */
    public func getAccessToken(code: String,
            callback: Option<OAuthAsyncRequestCallback>): Future<OAuth2AccessToken> {
        return getAccessToken(AccessTokenRequestParams.create(code), callback)
    }

    // ===== refresh AccessToken methods =====
    protected func createRefreshTokenRequest(refreshToken: String, scope: Option<String>): OAuth4cjRequest {
        if (refreshToken.isEmpty()) {
            throw IllegalArgumentException("The refreshToken cannot be null or empty")
        }
        let request: OAuth4cjRequest = OAuth4cjRequest(api.getAccessTokenVerb(), api.getRefreshTokenEndpoint())

        api.getClientAuthentication().addClientAuthentication(request, getApiKey(), getApiSecret())

        match(scope) {
            case Some(v) => request.addParameter(OAuthConstants.SCOPE, v)
            case None =>
                    match(defaultScope) {
                        case Some(val) => request.addParameter(OAuthConstants.SCOPE, val)
                        case None => ()
                    }
        }

        request.addParameter(OAuthConstants.REFRESH_TOKEN, refreshToken)
        request.addParameter(OAuthConstants.GRANT_TYPE, OAuthConstants.REFRESH_TOKEN)

        logRequestWithParams("refresh token", request)

        return request
    }

    /**
     * Asynchronous acquisition of refresh token.
     *
     * @param refreshToken of String, the refresh token
     *
     * @return Future<OAuth2AccessToken> retrieve the return value of the refresh token asynchronously.
     */
    public func refreshAccessTokenAsync(refreshToken: String): Future<OAuth2AccessToken> {
        return refreshAccessToken(refreshToken, Option<OAuthAsyncRequestCallback>.None)
    }

    /**
     * Asynchronous acquisition of refresh token.
     *
     * @param refreshToken of String, the refresh token
     * @param scope of String, the scope
     *
     * @return Future<OAuth2AccessToken> retrieve the return value of the refresh token asynchronously..
     */
    public func refreshAccessTokenAsync(refreshToken: String, scope: String): Future<OAuth2AccessToken> {
        return refreshAccessToken(refreshToken, scope, None)
    }

    /**
     * Obtain refresh token.
     *
     * @param refreshToken of String, the refresh token
     *
     * @return OAuth2AccessToken obtain refresh token.
     */
    public func refreshAccessToken(refreshToken: String): OAuth2AccessToken {
        return refreshAccessToken(refreshToken, "")
    }

    /**
     * Obtain refresh token.
     *
     * @param refreshToken of String, the refresh token
     * @param scope of String, the scope
     *
     * @return OAuth2AccessToken obtain refresh token.
     */
    public func refreshAccessToken(refreshToken: String, scope: String): OAuth2AccessToken {
        let request: OAuth4cjRequest = createRefreshTokenRequest(refreshToken, scope)

        return sendAccessTokenRequestSync(request)
    }

    /**
     * Asynchronous acquisition of refresh token.
     *
     * @param refreshToken of String, the refresh token
     * @param callback of Option<OAuthAsyncRequestCallback>, optional callback, the access async request callback
     *
     * @return Future<OAuth2AccessToken> retrieve the return value of the refresh token asynchronously.
     */
    public func refreshAccessToken(refreshToken: String,
            callback: Option<OAuthAsyncRequestCallback>): Future<OAuth2AccessToken> {
        let request: OAuth4cjRequest = createRefreshTokenRequest(refreshToken, None)

        return sendAccessTokenRequestAsync(request, callback)
    }

    /**
     * Asynchronous acquisition of refresh token.
     *
     * @param refreshToken of String, the refresh token
     * @param scope of String, the scope
     * @param callback of Option<OAuthAsyncRequestCallback>, optional callback, the access async request callback
     *
     * @return Future<OAuth2AccessToken> retrieve the return value of the refresh token asynchronously.
     */
    public func refreshAccessToken(refreshToken: String, scope: String,
            callback: Option<OAuthAsyncRequestCallback>): Future<OAuth2AccessToken> {
        let request: OAuth4cjRequest = createRefreshTokenRequest(refreshToken, scope)

        return sendAccessTokenRequestAsync(request, callback)
    }

    // ===== get AccessToken password grant flow methods =====
    protected func createAccessTokenPasswordGrantRequest(username: String, password: String, scope: Option<String>):
                    OAuth4cjRequest {
        let request: OAuth4cjRequest = OAuth4cjRequest(api.getAccessTokenVerb(), api.getAccessTokenEndpoint())
        request.addParameter(OAuthConstants.USERNAME, username)
        request.addParameter(OAuthConstants.PASSWORD, password)

        match(scope) {
            case Some(v) => request.addParameter(OAuthConstants.SCOPE, v)
            case None =>
                    match(defaultScope) {
                        case Some(val) => request.addParameter(OAuthConstants.SCOPE, val)
                        case None => ()
                    }
        }

        request.addParameter(OAuthConstants.GRANT_TYPE, OAuthConstants.PASSWORD)

        api.getClientAuthentication().addClientAuthentication(request, getApiKey(), getApiSecret())

        logRequestWithParams("access token password grant", request)

        return request
    }

    /**
     * Obtain OAuth2AccessToken token through password authorization mode.
     *
     * @param username of String, the user name
     * @param password of String, the password
     *
     * @return OAuth2AccessToken obtain OAuth2AccessToken.
     */
    public func getAccessTokenPasswordGrant(username: String, password: String): OAuth2AccessToken {
        let request: OAuth4cjRequest = createAccessTokenPasswordGrantRequest(username, password, None)

        return sendAccessTokenRequestSync(request)
    }

    /**
     * Obtain OAuth2AccessToken token through password authorization mode.
     *
     * @param username of String, the user name
     * @param password of String, the password
     * @param scope of String, the scope
     *
     * @return OAuth2AccessToken obtain OAuth2AccessToken.
     */
    public func getAccessTokenPasswordGrant(username: String, password: String, scope: String): OAuth2AccessToken {
        let request: OAuth4cjRequest = createAccessTokenPasswordGrantRequest(username, password, scope)

        return sendAccessTokenRequestSync(request)
    }

    /**
     * Asynchronously calling password mode to obtain OAuth2AccessToken。
     *
     * @param username User name
     * @param password User password
     * @return Future<OAuth2AccessToken>
     *         The return value after executing asynchronous call password mode to obtain OAuth2 access token.
     */
    public func getAccessTokenPasswordGrantAsync(username: String, password: String): Future<OAuth2AccessToken> {
        return getAccessTokenPasswordGrantAsync(username, password, None)
    }

    /**
     * Asynchronously calling password mode to obtain OAuth2AccessToken。
     *
     * @param username User name
     * @param password User password
     * @param scope of String, the scope
     * @return Future<OAuth2AccessToken>
     *         The return value after executing asynchronous call password mode to obtain OAuth2 access token.
     */
    public func getAccessTokenPasswordGrantAsync(username: String, password: String, scope: String):
                    Future<OAuth2AccessToken> {
        return getAccessTokenPasswordGrantAsync(username, password, scope, None)
    }

    /**
     * Asynchronously calling password mode to obtain OAuth2AccessToken。
     *
     * @param username User name
     * @param password User password
     * @param callback of Option<OAuthAsyncRequestCallback>, optional callback, the access async request callback
     * @return Future<OAuth2AccessToken>
     *         The return value after executing asynchronous call password mode to obtain OAuth2 access token.
     */
    public func getAccessTokenPasswordGrantAsync(username: String, password: String,
            callback: Option<OAuthAsyncRequestCallback>): Future<OAuth2AccessToken> {
        let request: OAuth4cjRequest = createAccessTokenPasswordGrantRequest(username, password, None)

        return sendAccessTokenRequestAsync(request, callback)
    }

    /**
     * Asynchronously calling password mode to obtain OAuth2AccessToken。
     *
     * @param username User name
     * @param password User password
     * @param scope of String, the scope
     * @param callback of Option<OAuthAsyncRequestCallback>, optional callback, the access async request callback
     * @return Future<OAuth2AccessToken>
     *         The return value after executing asynchronous call password mode to obtain OAuth2 access token.
     */
    public func getAccessTokenPasswordGrantAsync(username: String, password: String, scope: String,
            callback: Option<OAuthAsyncRequestCallback>): Future<OAuth2AccessToken> {
        let request: OAuth4cjRequest = createAccessTokenPasswordGrantRequest(username, password, scope)

        return sendAccessTokenRequestAsync(request, callback)
    }

    // ===== get AccessToken client credentials flow methods =====
    protected func createAccessTokenClientCredentialsGrantRequest(scope: Option<String>): OAuth4cjRequest {
        let request: OAuth4cjRequest = OAuth4cjRequest(api.getAccessTokenVerb(), api.getAccessTokenEndpoint())

        api.getClientAuthentication().addClientAuthentication(request, getApiKey(), getApiSecret())

        match(scope) {
            case Some(v) => request.addParameter(OAuthConstants.SCOPE, v)
            case None =>
                    match(defaultScope) {
                        case Some(val) => request.addParameter(OAuthConstants.SCOPE, val)
                        case None => ()
                    }
        }
        request.addParameter(OAuthConstants.GRANT_TYPE, OAuthConstants.CLIENT_CREDENTIALS)

        logRequestWithParams("access token client credentials grant", request)

        return request
    }

    /**
     * Asynchronous acquisition of OAuth2AccessToken token through client mode.
     *
     * @return Future<OAuth2AccessToken> returns the result of an asynchronous call.
     */
    public func getAccessTokenClientCredentialsGrantAsync(): Future<OAuth2AccessToken> {
        return getAccessTokenClientCredentialsGrant(Option<OAuthAsyncRequestCallback>.None)
    }

    /**
     * Asynchronous acquisition of OAuth2AccessToken token through client mode.
     *
     * @param scope of String, the scope
     *
     * @return Future<OAuth2AccessToken> returns the result of an asynchronous call.
     */
    public func getAccessTokenClientCredentialsGrantAsync(scope: String): Future<OAuth2AccessToken> {
        return getAccessTokenClientCredentialsGrant(scope, Option<OAuthAsyncRequestCallback>.None)
    }

    /**
     * Obtain OAuth2AccessToken token through client mode.
     *
     * @return OAuth2AccessToken returns the OAuth2AccessToken.
     */
    public func getAccessTokenClientCredentialsGrant(): OAuth2AccessToken {
        let request: OAuth4cjRequest = createAccessTokenClientCredentialsGrantRequest(None)

        return sendAccessTokenRequestSync(request)
    }

    /**
     * Obtain OAuth2AccessToken token through client mode.
     *
     * @param scope of String, the scope
     *
     * @return OAuth2AccessToken returns the OAuth2AccessToken.
     */
    public func getAccessTokenClientCredentialsGrant(scope: String): OAuth2AccessToken {
        let request: OAuth4cjRequest = createAccessTokenClientCredentialsGrantRequest(scope)

        return sendAccessTokenRequestSync(request)
    }

    /**
     * Initiate a request to retrieve an access token using client credentials.
     * The optional callback provided will be called using the token when it is available.
     *
     * @param callback of Option<OAuthAsyncRequestCallback>, optional callback, the access async request callback
     *
     * @return Future<OAuth2AccessToken> returns the result of an asynchronous call.
     */
    public func getAccessTokenClientCredentialsGrant(
            callback: Option<OAuthAsyncRequestCallback>): Future<OAuth2AccessToken> {
        let request: OAuth4cjRequest = createAccessTokenClientCredentialsGrantRequest(None)

        return sendAccessTokenRequestAsync(request, callback)
    }

    /**
     * Initiate a request to retrieve an access token using client credentials.
     * The optional callback provided will be called using the token when it is available.
     *
     * @param scope of String, the scope
     * @param callback of Option<OAuthAsyncRequestCallback>, optional callback, the access async request callback
     *
     * @return Future<OAuth2AccessToken> returns the result of an asynchronous call.
     */
    public func getAccessTokenClientCredentialsGrant(scope: String,
            callback: Option<OAuthAsyncRequestCallback>): Future<OAuth2AccessToken> {
        let request: OAuth4cjRequest = createAccessTokenClientCredentialsGrantRequest(scope)

        return sendAccessTokenRequestAsync(request, callback)
    }

    // ===== revoke AccessToken methods =====
    protected func createRevokeTokenRequest(tokenToRevoke: String, tokenTypeHint: Option<TokenTypeHint>):
                        OAuth4cjRequest {

        let request: OAuth4cjRequest = OAuth4cjRequest(Verb.POST, api.getRevokeTokenEndpoint())

        api.getClientAuthentication().addClientAuthentication(request, getApiKey(), getApiSecret())

        //The field name supported by Weibo is access_token
        if (api.getAccessTokenEndpoint().contains("weibo")) {
            request.addParameter("access_token", tokenToRevoke)
        } else {
            request.addParameter("token", tokenToRevoke)
        }

        match(tokenTypeHint) {
            case Some(v) => request.addParameter("token_type_hint", v.getValue())
            case None => ()
        }

        logRequestWithParams("revoke token", request)

        return request
    }

    /**
     * Asynchronous execution revocation token.
     *
     * @param tokenToRevoke of String, the token to revoke
     *
     * @return Future<Unit> asynchronous execution revocation token.
     */
    public func revokeTokenAsync(tokenToRevoke: String): Future<Unit> {
        return revokeTokenAsync(tokenToRevoke, None)
    }

    /**
     * Asynchronous execution revocation token.
     *
     * @param tokenToRevoke of String, the token to revoke
     * @param tokenTypeHint of Option<TokenTypeHint>, the type of token to revoke
     *
     * @return Future<Unit> asynchronous execution revocation token.
     */
    public func revokeTokenAsync(tokenToRevoke: String, tokenTypeHint: Option<TokenTypeHint>): Future<Unit> {
        return revokeToken(tokenToRevoke, None, tokenTypeHint)
    }

    /**
     * revocation token.
     *
     * @param tokenToRevoke of String, the token to revoke.
     */
    public func revokeToken(tokenToRevoke: String): Unit {
        revokeToken(tokenToRevoke, Option<TokenTypeHint>.None)
    }

    /**
     * revocation token.
     *
     * @param tokenToRevoke of String, the token to revoke
     * @param tokenTypeHint of Option<TokenTypeHint>, the type of token to revoke
     */
    public func revokeToken(tokenToRevoke: String, tokenTypeHint: Option<TokenTypeHint>): Unit {
        let request: OAuth4cjRequest = createRevokeTokenRequest(tokenToRevoke, tokenTypeHint)

        try (response: OAuth4cjResponse = execute(request)) {
            checkForErrorRevokeToken(response)
        }
    }

    /**
     * Asynchronous execution revocation token.
     *
     * @param tokenToRevoke of String, the token to revoke
     * @param callback of Option<OAuthAsyncRequestCallback>, optional callback, the access async request callback
     *
     * @return Future<Unit> asynchronous execution revocation token.
     */
    public func revokeToken(tokenToRevoke: String, callback: Option<OAuthAsyncRequestCallback>): Future<Unit> {
        return revokeToken(tokenToRevoke, callback, None)
    }

    /**
     * Asynchronous execution revocation token.
     *
     * @param tokenToRevoke of String, the token to revoke
     * @param callback of Option<OAuthAsyncRequestCallback>, optional callback, the access async request callback
     * @param tokenTypeHint of Option<TokenTypeHint>, the type of token to revoke
     *
     * @return Future<Unit> asynchronous execution revocation token.
     */
    public func revokeToken(tokenToRevoke: String, callback: Option<OAuthAsyncRequestCallback>,
            tokenTypeHint: Option<TokenTypeHint>): Future<Unit> {
        let request: OAuth4cjRequest = createRevokeTokenRequest(tokenToRevoke, tokenTypeHint)

        let rc: ResponseConverterRevokeToken = ResponseConverterRevokeToken()
        let res: Future<Any> = execute(request, callback, Some(rc))

        let nowFuture: Future<Unit> = spawn {
            let result = res.get()

            func insideGet(): Exception {
                let err: String = "Exception in parsing Unit, response is: ${rc.responseString}"
                let ex: Exception = (result as Exception) ?? OAuth4cjException(err)
                return OAuth4cjException(ex.message)
            }

            let revokeToken: Option<ResponseConverterRevokeToken> = result as ResponseConverterRevokeToken
            revokeToken.getOrThrow(insideGet)
            return ()
        }
        return nowFuture
    }

    protected func createDeviceAuthorizationCodesRequest(scope: Option<String>): OAuth4cjRequest {
        let request: OAuth4cjRequest = OAuth4cjRequest(Verb.POST, api.getDeviceAuthorizationEndpoint())
        request.addParameter(OAuthConstants.CLIENT_ID, getApiKey())

        match(scope) {
            case Some(v) => request.addParameter(OAuthConstants.SCOPE, v)
            case None =>
                    match(defaultScope) {
                        case Some(val) => request.addParameter(OAuthConstants.SCOPE, val)
                        case None => ()
                    }
        }

        //Github's device authorization code mode can only parse JSON structures
        if (api.getAccessTokenEndpoint().contains("github") && !(responseType == "code")) {
            request.addHeader("Accept", responseType)
        }

        logRequestWithParams("Device Authorization Codes", request)

        return request
    }

    /**
     * Requesting a set of verification codes from an authorization server with default scope.
     *
     * @return DeviceAuthorization device authorization response.
     */
    public func getDeviceAuthorizationCodes(): DeviceAuthorization {
        return getDeviceAuthorizationCodes(Option<String>.None)
    }

    /**
     * Requesting a set of verification codes from an authorization server with default scope.
     *
     * @param scope of Option<String>, the scope
     *
     * @return DeviceAuthorization device authorization response.
     */
    public func getDeviceAuthorizationCodes(scope: Option<String>): DeviceAuthorization {
        let request: OAuth4cjRequest = createDeviceAuthorizationCodesRequest(scope)

        let response: OAuth4cjResponse = execute(request)
        if (isDebug()) {
            log("got DeviceAuthorizationCodes response")
            log("response status code: ${response.getCode()}")
            log("response body: ${response.getBody()}")
        }
        return api.getDeviceAuthorizationExtractor().extract(response)
    }

    /**
     * Asynchronous execution to obtain device authorization code.
     *
     * @param callback of Option<OAuthAsyncRequestCallback>, optional callback, the access async request callback
     *
     * @return Future<DeviceAuthorization> asynchronous execution revocation token.
     */
    public func getDeviceAuthorizationCodes(
            callback: Option<OAuthAsyncRequestCallback>): Future<DeviceAuthorization> {
        return getDeviceAuthorizationCodes(Option<String>.None, callback)
    }

    /**
     * Asynchronous execution to obtain device authorization code.
     *
     * @param scope of Option<String>, the scope
     * @param callback of Option<OAuthAsyncRequestCallback>, optional callback, the access async request callback
     *
     * @return Future<DeviceAuthorization> asynchronous execution revocation token.
     */
    public func getDeviceAuthorizationCodes(scope: Option<String>,
            callback: Option<OAuthAsyncRequestCallback>): Future<DeviceAuthorization> {
        let request: OAuth4cjRequest = createDeviceAuthorizationCodesRequest(scope)

        let rc: ResponseConverterDeviceAuthorization = ResponseConverterDeviceAuthorization(api)
        let res: Future<Any> = execute(request, callback, Some(rc))

        let nowFuture: Future<DeviceAuthorization> = spawn {
            let result = res.get()
            let deviceAuthorization: Option<DeviceAuthorization> = result as DeviceAuthorization
            match(deviceAuthorization) {
                case Some(v) => return v
                case None =>
                    let err: String = "Exception in parsing DeviceAuthorization, response is: ${rc.responseString}"
                    let ex: Exception = (result as Exception) ?? OAuth4cjException(err)
                    throw OAuth4cjException(ex.message)
            }
        }
        return nowFuture
    }

    /**
     * Asynchronous execution to obtain device authorization code.
     *
     * @return Future<DeviceAuthorization> asynchronous execution revocation token.
     */
    public func getDeviceAuthorizationCodesAsync(): Future<DeviceAuthorization> {
        return getDeviceAuthorizationCodesAsync(None)
    }

    /**
     * Asynchronous execution to obtain device authorization code.
     *
     * @param scope of Option<String>, the scope
     *
     * @return Future<DeviceAuthorization> asynchronous execution revocation token.
     */
    public func getDeviceAuthorizationCodesAsync(scope: Option<String>): Future<DeviceAuthorization> {
        return getDeviceAuthorizationCodes(scope, None)
    }

    // ===== get AccessToken Device Authorisation grant flow methods =====
    protected func createAccessTokenDeviceAuthorizationGrantRequest(deviceAuthorization: DeviceAuthorization):
                    OAuth4cjRequest {
        let request: OAuth4cjRequest = OAuth4cjRequest(api.getAccessTokenVerb(), api.getAccessTokenEndpoint())

        if (api.getAccessTokenEndpoint().contains("huawei")) {//for huawei
            request.addParameter(OAuthConstants.GRANT_TYPE, "device_code")
            request.addParameter("code", deviceAuthorization.getDeviceCode())
        } else {
            request.addParameter(OAuthConstants.GRANT_TYPE, "urn:ietf:params:oauth:grant-type:device_code")
            request.addParameter("device_code", deviceAuthorization.getDeviceCode())
        }

        api.getClientAuthentication().addClientAuthentication(request, getApiKey(), getApiSecret())
        return request
    }

    /**
     * Obtaining device authorization codes through device authorization.
     *
     * @param deviceAuthorization of DeviceAuthorization, the device authorization response
     *
     * @return OAuth2AccessToken return the OAuth2AccessToken.
     */
    public func getAccessTokenDeviceAuthorizationGrant(deviceAuthorization: DeviceAuthorization): OAuth2AccessToken {
        let request: OAuth4cjRequest = createAccessTokenDeviceAuthorizationGrantRequest(deviceAuthorization)

        let response: OAuth4cjResponse = execute(request)
        if (isDebug()) {
            log("got AccessTokenDeviceAuthorizationGrant response")
            log("response status code: ${response.getCode()}")
            log("response body: ${response.getBody()}")
        }
        return api.getAccessTokenExtractor().extract(response)
    }

    /**
     * Asynchronous execution to obtain device authorization code.
     *
     * @param deviceAuthorization of DeviceAuthorization, the device authorization response
     * @param callback of Option<OAuthAsyncRequestCallback>, optional callback, the access async request callback
     *
     * @return Future<DeviceAuthorization> asynchronous execution revocation token.
     */
    public func getAccessTokenDeviceAuthorizationGrant(deviceAuthorization: DeviceAuthorization,
            callback: Option<OAuthAsyncRequestCallback>): Future<OAuth2AccessToken> {
        let request: OAuth4cjRequest = createAccessTokenDeviceAuthorizationGrantRequest(deviceAuthorization)

        let rc: ResponseConverterOAuth2AccessToken = ResponseConverterOAuth2AccessToken(api)
        let res: Future<Any> = execute(request, callback, Some(rc))

        let nowFuture: Future<OAuth2AccessToken> = spawn {
            let result = res.get()
            let token: Option<OAuth2AccessToken> = result as OAuth2AccessToken
            match(token) {
                case Some(v) => return v
                case None =>
                    let err: String = "Exception in parsing OAuth2AccessToken, response is: ${rc.responseString}"
                    let ex: Exception = (result as Exception) ?? OAuth4cjException(err)
                    throw OAuth4cjException(ex.message)
            }
        }
        return nowFuture
    }

    /**
     * Asynchronous execution to obtain device authorization code.
     *
     * @param deviceAuthorization of DeviceAuthorization, the device authorization response
     *
     * @return Future<DeviceAuthorization> asynchronous execution revocation token.
     */
    public func getAccessTokenDeviceAuthorizationGrantAsync(
            deviceAuthorization: DeviceAuthorization): Future<OAuth2AccessToken> {
        return getAccessTokenDeviceAuthorizationGrant(deviceAuthorization, None)
    }

    /**
     * Obtain device authorization code (waiting for user consent). Only synchronize versions.
     *
     * @param deviceAuthorization of DeviceAuthorization, the device authorization response
     *
     * @return OAuth2AccessToken return the OAuth2AccessToken.
     */
    public func pollAccessTokenDeviceAuthorizationGrant(deviceAuthorization: DeviceAuthorization): OAuth2AccessToken {
        var intervalMillis: Int64 = Int64(deviceAuthorization.getIntervalSeconds()) * 1000
        while (true) {
            try {
                return getAccessTokenDeviceAuthorizationGrant(deviceAuthorization)
            } catch (e: OAuth2AccessTokenErrorResponseException) {
                var err: String = ""
                var flag: Bool = false
                let error: Option<OAuth2Error> = e.getError()
                match(error) {
                    case Some(v) =>
                            err = v.getErrorString()
                            flag = true
                    case None => ()
                }

                if (flag && err != OAuth2Error.AUTHORIZATION_PENDING.getErrorString()) {
                    if (flag && err == OAuth2Error.SLOW_DOWN.getErrorString()) {
                        intervalMillis += 5000
                    } else {
                        throw e
                    }
                }
            }
            sleep(intervalMillis * Duration.nanosecond)
        }
        return OAuth2AccessToken("")
    }
}

func checkForErrorRevokeToken(response: OAuth4cjResponse): Unit {
    if (response.getCode() != 200) {
        OAuth2AccessTokenJsonExtractor.instance().generateError(response)
    }
}


class ResponseConverterRevokeToken <: ResponseConverter {

    protected var responseString: String = ""
    init(){}
    public func convert(response: OAuth4cjResponse): ResponseConverterRevokeToken {
        checkForErrorRevokeToken(response)
        this.responseString = response.toString()
        response.close()
        return this
    }
}

class ResponseConverterDeviceAuthorization <: ResponseConverter {

    private let api: DefaultApi20
    protected var responseString: String = ""

    init(api: DefaultApi20){
        this.api = api
    }
    public func convert(response: OAuth4cjResponse): DeviceAuthorization {
        let deviceAuth: DeviceAuthorization = api.getDeviceAuthorizationExtractor().extract(response)
        this.responseString = response.toString()
        response.close()
        return deviceAuth
    }
}

class ResponseConverterOAuth2AccessToken <: ResponseConverter {

    private let api: DefaultApi20
    protected var responseString: String = ""

    init(api: DefaultApi20){
        this.api = api
    }

    public func convert(response: OAuth4cjResponse): OAuth2AccessToken {
        let accessToken: OAuth2AccessToken = api.getAccessTokenExtractor().extract(response)
        this.responseString = response.toString()
        response.close()
        return accessToken
    }
}

