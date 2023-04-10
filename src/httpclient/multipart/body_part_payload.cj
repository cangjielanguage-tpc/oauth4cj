/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights reserved.
 */

/**
 * @file The file declars the BodyPartPayload class.
 */
package httpclient.multipart

from std import collection.*

public open class BodyPartPayload {

    private let headers: HashMap<String, String>

    /**
     * Create a BodyPartPayload instance.
     *
     * @since 0.37.2
     */
    public init() {
        this.headers = HashMap<String, String>()
    }

    /**
     * Create a BodyPartPayload instance according to the parameter.
     *
     * @param contentType of String
     * @since 0.37.2
     */
    public init(contentType: String) {
        this.headers = convertContentTypeToHeaders(contentType)
    }

    /**
     * Create a BodyPartPayload instance according to the parameter.
     *
     * @param headers of HashMap<String, String>
     * @since 0.37.2
     */
    public init(headers: HashMap<String, String>) {
        this.headers = headers
    }

    /**
     * Gets the headers value of BodyPartPayload.
     *
     * @return Type of HashMap<String, String>
     * @since 0.37.2
     */
    public func getHeaders(): HashMap<String, String> {
        return headers
    }

    protected static func convertContentTypeToHeaders(contentType: String): HashMap<String, String> {
        if (contentType.isEmpty()) {
            return HashMap<String, String>()
        }
        return HashMap<String, String>([(CONTENT_TYPE, contentType)])
    }
}
