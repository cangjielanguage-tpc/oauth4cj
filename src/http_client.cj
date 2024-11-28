/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights reserved.
 */

/**
 * @file The file declars the HttpClient interface.
 */
package oauth4cj

internal import std.fs.*

public interface HttpClient <: Resource {

    /**
     * async execute.
     *
     * @Param userAgent of String, the user agent
     * @Param headers of HashMap<String, String>, the header
     * @Param httpVerb of Verb, Verb is an enumeration that contains the most common types of HTTP requests.
     * @Param completeUrl of String, the complete url
     * @Param bodyContents of Array<UInt8>, the body content
     * @Param callback of Option<OAuthAsyncRequestCallback>, the oAuth async request callback
     * @Param converter of Option<ResponseConverter>, the response converter
     *
     * @Return Future<Any> the result of async execute.
     * @since 0.38.2
     */
    func executeAsync(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
        bodyContents: Array<UInt8>, callback: Option<OAuthAsyncRequestCallback>, 
        converter: Option<ResponseConverter>): Future<Any>

    /**
     * async execute.
     *
     * @Param userAgent of String, the user agent
     * @Param headers of HashMap<String, String>, the header
     * @Param httpVerb of Verb, Verb is an enumeration that contains the most common types of HTTP requests.
     * @Param completeUrl of String, the complete url
     * @Param bodyContents of MultipartPayload, the body content
     * @Param callback of Option<OAuthAsyncRequestCallback>, the oAuth async request callback
     * @Param converter of Option<ResponseConverter>, the response converter
     *
     * @Return Future<Any> the result of async execute.
     * @since 0.38.2
     */
    func executeAsync(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
            bodyContents: MultipartPayload, callback: Option<OAuthAsyncRequestCallback>,
            converter: Option<ResponseConverter>): Future<Any>

    /**
     * async execute.
     *
     * @Param userAgent of String, the user agent
     * @Param headers of HashMap<String, String>, the header
     * @Param httpVerb of Verb, Verb is an enumeration that contains the most common types of HTTP requests.
     * @Param completeUrl of String, the complete url
     * @Param bodyContents of String, the body content
     * @Param callback of Option<OAuthAsyncRequestCallback>, the oAuth async request callback
     * @Param converter of Option<ResponseConverter>, the response converter
     *
     * @Return Future<Any> the result of async execute.
     * @since 0.38.2
     */
    func executeAsync(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
            bodyContents: String, callback: Option<OAuthAsyncRequestCallback>, 
            converter: Option<ResponseConverter>): Future<Any>

    /**
     * async execute.
     *
     * @Param userAgent of String, the user agent
     * @Param headers of HashMap<String, String>, the header
     * @Param httpVerb of Verb, Verb is an enumeration that contains the most common types of HTTP requests.
     * @Param completeUrl of String, the complete url
     * @Param bodyContents of File, the body content
     * @Param callback of Option<OAuthAsyncRequestCallback>, the oAuth async request callback
     * @Param converter of Option<ResponseConverter>, the response converter
     *
     * @Return Future<Any> the result of async execute.
     * @since 0.38.2
     */
    func executeAsync(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
            bodyContents: File, callback: Option<OAuthAsyncRequestCallback>, 
            converter: Option<ResponseConverter>): Future<Any>

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
            bodyContents: Array<UInt8>): OAuth4cjResponse

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
            bodyContents: MultipartPayload): OAuth4cjResponse

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
            bodyContents: String): OAuth4cjResponse

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
            bodyContents: File): OAuth4cjResponse
}
