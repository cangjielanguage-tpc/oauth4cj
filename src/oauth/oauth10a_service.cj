/**
 * Copyright (c) Cangjie Library Team 2023-2023. All rights resvered.
 */

package oauth

from std import fs.*

import httpclient.multipart.*

public class OAuth10aService <: OAuthService {
    private static let VERSION: String = "1.0"
    private var api: DefaultApi10a
    private var scope: Option<String> = Option<String>.None
    private var httpClientProvider: Option<HttpClientProvider> = Option<HttpClientProvider>.None

    /**
     * Create OAuth10aService instance.
     *
     * @param api DefaultApi10a instance
     * @param apiKey api key
     * @param apiSecret api secret
     * @param callbackUrl callback url
     * @param scope scope string
     * @param debugStream debug mode outputstream, set Option<OutputStream>.None when not in use
     * @param userAgent user agent
     * @param httpClientConfig Http Client Config
     * @param httpClient HTTP Client instance
     * @param httpClientProvider HTTP Client Provider instance
     */
    public init(api: DefaultApi10a, apiKey: String, apiSecret: String, callbackUrl: Option<String>, scope: Option<String>,
            debugStream: Option<OutputStream>, userAgent: String, httpClientConfig: Option<HttpClientConfig>,
            httpClient: Option<HttpClient>, httpClientProvider: Option<HttpClientProvider>) {
        super(apiKey, apiSecret, callbackUrl, debugStream, userAgent, httpClientConfig, httpClient, httpClientProvider)
        this.api = api
        this.scope = scope
    }
    
    /**
     * Get OAuth1RequestToken instance
     *
     * @return OAuth1RequestToken OAuth1RequestToken instance
     * @exception OAuth4cjException If an exception occurs during the request process, throw it
     */
    public func getRequestToken(): OAuth1RequestToken {
        if (isDebug()) {
            log("obtaining request token from ${api.getRequestTokenEndpoint()}")
        }
        let request: OAuth4cjRequest  = prepareRequestTokenRequest()
        log("sending request...")
        try {
            let response: Response = execute(request)
            if (isDebug()) {
                let body: String = response.getBody()
                log("response status code: ${response.getCode()}")
                log("response body: ${body}")
            }
            return api.getRequestTokenExtractor().extract(response)
        } catch (ex: Exception) {
            throw OAuth4cjException("An exception occurred during the request process: " + ex.message)
        }
    }

    /**
     * Asynchronous acquisition of OAuth1RequestToken instance
     *
     * @return Future<OAuth1RequestToken> Future<OAuth1RequestToken> instance
     */
    public func getRequestTokenAsync(): Future<OAuth1RequestToken> {
        return getRequestTokenAsync(Option<OAuthAsyncRequestCallback>.None)
    }

    /**
     * Asynchronous acquisition of OAuth1RequestToken instance
     *
     * @param callback OAuthAsyncRequestCallback instance
     * @return Future<OAuth1RequestToken> Future<OAuth1RequestToken> instance
     */
    public func getRequestTokenAsync(callback: Option<OAuthAsyncRequestCallback>): Future<OAuth1RequestToken> {
        if (isDebug()) {
            log("async obtaining request token from ${api.getRequestTokenEndpoint()}")
        }
        let request: OAuth4cjRequest = prepareRequestTokenRequest()
        let defaultConverter: DefaultRequestTokenConverter = DefaultRequestTokenConverter(api)
        let res: Future<Any> = execute(request, callback, Some(defaultConverter))
        let newFuture: Future<OAuth1RequestToken> = spawn {
            let result = res.get()
            let token: Option<OAuth1RequestToken> = result as OAuth1RequestToken
            match(token) {
                case Some(v) => return v
                case None =>
                    let err: String = "Exception in parsing OAuth1RequestToken," + 
                        "response is: ${defaultConverter.responseString}"
                    let ex: Exception = (result as Exception) ?? OAuth4cjException(err)
                    throw OAuth4cjException(ex.message)
            }
        }
        return newFuture
    }

