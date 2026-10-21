package oauth4cj


/**
 * Bearer Signature interface
 */
public interface BearerSignature {
    func signRequest(accessToken: String, request: OAuth4cjRequest): Unit
}

