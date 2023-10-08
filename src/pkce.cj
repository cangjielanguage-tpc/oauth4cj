/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights reserved.
 * Description:
 */

/**
 * @file The file declars the PKCE class.
 */
package oauth4cj

from std import collection.*

/**
 * hold code_challenge, code_challenge_method and code_verifier.
 */
public class PKCE {

    public static let PKCE_CODE_CHALLENGE_METHOD_PARAM: String = "code_challenge_method"
    public static let PKCE_CODE_CHALLENGE_PARAM: String = "code_challenge"
    public static let PKCE_CODE_VERIFIER_PARAM: String = "code_verifier"
    
    private var codeChallenge: String = ""
    private var codeChallengeMethod: PKCECodeChallengeMethod = PKCECodeChallengeMethod.S256
    private var codeVerifier: String = ""

    /**
     * Create a PKCE instance.
     *
     * @since 0.38.2
     */
    public init() {}
    
    /**
     * Get the codeChallenge value.
     *
     * @return Type of String
     * @since 0.38.2
     */
    public func getCodeChallenge(): String {
        return codeChallenge
    }
    
    /**
     * Set the codeChallenge value.
     *
     * @param codeChallenge of String
     * @since 0.38.2
     */
    public func setCodeChallenge(codeChallenge: String): Unit {
        this.codeChallenge = codeChallenge
    }
    
    /**
     * Get the codeChallengeMethod value.
     *
     * @return Type of PKCECodeChallengeMethod
     * @since 0.38.2
     */
    public func getCodeChallengeMethod(): PKCECodeChallengeMethod {
        return codeChallengeMethod
    }
    
    /**
     * Set the codeChallengeMethod value.
     *
     * @param codeChallengeMethod of PKCECodeChallengeMethod
     * @since 0.38.2
     */
    public func setCodeChallengeMethod(codeChallengeMethod: PKCECodeChallengeMethod): Unit {
        this.codeChallengeMethod = codeChallengeMethod
    }
    
    /**
     * Get the codeVerifier value.
     *
     * @return Type of String
     * @since 0.38.2
     */
    public func getCodeVerifier(): String {
        return codeVerifier
    }
    
    /**
     * Set the codeVerifier value.
     *
     * @param codeVerifier of String
     * @since 0.38.2
     */
    public func setCodeVerifier(codeVerifier: String): Unit {
        this.codeVerifier = codeVerifier
    }
    
    /**
     * Create a HashMap<String, String> instance,
     * put the code_challenge and code_challenge_method key value pairs to it.
     *
     * @return Type of HashMap<String, String>
     * @since 0.38.2
     */
    public func getAuthorizationUrlParams(): HashMap<String, String> {
        let params: HashMap<String, String> = HashMap<String, String>()
        params.put(PKCE_CODE_CHALLENGE_PARAM, codeChallenge)
        params.put(PKCE_CODE_CHALLENGE_METHOD_PARAM, codeChallengeMethod.toString())
        return params
    }
}
