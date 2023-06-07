/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights reserved.
 */

/**
 * @file The file declars the OkHttpProvider class.
 */
package httpclient

from net import http.Header

import exceptions.*

enum BodyType <: ToString {
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

    public func toString(): String {
        match (this) {
            case BYTE_ARRAY => "BYTE_ARRAY"
            case STRING => "STRING"
            case FILE => "FILE"
        }
    }
}

public class OkHttpHttpClient <: HttpClient {

    private static let DEFAULT_CONTENT_TYPE_MEDIA_TYPE: Option<MediaType> = MediaType.parse(DEFAULT_CONTENT_TYPE)

    private let client: OkHttpClient

    private var closed: Bool = false

    public init() {
        this(OkHttpHttpClientConfig.defaultConfig())
    }

    public init(config: OkHttpHttpClientConfig) {
        let clientBuilder: OkHttpClientBuilder = config.getClientBuilder()
        this.client = clientBuilder.build()
    }

    public init(client: OkHttpClient) {
        this.client = client
    }

    public func close(): Unit {
        if (closed) {
            return
        }
        client.getDispatcher().cancelAll()
        client.getConnectionPool().getOrThrow().evictAll()
        let cache: Option<Cache> = client.getCache()
        match (cache) {
            case Some(v) => v.close()
            case None => ()
        }
        closed = true
    }

    public func isClosed(): Bool {
        return closed
    }

    public func executeAsync(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
            bodyContents: Array<UInt8>, callback: Option<OAuthAsyncRequestCallback>,
            converter: Option<ResponseConverter>): Future<Any> {

        return doExecuteAsync(userAgent, headers, httpVerb, completeUrl, BodyType.BYTE_ARRAY, bodyContents, callback,
                converter)
    }

    public func executeAsync(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
                bodyContents: MultipartPayload, callback: Option<OAuthAsyncRequestCallback>,
                converter: Option<ResponseConverter>): Future<Any> {

        throw OAuth4cjException("OKHttpClient does not support Multipart payload for the moment")
    }

    public func executeAsync(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
            bodyContents: String, callback: Option<OAuthAsyncRequestCallback>,
            converter: Option<ResponseConverter>): Future<Any> {

        return doExecuteAsync(userAgent, headers, httpVerb, completeUrl, BodyType.STRING, bodyContents, callback,
                converter)
    }

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

    public func execute(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
            bodyContents: Array<UInt8>): OAuth4cjResponse {

        return doExecute(userAgent, headers, httpVerb, completeUrl, BodyType.BYTE_ARRAY, bodyContents)
    }

    public func execute(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
            bodyContents: MultipartPayload): OAuth4cjResponse {

        throw OAuth4cjException("OKHttpClient does not support Multipart payload for the moment")
    }

    public func execute(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
            bodyContents: String): OAuth4cjResponse {

        return doExecute(userAgent, headers, httpVerb, completeUrl, BodyType.STRING, bodyContents)
    }

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

        // prepare body
        var body: Option<RequestBody> = None

        if (httpVerb.isPermitBody()) {
            var mediaType: Option<MediaType> = DEFAULT_CONTENT_TYPE_MEDIA_TYPE
            if (headers.contains(CONTENT_TYPE)) {
                mediaType = MediaType.parse(headers[CONTENT_TYPE])
            }

            body = bodyType.createBody(mediaType, bodyContents)
        }

        // fill HTTP method and body
        requestBuilder.method(method, body: body)

        // fill headers
        for ((k, v) in headers) {
            requestBuilder.header(k, v)
        }

        requestBuilder.header(OAuthConstants.USER_AGENT_HEADER_NAME, userAgent)

        // create a new call
        return client.newCall(requestBuilder.build())
    }

    static func convertResponse(okHttpResponse: okhttp.Response): OAuth4cjResponse {
        let headers: Header = okHttpResponse.getHeaders()
        let headersMap: HashMap<String, String> = HashMap<String, String>()
        for ((k, v) in headers) {
            headersMap.put(k, v[0])
        }

        let body: ResponseBody = okHttpResponse.getBody().getOrThrow()

        let source: Source = body.getSource()
        let bodyStream: ByteArrayStream = ByteArrayStream(4096)
        try (r = source) {
            while (source.read(bodyStream, 4096) > 0) {}
        } catch (e: EOFException) {}

        let closeables: ArrayList<Resource> = ArrayList<Resource>()

        closeables.append(source)
        closeables.append(body)

        return OAuth4cjResponse(Int32(okHttpResponse.getCode()), okHttpResponse.getMessage(),
                headersMap, bodyStream, closeables)
    }
}

