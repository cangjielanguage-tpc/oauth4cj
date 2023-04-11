/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights resvered.
 */

/**
 * @file The file declars the MultipartPayload class.
 */
package httpclient.multipart

let DEFAULT_CONTENT_TYPE: String = "application/x-www-form-urlencoded"
let CONTENT_TYPE: String = "Content-Type"
let CONTENT_LENGTH: String = "Content-Length"

public class MultipartPayload <: BodyPartPayload {

    private static let DEFAULT_SUBTYPE: String = "form-data"
    
    private let boundary: String
    private var preamble: String = ""
    private let bodyParts: ArrayList<BodyPartPayload> = ArrayList<BodyPartPayload>()
    private var epilogue: String = ""

    /**
     * Create a MultipartPayload instance.
     *
     * @since 0.37.2
     */
    public init() {
        this("", MultipartUtils.generateDefaultBoundary(), HashMap<String, String>())
    }
    
    /**
     * Create a MultipartPayload instance according to the parameter.
     *
     * @param boundary of String
     * @since 0.37.2
     */
    public init(boundary: String) {
        this("", boundary, HashMap<String, String>())
    }
    
    /**
     * Create a MultipartPayload instance according to the parameters.
     *
     * @param subtype of String
     * @param boundary of String
     * @since 0.37.2
     */
    public init(subtype: String, boundary: String) {
        this(subtype, boundary, HashMap<String, String>())
    }
    
    /**
     * Create a MultipartPayload instance according to the parameter.
     *
     * @param headers of HashMap<String, String>
     * @since 0.37.2
     */
    public init(headers: HashMap<String, String>) {
        this("", parseOrGenerateBoundary(headers), headers)
    }
    
    /**
     * Create a MultipartPayload instance according to the parameters.
     *
     * @param boundary of String
     * @param headers of HashMap<String, String>
     * @since 0.37.2
     */
    public init(boundary: String, headers: HashMap<String, String>) {
        this("", boundary, headers)
    }
    
    /**
     * Create a MultipartPayload instance according to the parameters.
     *
     * @param subtype of String
     * @param boundary of String
     * @param headers of HashMap<String, String>
     * @since 0.37.2
     */
    public init(subtype: String, boundary: String, headers: HashMap<String, String>) {
        super(composeHeaders(subtype, boundary, headers))
        this.boundary = boundary
    }

    private static func composeHeaders(subtype: String, boundary: String,
                                        headersIn: HashMap<String, String>): HashMap<String, String> {
        MultipartUtils.checkBoundarySyntax(boundary)
        var headersOut: HashMap<String, String> = HashMap<String, String>()
        var contentTypeHeader: String = ""
        if (headersIn.size > 0) {
            contentTypeHeader = headersIn.get(CONTENT_TYPE) ?? ""
        }

        if (contentTypeHeader.isEmpty()) {
            contentTypeHeader = "multipart/" + subtype
            if (subtype.isEmpty()) {
                contentTypeHeader += DEFAULT_SUBTYPE
            }
            contentTypeHeader += ("; boundary=\"" + boundary + '"')
            if (!headersIn.isEmpty()) {
                headersOut = headersIn
            }
            headersOut.put(CONTENT_TYPE, contentTypeHeader)
        } else {
            headersOut = headersIn
            let parsedBoundary: String = MultipartUtils.parseBoundaryFromHeader(contentTypeHeader)
            if (parsedBoundary.isEmpty()) {
                headersOut.put(CONTENT_TYPE, contentTypeHeader + "; boundary=\"" + boundary + '"')
            } else if (!parsedBoundary.equals(boundary)) {
                let err: String = "Different boundaries was passed in constructors. One as argument, second as header"
                throw IllegalArgumentException(err)
            }
        }
        return headersOut
    }
    
    private static func parseOrGenerateBoundary(headers: HashMap<String, String>): String {
        let parsedBoundary: String = MultipartUtils.parseBoundaryFromHeader(headers.get(CONTENT_TYPE) ?? "")
        if (parsedBoundary.isEmpty()) {
            return MultipartUtils.generateDefaultBoundary()
        }
        return parsedBoundary
    }
    
    /**
     * Add the bodyPartPayload to bodyParts.
     *
     * @param bodyPartPayload of BodyPartPayload
     * @since 0.37.2
     */
    public func addBodyPart(bodyPartPayload: BodyPartPayload): Unit {
        bodyParts.append(bodyPartPayload)
    }
    
    /**
     * Add the multipartPayload to this.bodyParts.
     *
     * @param bodyPartPayload of BodyPartPayload
     * @since 0.37.2
     */
    public func addBodyPart(multipartPayload: MultipartPayload): Unit {
        if (multipartPayload.getBoundary().equals(boundary)) {
            let err: String = "{'boundary'}={'" + boundary + "'} is the same for parent MultipartPayload and child."
            throw IllegalArgumentException(err)
        }
        bodyParts.append(multipartPayload)
    }
    
    /**
     * Get the bodyParts value.
     *
     * @return Type of ArrayList<BodyPartPayload>
     * @since 0.37.2
     */
    public func getBodyParts(): ArrayList<BodyPartPayload> {
        return bodyParts
    }
    
    /**
     * Get the boundary value.
     *
     * @return Type of String
     * @since 0.37.2
     */
    public func getBoundary(): String {
        return boundary
    }
    
    /**
     * Get the preamble value.
     *
     * @return Type of String
     * @since 0.37.2
     */
    public func getPreamble(): String {
        return preamble
    }
    
    /**
     * Set the preamble value.
     *
     * @param preamble of String
     * @since 0.37.2
     */
    public func setPreamble(preamble: String): Unit {
        this.preamble = preamble
    }
    
    /**
     * Get the epilogue value.
     *
     * @return Type of String
     * @since 0.37.2
     */
    public func getEpilogue(): String {
        return epilogue
    }
    
    /**
     * Set the epilogue value.
     *
     * @param preamble of String
     * @since 0.37.2
     */
    public func setEpilogue(epilogue: String): Unit {
        this.epilogue = epilogue
    }
}
