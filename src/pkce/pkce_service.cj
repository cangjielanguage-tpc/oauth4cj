/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights reserved.
 * Description:
 */

/**
 * @file The file declars the PKCEService class.
 */
package pkce

from std import random.*

/**
 * Used to implement Proof Key for Code Exchange by OAuth Public Clients.
 */
public class PKCEService {

    private static let RANDOM: Random = Random()
    private static let DEFAULT_NUM: Int32 = 32

    /**
     * number of octets to randomly generate.
     */
    private let numberOFOctets: Int32
    
    /**
     * Create a PKCEService instance according to the parameter.
     *
     * @param umberOFOctets of Int32
     * @since 0.38.2
     */
    public init(numberOFOctets: Int32) {
        this.numberOFOctets = numberOFOctets
    }

    /**
     * Create a PKCEService instance.
     * will create random generator with recommended params (32 octets).
     *
     * @since 0.38.2
     */
    public init() {
        this(DEFAULT_NUM)
    }
    
    /**
     * Return a new PKCEService instance.
     *
     * @return Type of PKCEService
     * @since 0.38.2
     */
    public static func defaultInstance(): PKCEService {
        return PKCEService()
    }
    
    /**
     * Generate a new PKCE instance.
     *
     * @return Type of PKCE
     * @since 0.38.2
     */
    public func generatePKCE(): PKCE {
        let bytes: Array<UInt8> = Array<UInt8>(Int64(numberOFOctets), item: 0)
        setArrayByRandom(bytes)
        return generatePKCE(bytes)
    }

    private func setArrayByRandom(bytes: Array<UInt8>): Unit {
        RANDOM.setSeed(UInt64(numberOFOctets))
        for (i in 0..bytes.size) {
            bytes[i] = RANDOM.nextUInt8()
        }
    }
    
    /**
     * Generate a new PKCE instance according to the parameter.
     *
     * @param randomBytes of Array<UInt8>
     *
     * @return Type of PKCE
     * @since 0.38.2
     */
    public func generatePKCE(randomBytes: Array<UInt8>): PKCE {
        let codeVerifier: String = Base64Utils.encodeUrlWithoutPadding(randomBytes)
    
        let pkce: PKCE = PKCE()
        pkce.setCodeVerifier(codeVerifier)
        try {
            pkce.setCodeChallenge(pkce.getCodeChallengeMethod().transform2CodeChallenge(codeVerifier))
        } catch (nsaE: Exception) {
            pkce.setCodeChallengeMethod(PKCECodeChallengeMethod.PLAIN)
            try {
                pkce.setCodeChallenge(PKCECodeChallengeMethod.PLAIN.transform2CodeChallenge(codeVerifier))
            } catch (unrealE: Exception) {
                throw OAuth4cjException("It's just cannot be" + unrealE.message)
            }
        }
        return pkce
    }
}
