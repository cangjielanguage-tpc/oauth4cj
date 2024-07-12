/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights resvered.
 */

/**
 * @file The file declars the  PlaintextSignatureService class.
 */
package oauth4cj


/**
 * plaintext implementation of the SignatureService interface
 */
public class PlaintextSignatureService <: SignatureService {

    private static let METHOD: String = "PLAINTEXT"

    /**
     * Return the signature.
     *
     * @Param Partial information in the exception thrown when obtaining the signature fails
     * @Param your application api Secret
     * @Param Token Secret (empty string of request token step)
     *
     * @Return String the signature
     * @throws OAuth4cjSignatureException failed to obtain signature
     */
    public func getSignature(baseString: String, apiSecret: String, tokenSecret: String): String {
        try {
            return OAuthEncoder.encode(apiSecret) + "&" + OAuthEncoder.encode(tokenSecret)
        } catch (e: Exception) {
            throw OAuth4cjSignatureException(e.message)
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
