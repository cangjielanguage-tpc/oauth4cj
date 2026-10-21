/**
 * @file The file declars the BaseStringExtractorImpl class.
 */
package oauth4cj

/**
 * The default implementation of the BaseStringExtractor interface. Compliant with OAuth 1.0a
 */
public class BaseStringExtractorImpl <: BaseStringExtractor {

    private static let AMPERSAND_SEPARATED_STRING: String = "%s&%s&%s"

    /**
     * Extract a basic URL encoded string from OAuth4cjRequest.
     *
     * @Param the OAuth4cjRequest
     *
     * @Return String a basic URL encoded string
     */
    public func extract(request: OAuth4cjRequest): String {
        checkPreconditions(request)
        let verb: String = OAuthEncoder.encode(getVerb(request))
        let url: String = OAuthEncoder.encode(getUrl(request))
        let params: String = getSortedAndEncodedParams(request)
        return verb + "&" + url + "&" +params
    }

    protected func getVerb(request: OAuth4cjRequest): String {
        return request.getVerb().toString()
    }

    protected func getUrl(request: OAuth4cjRequest): String {
        return request.getSanitizedUrl()
    }

    protected func getSortedAndEncodedParams(request: OAuth4cjRequest): String {
        let params: ParameterList = ParameterList()
        params.addAll(request.getQueryStringParams())
        params.addAll(request.getBodyParams())
        params.addAll(ParameterList(request.getOauthParameters()))
        return params.sort().asOauthBaseString()
    }

    protected func checkPreconditions(request: OAuth4cjRequest): Unit {
        if (request.getOauthParameters().size <= 0) {
            throw OAuth4cjParametersMissingException(request.toString())
        }
    }
}
