
/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights reserved.
 */

/**
 * @file The file declars the HttpClient interface.
 */
package httpclient

from std import collection.*
from std import fs.*

import model.*
import httpclient.multipart.*


public let DEFAULT_CONTENT_TYPE: String = "application/x-www-form-urlencoded"
public let CONTENT_TYPE: String = "Content-Type"
public let CONTENT_LENGTH: String = "Content-Length"

public interface HttpClient<T> <: Closeable {

    /**
     * async execute.
     *
     * @Param userAgent of String, the user agent
     * @Param headers of HashMap<String, String>, the header
     * @Param httpVerb of Verb, Verb is an enumeration that contains the most common types of HTTP requests.
     * @Param completeUrl of String, the complete url
     * @Param bodyContents of Array<UInt8>, the body content
     * @Param callback of OAuthAsyncRequestCallback<T>, the oAuth async request callback
     * @Param converter of ResponseConverter<T>, the response converter
     *
     * @Return Future<T> the result of async execute.
     * @since 0.38.2
     */
    func executeAsync(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
        bodyContents: Array<UInt8>, callback: OAuthAsyncRequestCallback<T>, converter: ResponseConverter<T>): Future<T>

    /**
     * async execute.
     *
     * @Param userAgent of String, the user agent
     * @Param headers of HashMap<String, String>, the header
     * @Param httpVerb of Verb, Verb is an enumeration that contains the most common types of HTTP requests.
     * @Param completeUrl of String, the complete url
     * @Param bodyContents of MultipartPayload, the body content
     * @Param callback of OAuthAsyncRequestCallback<T>, the oAuth async request callback
     * @Param converter of ResponseConverter<T>, the response converter
     *
     * @Return Future<T> the result of async execute.
     * @since 0.38.2
     */
    func executeAsync(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
            bodyContents: MultipartPayload, callback: OAuthAsyncRequestCallback<T>,
            converter: ResponseConverter<T>): Future<T>

    /**
     * async execute.
     *
     * @Param userAgent of String, the user agent
     * @Param headers of HashMap<String, String>, the header
     * @Param httpVerb of Verb, Verb is an enumeration that contains the most common types of HTTP requests.
     * @Param completeUrl of String, the complete url
     * @Param bodyContents of String, the body content
     * @Param callback of OAuthAsyncRequestCallback<T>, the oAuth async request callback
     * @Param converter of ResponseConverter<T>, the response converter
     *
     * @Return Future<T> the result of async execute.
     * @since 0.38.2
     */
    func executeAsync(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
            bodyContents: String, callback: OAuthAsyncRequestCallback<T>, converter: ResponseConverter<T>): Future<T>

    /**
     * async execute.
     *
     * @Param userAgent of String, the user agent
     * @Param headers of HashMap<String, String>, the header
     * @Param httpVerb of Verb, Verb is an enumeration that contains the most common types of HTTP requests.
     * @Param completeUrl of String, the complete url
     * @Param bodyContents of File, the body content
     * @Param callback of OAuthAsyncRequestCallback<T>, the oAuth async request callback
     * @Param converter of ResponseConverter<T>, the response converter
     *
     * @Return Future<T> the result of async execute.
     * @since 0.38.2
     */
    func executeAsync(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
            bodyContents: File, callback: OAuthAsyncRequestCallback<T>, converter: ResponseConverter<T>): Future<T>

    /**
     * execute.
     *
     * @Param userAgent of String, the user agent
     * @Param headers of HashMap<String, String>, the header
     * @Param httpVerb of Verb, Verb is an enumeration that contains the most common types of HTTP requests.
     * @Param completeUrl of String, the complete url
     * @Param bodyContents of Array<UInt8>, the body content
     *
     * @Return Response The response returned after execution.
     * @since 0.38.2
     */
    func execute(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
            bodyContents: Array<UInt8>): Response

    /**
     * execute.
     *
     * @Param userAgent of String, the user agent
     * @Param headers of HashMap<String, String>, the header
     * @Param httpVerb of Verb, Verb is an enumeration that contains the most common types of HTTP requests.
     * @Param completeUrl of String, the complete url
     * @Param bodyContents of MultipartPayload, the body content
     *
     * @Return Response The response returned after execution.
     * @since 0.38.2
     */
    func execute(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
            bodyContents: MultipartPayload): Response

    /**
     * execute.
     *
     * @Param userAgent of String, the user agent
     * @Param headers of HashMap<String, String>, the header
     * @Param httpVerb of Verb, Verb is an enumeration that contains the most common types of HTTP requests.
     * @Param completeUrl of String, the complete url
     * @Param bodyContents of String, the body content
     *
     * @Return Response The response returned after execution.
     * @since 0.38.2
     */
    func execute(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
            bodyContents: String): Response

    /**
     * execute.
     *
     * @Param userAgent of String, the user agent
     * @Param headers of HashMap<String, String>, the header
     * @Param httpVerb of Verb, Verb is an enumeration that contains the most common types of HTTP requests.
     * @Param completeUrl of String, the complete url
     * @Param bodyContents of File, the body content
     *
     * @Return Response The response returned after execution.
     * @since 0.38.2
     */
    func execute(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
            bodyContents: File): Response
}
