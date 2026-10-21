/**
 * @file The file declars the BaseStringExtractor interface.
 */
package oauth4cj

/**
 * A simple command object for extracting basic strings from OAuth4cjRequest.
 */
public interface BaseStringExtractor {

    /**
     * Extract a basic URL encoded string from OAuth4cjRequest.
     *
     * @Param the OAuth4cjRequest
     *
     * @Return String a basic URL encoded string
     */
    func extract(request: OAuth4cjRequest): String
}
