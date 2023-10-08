/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights reserved.
 * Description:
 */

/**
 * @file The file declars the HMACSha1SignatureService class.
 */
package oauth4cj

from crypto4cj import hmaccj.*


/**
 * HMAC-SHA1 implementation of the SignatureService interface
 */
public class HMACSha1SignatureService <: SignatureService {

    private static let EMPTY_STRING: String = ""
    private static let CARRIAGE_RETURN: String = "\r\n"
    private static let METHOD: String = "HMAC-SHA1"

    /**
     * Return the signature.
     *
     * @Param the url encoding string to sign
     * @Param your application api Secret
     * @Param Token Secret (empty string of request token step)
     *
     * @Return String the signature
     * @throws OAuth4cjSignatureException failed to obtain signature
     */
    public func getSignature(baseString: String, apiSecret: String, tokenSecret: String): String {
        try {
            Preconditions.checkEmptyString(baseString, "Base string can't be null or empty string")
            return doSign(baseString, OAuthEncoder.encode(apiSecret) + '&' + OAuthEncoder.encode(tokenSecret))
        } catch (e: Exception) {
            throw OAuth4cjSignatureException(baseString + ": " + e.message)
        }
    }

    private func doSign(toSign: String, keyString: String): String {
        let algorithm: AlgorithmType = AlgorithmType.Sha1
        let key: Array<UInt8> = keyString.toUtf8Array()
        let data: Array<UInt8> = toSign.toUtf8Array()
        let md: Array<UInt8> = Array<UInt8>(Int64(AlgorithmType.Sha1.getBits()), item: 0)

        hmac(algorithm, key, data, md)
        return Base64Utils.encode(md).replace(CARRIAGE_RETURN, EMPTY_STRING)
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
