/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights reserved.
 * Description:
 */

/**
 * @file The file declars the RSASha1SignatureService class.
 */
package services

from std import collection.*

from crypto4cj import rsacj.*
from crypto4cj import digestcj.*
from crypto4cj import sha1cj.*

/**
 * RSA-SHA1 implementation of the SignatureService interface.
 * A signature service that uses the RSA-SHA1 algorithm.
 */
public class RSASha1SignatureService <: SignatureService {

    private static let METHOD: String = "RSA-SHA1"

    //private key file path
    private let privateKey: String

    /**
     * Create a RSASha1SignatureService instance according to the parameter.
     *
     * @param private key file path, the file must be in .pem format
     * @since 0.38.2
     */
    public init(privateKey: String) {
        this.privateKey = privateKey
    }

    /**
     * Return the signature.
     *
     * @Param the url encoding string to sign
     * @Param in the subclass RSASha1SignatureService, this parameter is not used
     * @Param in the subclass RSASha1SignatureService, this parameter is not used
     *
     * @Return String the signature
     * @throws OAuth4cjSignatureException failed to obtain signature
     */
    public func getSignature(baseString: String, apiSecret: String, tokenSecret: String): String {
        try {
            let md: Array<UInt8> = Array<UInt8>(SHA_DIGEST_LENGTH, item: 0)
            let data: Array<UInt8> = baseString.toUtf8Array()
            var digest: Array<UInt8> = Digest.digest(DigestType.sha1, data)
            let rsa: RSAPrivateKey = RSA.readPriKeyfromFile(privateKey)
            let signArray: Array<UInt8> = RSA.sign(DigestType.sha1, digest, rsa)
            if (signArray.size == 0) {
                throw OAuth4cjSignatureException("RSA-SHA1 algorithm signature failed.")
            }

            return Base64Utils.encode(signArray)
        } catch (e: Exception) {
            throw OAuth4cjSignatureException(baseString + ": " + e.message)
        }
    }

    /**
     * Return the signature method name.
     *
     * @Return String the signature method name.
     */
    public func getSignatureMethod(): String {
        return METHOD
    }
}
