package model

public class OAuthConstants {

    public static let TIMESTAMP: String = "oauth_timestamp"
    public static let SIGN_METHOD: String = "oauth_signature_method"
    public static let SIGNATURE: String = "oauth_signature"
    public static let CONSUMER_SECRET: String = "oauth_consumer_secret"
    public static let CONSUMER_KEY: String = "oauth_consumer_key"
    public static let CALLBACK: String = "oauth_callback"
    public static let VERSION: String = "oauth_version"
    public static let NONCE: String = "oauth_nonce"
    public static let REALM: String = "realm"
    public static let PARAM_PREFIX: String = "oauth_"
    public static let TOKEN: String = "oauth_token"
    public static let TOKEN_SECRET: String = "oauth_token_secret"
    public static let VERIFIER: String = "oauth_verifier"
    public static let HEADER_AUTHORIZATION: String = "Authorization"
    public static let SCOPE: String = "scope"
    public static let BASIC: String = "Basic"

    // OAuth 1.0
    /**
     * to indicate an out-of-band configuration
     */
    public static let OOB: String = "oob"

    // OAuth 2.0
    public static let ACCESS_TOKEN: String = "access_token"
    public static let CLIENT_ID: String = "client_id"
    public static let CLIENT_SECRET: String = "client_secret"
    public static let REDIRECT_URI: String = "redirect_uri"
    public static let CODE: String = "code"
    public static let REFRESH_TOKEN: String = "refresh_token"
    public static let GRANT_TYPE: String = "grant_type"
    public static let AUTHORIZATION_CODE: String = "authorization_code"
    public static let CLIENT_CREDENTIALS: String = "client_credentials"
    public static let STATE: String = "state"
    public static let USERNAME: String = "username"
    public static let PASSWORD: String = "password"
    public static let RESPONSE_TYPE: String = "response_type"
    public static let RESPONSE_TYPE_CODE: String = "code"

    // not OAuth specific
    public static let USER_AGENT_HEADER_NAME: String = "User-Agent"
}