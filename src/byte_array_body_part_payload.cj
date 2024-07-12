/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights resvered.
 */

/**
 * @file The file declars the ByteArrayBodyPartPayload class.
 */
package oauth4cj

public open class ByteArrayBodyPartPayload <: BodyPartPayload {
    
    private let payload: Array<UInt8>
    private let off: Int64
    private let len: Int64

    /**
     * Create a ByteArrayBodyPartPayload instance according to the parameters.
     *
     * @param payload of Array<UInt8>
     * @param off of Int64
     * @param len of Int64
     * @param headers of HashMap<String, String>
     * @since 0.37.2
     */
    public init(payload: Array<UInt8>, off: Int64, len: Int64, headers: HashMap<String, String>) {
        super(headers)
        this.payload = payload
        this.off = off
        this.len = len
    }

    /**
     * Create a ByteArrayBodyPartPayload instance according to the parameters.
     *
     * @param payload of Array<UInt8>
     * @param headers of HashMap<String, String>
     * @since 0.37.2
     */
    public init(payload: Array<UInt8>, headers: HashMap<String, String>) {
        this(payload, 0, payload.size, headers)
    }
    
    /**
     * Create a ByteArrayBodyPartPayload instance according to the parameters.
     *
     * @param payload of Array<UInt8>
     * @param contentType of String
     * @since 0.37.2
     */
    public init(payload: Array<UInt8>, contentType: String) {
        this(payload, convertContentTypeToHeaders(contentType))
    }
    
    /**
     * Create a ByteArrayBodyPartPayload instance according to the parameters.
     *
     * @param payload of Array<UInt8>
     * @param off of Int64
     * @param len of Int64
     * @param contentType of String
     * @since 0.37.2
     */
    public init(payload: Array<UInt8>, off: Int64, len: Int64, contentType: String) {
        this(payload, off, len, convertContentTypeToHeaders(contentType))
    }
    
    /**
     * Create a ByteArrayBodyPartPayload instance according to the parameter.
     *
     * @param payload of Array<UInt8>
     * @since 0.37.2
     */
    public init(payload: Array<UInt8>) {
        this(payload, HashMap<String, String>())
    }
    
    /**
     * Create a ByteArrayBodyPartPayload instance according to the parameters.
     *
     * @param payload of Array<UInt8>
     * @param off of Int64
     * @param len of Int64
     * @since 0.37.2
     */
    public init(payload: Array<UInt8>, off: Int64, len: Int64) {
        this(payload, off, len, HashMap<String, String>())
    }

    /**
     * Get the payload value.
     *
     * @return Type of Array<UInt8>
     * @since 0.37.2
     */
    public func getPayload(): Array<UInt8> {
        return payload
    }

    /**
     * Get the off number.
     *
     * @return Type of Int64
     * @since 0.37.2
     */
    public func getOff(): Int64 {
        return off
    }

    /**
     * Get the len number.
     *
     * @return Type of Int64
     * @since 0.37.2
     */
    public func getLen(): Int64 {
        return len
    }
}
