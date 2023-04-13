/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights resvered.
 */

/**
 * @file The file declars the FileByteArrayBodyPartPayload class.
 */
package httpclient.multipart


public class FileByteArrayBodyPartPayload <: ByteArrayBodyPartPayload {
    
    /**
     * Create a FileByteArrayBodyPartPayload instance according to the parameter.
     *
     * @param payload of Array<UInt8>
     * @since 0.37.2
     */
    public init(payload: Array<UInt8>) {
        this(payload, "")
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
        this(payload, off, len, "")
    }
    
    /**
     * Create a FileByteArrayBodyPartPayload instance according to the parameters.
     *
     * @param payload of Array<UInt8>
     * @param name of String
     * @since 0.37.2
     */
    public init(payload: Array<UInt8>, name: String) {
        this(payload, name, "")
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
        this(payload, off, len, name, "")
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
        this("", payload, name, filename)
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
        this("", payload, off, len, name, filename)
    }
    
    /**
     * Create a FileByteArrayBodyPartPayload instance according to the parameters.
     *
     * @param contentType of String
     * @param payload of Array<UInt8>
     * @since 0.37.2
     */
    public init(contentType: String, payload: Array<UInt8>) {
        this(contentType, payload, "")
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
        this(contentType, payload, off, len, "")
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
        this(contentType, payload, name, "")
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
        this(contentType, payload, off, len, name, "")
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

    private static func composeHeaders(contentType: String, name: String, filename: String): HashMap<String, String> {

        var contentDispositionHeader: String = "form-data"

        contentDispositionHeader += "; name=\"" + name + '"'
        contentDispositionHeader += "; filename=\"" + filename + '"'

        let headers: HashMap<String, String> = HashMap<String, String>()
        headers.put(CONTENT_TYPE, contentType)
        headers.put("Content-Disposition", contentDispositionHeader)
        return headers
    }
}
