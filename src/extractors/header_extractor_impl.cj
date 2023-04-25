/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights reserved.
 * Description:
 */

/**
 * @file The file declars the HeaderExtractorImpl class.
 */
package extractors

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
                    .append("=\"")
                    .append(OAuthEncoder.encode(v))
                    .append('"')
        }

        if (!request.getRealm().isEmpty()) {
            header.append(PARAM_SEPARATOR)
                    .append(OAuthConstants.REALM)
                    .append("=\"")
                    .append(request.getRealm())
                    .append('"')
        }
        return header.toString()
    }

    private func checkPreconditions(request: OAuth4cjRequest): Unit {
        if (request.getOauthParameters().size <= 0) {
            throw OAuth4cjParametersMissingException(request.toString())
        }
    }
}