    protected func prepareRequestTokenRequest(): OAuth4cjRequest {
        var request: OAuth4cjRequest = OAuth4cjRequest(api.getRequestTokenVerb(), api.getRequestTokenEndpoint())

        let callback: String = getCallback() ?? OAuthConstants.OOB

        if (isDebug()) {
            log("setting oauth_callback to ${callback}")
        }
        request.addOAuthParameter(OAuthConstants.CALLBACK, callback)
        addOAuthParams(request, "")
        appendSignature(request)
        return request
    }

    protected func addOAuthParams(request: OAuth4cjRequest, tokenSecret: String): Unit {
        request.addOAuthParameter(OAuthConstants.TIMESTAMP, api.getTimestampService().getTimestampInSeconds())
        request.addOAuthParameter(OAuthConstants.NONCE, api.getTimestampService().getNonce())
        request.addOAuthParameter(OAuthConstants.CONSUMER_KEY, getApiKey())
        request.addOAuthParameter(OAuthConstants.SIGN_METHOD, api.getSignatureService().getSignatureMethod())
        request.addOAuthParameter(OAuthConstants.VERSION, getVersion())
        match(scope) {
            case Some(v) => request.addOAuthParameter(OAuthConstants.SCOPE, v)
            case None => ()
        }

        request.addOAuthParameter(OAuthConstants.SIGNATURE, getSignature(request, tokenSecret))
        if (isDebug()) {
            log("appended additional OAuth parameters: ${request.getOauthParameters()}")
        }
    }
    
    /**
     * Get OAuth1AccessToken instance
     *
     * @param requestToken OAuth1RequestToken instance
     * @param oauthVerifier oauth verifier string
     * @return OAuth1AccessToken OAuth1AccessToken instance
     */
    public func getAccessToken(requestToken: OAuth1RequestToken, oauthVerifier: String): OAuth1AccessToken {
        if (isDebug()) {
            log("obtaining access token from ${api.getAccessTokenEndpoint()}")
        }
        let request: OAuth4cjRequest  = prepareAccessTokenRequest(requestToken, oauthVerifier)
        try {
            let response: Response = execute(request)
            return api.getAccessTokenExtractor().extract(response)
        } catch (ex: Exception) {
            throw OAuth4cjException("An exception occurred during the request process: " + ex.message)
        }
    }

    /**
     * Asynchronous acquisition of OAuth1AccessToken instance
     *
     * @param requestToken OAuth1RequestToken instance
     * @param oauthVerifier oauth verifier string
     * @return Future<OAuth1AccessToken> Future<OAuth1AccessToken> instance
     */
    public func getAccessTokenAsync(requestToken: OAuth1RequestToken, oauthVerifier: String): 
        Future<OAuth1AccessToken> {
        return getAccessTokenAsync(requestToken, oauthVerifier, Option<OAuthAsyncRequestCallback>.None)
    }

    /**
     * Start the request to retrieve the access token. 
     * The optionally provided callback will be called with the Token when it is available.
     *
     * @param requestToken request token (obtained previously or null)
     * @param oauthVerifier oauth_verifier
     * @param callback OAuthAsyncRequestCallback instance
     * @return Future<OAuth1AccessToken> Future<OAuth1AccessToken> instance
     */
    public func getAccessTokenAsync(requestToken: OAuth1RequestToken, oauthVerifier: String,
        callback: Option<OAuthAsyncRequestCallback>): Future<OAuth1AccessToken> {
        if (isDebug()) {
            log("async obtaining access token from ${api.getAccessTokenEndpoint()}")
        }
        let request: OAuth4cjRequest = prepareAccessTokenRequest(requestToken, oauthVerifier)
        let defaultConverter: DefaultAccessTokenConverter = DefaultAccessTokenConverter(api)
        let res: Future<Any> = execute(request, callback, Some(defaultConverter))

        let newFuture: Future<OAuth1AccessToken> = spawn {
            let result = res.get()
            let token: Option<OAuth1AccessToken> = result as OAuth1AccessToken
            match(token) {
                case Some(v) => return v
                case None =>
                    let err: String = "Exception in parsing OAuth1AccessToken," + 
                        "response is: ${defaultConverter.responseString}"
                    let ex: Exception = (result as Exception) ?? OAuth4cjException(err)
                    throw OAuth4cjException(ex.message)
            }
        }
        return newFuture
    }

