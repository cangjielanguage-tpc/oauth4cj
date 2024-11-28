/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights reserved.
 */

/**
 * @file The file declars the SignatureService interface.
 */
package oauth4cj

/**
 * Sign the base string and return OAuth signature.
 */
public interface SignatureService {

    /**
     * Return the signature.
     *
     * @Param the url encoding string to sign
     * @Param your application api Secret
     * @Param Token Secret (empty string of request token step)
     *
     * @Return String the signature
     */
    func getSignature(baseString: String, apiSecret: String, tokenSecret: String): String

    /**
     * Return the signature method name.
     *
     * @Return String the signature method name.
     */
    func getSignatureMethod(): String
}
