/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights reserved.
 */

/**
 * @file The file declars the OkHttpHttpClient class.
 */
package oauth4cj

import net.http.HttpHeaders 

internal import httpclient4cj.*
internal import httpclient4cj.HttpClient as Httpclient4cjHttpClient

enum BodyType {
    | BYTE_ARRAY
    | STRING
    | FILE

    public func createBody(mediaType: Option<MediaType>, bodyContents: Any): RequestBody {
        match(this) {
            case BYTE_ARRAY => return RealRequestBody.create(mediaType, (bodyContents as Array<UInt8>).getOrThrow())
            case STRING => return RealRequestBody.create(mediaType, (bodyContents as String).getOrThrow())
            case FILE => return RealRequestBody.create(mediaType, (bodyContents as File).getOrThrow())
        }
    }
}

/**
 * OkHttpHttpClient class, provide asynchronous and synchronous execution api
 */
public class OkHttpHttpClient <: HttpClient {

    private static let DEFAULT_CONTENT_TYPE_MEDIA_TYPE: Option<MediaType> = MediaType.parse(OAuthConstants.DEFAULT_CONTENT_TYPE)

    private let client: Httpclient4cjHttpClient

    private var closed: Bool = false

    /**
     * Create a OkHttpHttpClient instance.
     *
     * @since 0.38.2
     */
    public init() {
        this(OkHttpHttpClientConfig.defaultConfig())
    }

    /**
     * Create a OkHttpHttpClient instance according to the parameter.
     *
     * @param config of OkHttpHttpClientConfig.
     * @since 0.38.2
     */
    public init(config: OkHttpHttpClientConfig) {
        let clientBuilder: HttpClientBuilder = config.getClientBuilder()
        this.client = clientBuilder.build()
    }

    /**
     * Create a OkHttpHttpClient instance according to the parameter.
     *
     * @param client of HttpClient.
     * @since 0.38.2
     */
    public init(client: Httpclient4cjHttpClient) {
        this.client = client
    }

    /**
     * Close resources in HttpClient.
     *
     * @since 0.38.2
     */
    public func close(): Unit {
        if (closed) {
            return
        }
        client.getDispatcher().cancelAll()
        match (client.getConnectionPool()) {
            case Some(v) => v.evictAll()
            case None => ()
        }
        let cache: Option<Cache> = client.getCache()
        match (cache) {
            case Some(v) => v.close()
            case None => ()
        }
        closed = true
    }

    /**
     * Determine if the close method has been executed.
     *
     * @Return Bool If the close method has already been called, return true; otherwise, return false.
     * @since 0.38.2
     */
    public func isClosed(): Bool {
        return closed
    }

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
    public func executeAsync(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
            bodyContents: Array<UInt8>, callback: Option<OAuthAsyncRequestCallback>,
            converter: Option<ResponseConverter>): Future<Any> {

        return doExecuteAsync(userAgent, headers, httpVerb, completeUrl, BodyType.BYTE_ARRAY, bodyContents, callback,
                converter)
    }

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
     * @exception OAuth4cjException OKHttp Client does not support Multipart payload for the moment.
     * @since 0.38.2
     */
    public func executeAsync(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
                bodyContents: MultipartPayload, callback: Option<OAuthAsyncRequestCallback>,
                converter: Option<ResponseConverter>): Future<Any> {

        throw OAuth4cjException("OKHttpClient does not support Multipart payload for the moment")
    }

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
    public func executeAsync(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
            bodyContents: String, callback: Option<OAuthAsyncRequestCallback>,
            converter: Option<ResponseConverter>): Future<Any> {

        return doExecuteAsync(userAgent, headers, httpVerb, completeUrl, BodyType.STRING, bodyContents, callback,
                converter)
    }

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
    public func executeAsync(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
            bodyContents: File, callback: Option<OAuthAsyncRequestCallback>,
            converter: Option<ResponseConverter>): Future<Any> {

        return doExecuteAsync(userAgent, headers, httpVerb, completeUrl, BodyType.FILE, bodyContents, callback,
                converter)
    }

    private func doExecuteAsync(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb,
            completeUrl: String, bodyType: BodyType, bodyContents: Any, callback: Option<OAuthAsyncRequestCallback>,
            converter: Option<ResponseConverter>): Future<Any> {
        let call: Call = createCall(userAgent, headers, httpVerb, completeUrl, bodyType, bodyContents)

        let oach: OAuthAsyncCompletionHandler = OAuthAsyncCompletionHandler(callback, converter)
        call.enqueue(oach)
        return oach.getFuture()
    }

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
    public func execute(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
            bodyContents: Array<UInt8>): OAuth4cjResponse {

        return doExecute(userAgent, headers, httpVerb, completeUrl, BodyType.BYTE_ARRAY, bodyContents)
    }

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
     * @exception OAuth4cjException OKHttp Client does not support Multipart payload for the moment.
     * @since 0.38.2
     */
    public func execute(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
            bodyContents: MultipartPayload): OAuth4cjResponse {

        throw OAuth4cjException("OKHttpClient does not support Multipart payload for the moment")
    }

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
    public func execute(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
            bodyContents: String): OAuth4cjResponse {

        return doExecute(userAgent, headers, httpVerb, completeUrl, BodyType.STRING, bodyContents)
    }

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
    public func execute(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
            bodyContents: File): OAuth4cjResponse {

        return doExecute(userAgent, headers, httpVerb, completeUrl, BodyType.FILE, bodyContents)
    }

    private func doExecute(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
            bodyType: BodyType, bodyContents: Any): OAuth4cjResponse {
        let call: Call = createCall(userAgent, headers, httpVerb, completeUrl, bodyType, bodyContents)
        return convertResponse(call.execute())
    }

    private func createCall(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
            bodyType: BodyType, bodyContents: Any): Call {
        let requestBuilder: RequestBuilder = Request.builder()
        requestBuilder.url(completeUrl)

        let method: String = httpVerb.toString()

        var body: Option<RequestBody> = None
        if (httpVerb.isPermitBody()) {
            var mediaType: Option<MediaType> = DEFAULT_CONTENT_TYPE_MEDIA_TYPE
            if (headers.contains(OAuthConstants.CONTENT_TYPE)) {
                mediaType = MediaType.parse(headers[OAuthConstants.CONTENT_TYPE])
            }

            body = bodyType.createBody(mediaType, bodyContents)
        }

        //fill HTTP method and body to RequestBuilder.
        requestBuilder.method(method, body: body)

        //fill headers to RequestBuilder.
        for ((k, v) in headers) {
            requestBuilder.header(k, v)
        }

        requestBuilder.header(OAuthConstants.USER_AGENT_HEADER_NAME, userAgent)

        //create a new call.
        return client.newCall(requestBuilder.build())
    }

    static func convertResponse(okHttpResponse: Response): OAuth4cjResponse {
        let headers: Header = okHttpResponse.getHeaders()
        let headersMap: HashMap<String, String> = HashMap<String, String>()
        for ((k, v) in headers) {
            headersMap.add(k, v[0])
        }

        let body: ResponseBody = okHttpResponse.getBody().getOrThrow()

        let source: Source = body.getSource()
        let bodyStream: ByteBuffer = ByteBuffer(4096)
        try (r = source) {
            while (source.read(bodyStream, 4096) > 0) {}
        } catch (e: EOFException) {}

        let closeables: ArrayList<Resource> = ArrayList<Resource>()
        closeables.add(source)
        closeables.add(body)
        return OAuth4cjResponse(Int32(okHttpResponse.getCode()), okHttpResponse.getMessage(),
                headersMap, bodyStream, closeables)
    }
}