    protected func prepareAccessTokenRequest(requestToken: OAuth1RequestToken, oauthVerifier: String): 
        OAuth4cjRequest {
        var request: OAuth4cjRequest = OAuth4cjRequest(api.getAccessTokenVerb(), api.getAccessTokenEndpoint())
        request.addOAuthParameter(OAuthConstants.TOKEN, requestToken.getToken())
        request.addOAuthParameter(OAuthConstants.VERIFIER, oauthVerifier)
        if (isDebug()) {
            let logMessages = Array<String>([requestToken.getToken(), oauthVerifier])
            log("setting token to: %s and verifier to: ", logMessages)
        }
        addOAuthParams(request, requestToken.getTokenSecret())
        appendSignature(request)
        return request
    }

    /**
     * Sign request
     *
     * @param token OAuth1AccessToken instance
     * @param request OAuth4cjRequest instance
     */
    public func signRequest(token: OAuth1AccessToken, request: OAuth4cjRequest): Unit {
        if (isDebug()) {
            log("signing request: ${request.getCompleteUrl()}")
        }

        if (!token.isEmpty() || api.isEmptyOAuthTokenParamIsRequired()) {
            request.addOAuthParameter(OAuthConstants.TOKEN, token.getToken())
        }
        if (isDebug()) {
            log("setting token to: ${token.getToken()}")
        }
        addOAuthParams(request, token.getTokenSecret())
        appendSignature(request)
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
     * Returns the URL where you should redirect your users to authenticate your application.
     *
     * @param requestToken the request token you need to authorize
     * @return the URL where you should redirect your users
     */
    public func getAuthorizationUrl(requestToken: OAuth1RequestToken): String {
        return api.getAuthorizationUrl(requestToken)
    }

    private func getSignature(request: OAuth4cjRequest, tokenSecret: String): String {
        log("generating signature...")
        let baseString: String = api.getBaseStringExtractor().extract(request)
        let signature: String = api.getSignatureService().getSignature(baseString, getApiSecret(), tokenSecret)

        if (isDebug()) {
            log("base string is: ${baseString}")
            log("signature is: ${signature}")
        }
        return signature
    }

    protected func appendSignature(request: OAuth4cjRequest): Unit {
        let signatureType: OAuth1SignatureType = api.getSignatureType()
        match (signatureType) {
            case HEADER_SIGNATURE =>
                log("using Http Header signature")
                let oauthHeader: String = api.getHeaderExtractor().extract(request)
                request.addHeader(OAuthConstants.HEADER_AUTHORIZATION, oauthHeader)
            case QUERY_STRING_SIGNATURE =>
                log("using Querystring signature")
                let oauthParameters = request.getOauthParameters()
                for ((key, value) in oauthParameters) {
                    request.addQuerystringParameter(key, value)
                }
        }
    }

    /**
     * Get Api instance
     *
     * @return DefaultApi10a DefaultApi10a instance
     */
    public func getApi(): DefaultApi10a {
        return api
    }
}

class DefaultRequestTokenConverter <: ResponseConverter {
    private let defaultApi10a: DefaultApi10a
    protected var responseString: String = ""

    public init(defaultApi10a: DefaultApi10a) {
        this.defaultApi10a = defaultApi10a
    }

    public func convert(response: Response): OAuth1RequestToken {
        responseString = response.toString()
        let token: OAuth1RequestToken = defaultApi10a.getRequestTokenExtractor().extract(response)
        response.close()
        return token
    }
}

class DefaultAccessTokenConverter <: ResponseConverter {
    private let defaultApi10a: DefaultApi10a
    protected var responseString: String = ""

    public init(defaultApi10a: DefaultApi10a) {
        this.defaultApi10a = defaultApi10a
    }

    public func convert(response: Response): OAuth1AccessToken {
        responseString = response.toString()
        let token: OAuth1AccessToken = defaultApi10a.getAccessTokenExtractor().extract(response)
        response.close()
        return token
    }
}

