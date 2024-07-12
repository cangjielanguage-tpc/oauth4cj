/**
 * Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights resvered.
 */

package oauth4cj


/**
 * Bearer Signature interface
 */
public interface BearerSignature {
    func signRequest(accessToken: String, request: OAuth4cjRequest): Unit
}

