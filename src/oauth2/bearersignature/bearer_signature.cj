/**
 * Copyright (c) Cangjie Library Team 2023-2023. All rights resvered.
 */

package oauth2.bearersignature

import model.OAuth4cjRequest

/**
 * Bearer Signature interface
 */
public interface BearerSignature {
    func signRequest(accessToken: String, request: OAuth4cjRequest): Unit
}

