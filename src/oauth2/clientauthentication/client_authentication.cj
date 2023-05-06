/**
 * Copyright (c) Cangjie Library Team 2023-2023. All rights resvered.
 */

package oauth2.clientauthentication

import model.OAuth4cjRequest

/**
 * Client Authentication, RFC 6749 2.3.2
 * just implement this interface to implement "2.3.2. Other Authentication Methods"
 */
public interface ClientAuthentication {
    func addClientAuthentication(request: OAuth4cjRequest, apiKey: String, apiSecret: String): Unit
}

