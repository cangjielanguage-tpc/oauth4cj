/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights reserved.
 */

/**
 * @file The file declars the FileByteArrayBodyPartPayload class.
 */
package oauth4cj


public class FileByteArrayBodyPartPayload <: ByteArrayBodyPartPayload {
    
    /**
     * Create a FileByteArrayBodyPartPayload instance according to the parameter.
     *
     * @param payload of Array<UInt8>
     * @since 0.37.2
     */
    public init(payload: Array<UInt8>) {
        this(payload, composeHeaders("", "", "", contentTypeNull: true, nameNull: true, filenameNull: true))
    }
    
    /**
     * Create a FileByteArrayBodyPartPayload instance according to the parameters.
     *
     * @param payload of Array<UInt8>
     * @param off of Int64
     * @param len of Int64
     * @since 0.37.2
     */
    public init(payload: Array<UInt8>, off: Int64, len: Int64) {
        this(payload, off, len, composeHeaders("", "", "", contentTypeNull: true, nameNull: true, filenameNull: true))
    }
    
    /**
     * Create a FileByteArrayBodyPartPayload instance according to the parameters.
     *
     * @param payload of Array<UInt8>
     * @param name of String
     * @since 0.37.2
     */
    public init(payload: Array<UInt8>, name: String) {
        this(payload, composeHeaders("", name, "", contentTypeNull: true, filenameNull: true))
    }
    
    /**
     * Create a FileByteArrayBodyPartPayload instance according to the parameters.
     *
     * @param payload of Array<UInt8>
     * @param off of Int64
     * @param len of Int64
     * @param name of String
     * @since 0.37.2
     */
    public init(payload: Array<UInt8>, off: Int64, len: Int64, name: String) {
        this(payload, off, len, composeHeaders("", name, "", contentTypeNull: true, filenameNull: true))
    }
    
    /**
     * Create a FileByteArrayBodyPartPayload instance according to the parameters.
     *
     * @param payload of Array<UInt8>
     * @param name of String
     * @param filename of String
     * @since 0.37.2
     */
    public init(payload: Array<UInt8>, name: String, filename: String) {
        this(payload, composeHeaders("", name, filename, contentTypeNull: true))
    }
    
    /**
     * Create a FileByteArrayBodyPartPayload instance according to the parameters.
     *
     * @param payload of Array<UInt8>
     * @param off of Int64
     * @param len of Int64
     * @param name of String
     * @param filename of String
     * @since 0.37.2
     */
    public init(payload: Array<UInt8>, off: Int64, len: Int64, name: String, filename: String) {
        this(payload, off, len, composeHeaders("", name, filename, contentTypeNull: true))
    }
    
    /**
     * Create a FileByteArrayBodyPartPayload instance according to the parameters.
     *
     * @param contentType of String
     * @param payload of Array<UInt8>
     * @since 0.37.2
     */
    public init(contentType: String, payload: Array<UInt8>) {
        this(payload, composeHeaders(contentType, "", "", nameNull: true, filenameNull: true))
    }
    
    /**
     * Create a FileByteArrayBodyPartPayload instance according to the parameters.
     *
     * @param contentType of String
     * @param payload of Array<UInt8>
     * @param off of Int64
     * @param len of Int64
     * @since 0.37.2
     */
    public init(contentType: String, payload: Array<UInt8>, off: Int64, len: Int64) {
        this(payload, off, len, composeHeaders(contentType, "", "", nameNull: true, filenameNull: true))
    }
    
    /**
     * Create a FileByteArrayBodyPartPayload instance according to the parameters.
     *
     * @param contentType of String
     * @param payload of Array<UInt8>
     * @param name of String
     * @since 0.37.2
     */
    public init(contentType: String, payload: Array<UInt8>, name: String) {
        this(payload, composeHeaders(contentType, name, "", filenameNull: true))
    }
    
    /**
     * Create a FileByteArrayBodyPartPayload instance according to the parameters.
     *
     * @param contentType of String
     * @param payload of Array<UInt8>
     * @param off of Int64
     * @param len of Int64
     * @param name of String
     * @since 0.37.2
     */
    public init(contentType: String, payload: Array<UInt8>, off: Int64, len: Int64, name: String) {
        this(payload, off, len, composeHeaders(contentType, name, "", filenameNull: true))
    }
    
    /**
     * Create a FileByteArrayBodyPartPayload instance according to the parameters.
     *
     * @param contentType of String
     * @param payload of Array<UInt8>
     * @param name of String
     * @param filename of String
     * @since 0.37.2
     */
    public init(contentType: String, payload: Array<UInt8>, name: String, filename: String) {
        super(payload, composeHeaders(contentType, name, filename))
    }
    private init(payload: Array<UInt8>, headers: HashMap<String, String>) {
        super(payload, headers)
    }
    
    /**
     * Create a FileByteArrayBodyPartPayload instance according to the parameters.
     *
     * @param contentType of String
     * @param payload of Array<UInt8>
     * @param off of Int64
     * @param len of Int64
     * @param name of String
     * @param filename of String
     * @since 0.37.2
     */
    public init(contentType: String, payload: Array<UInt8>, off: Int64, len: Int64, name: String, filename: String) {
        super(payload, off, len, composeHeaders(contentType, name, filename))
    }
    private init(payload: Array<UInt8>, off: Int64, len: Int64, headers: HashMap<String, String>) {
        super(payload, off, len, headers)
    }

    private static func composeHeaders(contentType: String, name: String, filename: String,
            contentTypeNull!: Bool = false, nameNull!: Bool = false, filenameNull!: Bool = false):
            HashMap<String, String> {

        var contentDispositionHeader: String = "form-data"
        if (!nameNull) {
            contentDispositionHeader += "; name=\"${name}\""
        }
        if (!filenameNull) {
            contentDispositionHeader += "; filename=\"${filename}\""
        }
        let headers: HashMap<String, String> = HashMap<String, String>()

        if (contentTypeNull) {
            headers.put("Content-Disposition", contentDispositionHeader)
            return headers
        }

        headers.put(OAuthConstants.CONTENT_TYPE, contentType)
        headers.put("Content-Disposition", contentDispositionHeader)
        return headers
    }
}
