/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights reserved.
 * 
 */
package model

from std import collection.HashMap
from std import collection.ArrayList
from std import io.InputStream
from std import io.IOException
from std import io.ByteArrayStream

import utils.StreamUtils

/**
 * Response
 * @since 0.37.2
 */
public class Response <: Closeable {
    private var code: Int32 = 0
    private var message: String = ""
    private var headers: HashMap<String, String> = HashMap<String, String>()
    private var body: String = ""
    private var stream: InputStream
    private var closed: Bool = false
    private var closeables: ArrayList<Closeable> = ArrayList<Closeable>()
    private var hasBody: Bool = false

    /**
     * Constructor
     *
     * @Param code status code
     * @Param message status message
     * @Param headers response Headers
     * @Param stream meaningful stream
     * @Param body response body
     * @since 0.37.2
     */
    public init(code: Int32, message: String, headers: HashMap<String, String>, body: String) {
        this.code = code
        this.message = message
        this.headers = headers
        this.body = body
        this.stream = ByteArrayStream()
        this.hasBody = true
    }

    /**
     * Constructor
     *
     * @Param code status code
     * @Param message status message
     * @Param headers response Headers
     * @Param stream meaningful stream
     * @Param body response body
     * @since 0.37.2
     */
    public init(code: Int32, message: String, headers: HashMap<String, String>, stream: InputStream,
            closeables: ArrayList<Closeable>) {
        this.code = code
        this.message = message
        this.headers = headers
        this.stream = stream
        this.closeables = closeables
        this.hasBody = false
    }

    private func parseBodyContents(): String {
        try {
            if ("gzip".equals(getHeader("Content-Encoding"))) {
                body = StreamUtils.getGzipStreamContents(stream)
            } else {
                body = StreamUtils.getStreamContents(stream)
            }
        } catch (e: NoneValueException) {
            body = StreamUtils.getStreamContents(stream)
        }
        return body
    }

    /**
     * whether the response was successful
     *
     * @return Bool code equal to 200 or between 200 and 400 return true
     * @since 0.37.2
     */
    public func isSuccessful(): Bool {
        return code >= 200 && code < 400
    }

    /**
     * Returns the response body as a string, closing the stream that backs it
     *
     * @return String body as string
     * @since 0.37.2
     */
    public func getBody(): String {
        if (!hasBody) {
            return parseBodyContents()
        }
        return body
    }

    /**
     * otains the stream of the HttpUrlConnection, either inputStream or errorInputStream
     *
     * @return InputStream input stream / error stream depending on the status code
     * @since 0.37.2
     */
    public func getStream(): InputStream {
        return stream
    }

    /**
     * otains the HTTP status code
     *
     * @return Int32 the status code
     * @since 0.37.2
     */
    public func getCode(): Int32 {
        return code
    }

    /**
     * otains the HTTP status message
     *
     * @return String the status message
     * @since 0.37.2
     */
    public func getMessage(): String {
        return message
    }

    /**
     * otains the HTTP Response Headers
     *
     * @return HashMap<String, String> headers
     * @since 0.37.2
     */
    public func getHeaders(): HashMap<String, String> {
        return headers
    }

    /**
     * otains a single HTTP Header value, if it does not exist, throw an exception.
     *
     * @param name the header name
     * @return String header value
     * @since 0.37.2
     */
    public func getHeader(name: String): String {
        return headers[name]
    }

    /**
     * to String
     * 
     * @return String response infomation
     * @since 0.37.2
     */
    public func toString(): String {
        return "Response{code=${code}, message='${message}', body='${body}', headers=${headers}}" 
    }

    /**
     * closes this stream and releases any system resources associated with it
     * 
     * @Exception IOException if close stream or resources fails throw IOException
     * @since 0.37.2
     */
    public func close(): Unit {
        if (closed) {
            return
        }
        var ioException:IOException = IOException()
        if (closeables.size > 0) {
            for (closeItem in closeables) {
                try {
                    closeItem.close()
                } catch (ioE:IOException) {
                    ioException = ioE
                }
            }
        }
        if (!ioException.message.isEmpty()) {
            throw ioException
        }
        closed = true
    }
}

/**
 * a source or destination of data that can be closed
 * @since 0.37.2
 */
public interface Closeable {
    func close(): Unit {}
}