/**
 * @file The file declars the HeaderExtractorImpl class.
 */
package oauth4cj

/**
 * The default implementation of the HeaderExtractor interface. Compliant with OAuth 1.0a
 */
public class HeaderExtractorImpl <: HeaderExtractor {

    private static let PARAM_SEPARATOR: String = ", "
    private static let PREAMBLE: String = "OAuth "

    /**
     * Generate an OAuth "Authorization" HTTP header as a signature to include in the request.
     *
     * @Param check the request and generate the header
     *
     * @Return String the Http header value
     */
    public func extract(request: OAuth4cjRequest): String {
        checkPreconditions(request)
        let parameters: HashMap<String, String> = request.getOauthParameters()

        let header: StringBuilder = StringBuilder(PREAMBLE)

        for ((k, v) in parameters) {
            if (header.size > PREAMBLE.size) {
                header.append(PARAM_SEPARATOR)
            }
            header.append(k)
            header.append("=\"")
            header.append(OAuthEncoder.encode(v))
            header.append('"')
        }

        if (!request.getRealm().isEmpty()) {
            header.append(PARAM_SEPARATOR)
            header.append(OAuthConstants.REALM)
            header.append("=\"")
            header.append(request.getRealm())
            header.append('"')
        }
        return header.toString()
    }

    private func checkPreconditions(request: OAuth4cjRequest): Unit {
        if (request.getOauthParameters().size <= 0) {
            throw OAuth4cjParametersMissingException(request.toString())
        }
    }
}
