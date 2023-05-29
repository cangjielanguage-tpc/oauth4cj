/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights resvered.
 */

/**
 * @file The file declars the OAuth4cjRequest class.
 */
package model

from std import regex.*
from std import fs.*
from encoding import url.*

import httpclient.multipart.*

public open class OAuth4cjRequest {

    private static let OAUTH_PREFIX: String = "oauth_"

    private let url: String
    private let verb: Verb
    private let querystringParams: ParameterList = ParameterList()
    private let bodyParams: ParameterList = ParameterList()

    // The key value is converted to all uppercase strings by default for storage or comparison.
    private let headers: HashMap<String, String> = HashMap<String, String>()

    private var charset: String = "UTF-8"

    private var stringPayload: String = ""
    private var byteArrayPayload: Array<UInt8> = Array<UInt8>()

    private var filePayload: ?File = None

    private var multipartPayload: MultipartPayload = MultipartPayload()

    private let oauthParameters: HashMap<String, String> = HashMap<String, String>()

    private var realm: String = ""

    /**
     * Create an OAuth4cjRequest instance based on the parameters.
     *
     * @param verb of Verb
     * @param url of String
     * @since 0.37.2
     */
    public init(verb: Verb, url: String) {
        this.verb = verb
        this.url = url
    }

    /**
     * Adds an OAuth4cj parameter.
     *
     * @param key of String, parameter name
     * @param value of String, parameter value
     * @since 0.37.2
     */
    public func addOAuthParameter(key: String, value: String): Unit {
        this.oauthParameters.put(checkKey(key), value);
    }

    private func checkKey(key: String): String {
        if (key.startsWith(OAUTH_PREFIX) || key.equals(OAuthConstants.SCOPE) || key.equals(OAuthConstants.REALM)) {
            return key
        } else {
            let err: String = "OAuth parameters must either be " + OAuthConstants.SCOPE + ", " +
                                OAuthConstants.REALM + " or start with " + OAUTH_PREFIX
            throw OAuth4cjParametersMissingException(err)
        }
    }

    /**
     * get oauthParameters value.
     *
     * @return Type of HashMap<String, String>
     * @since 0.37.2
     */
    public func getOauthParameters(): HashMap<String, String> {
        return this.oauthParameters
    }

    /**
     * set realm value.
     *
     * @param realm of String
     * @since 0.37.2
     */
    public func setRealm(realm: String): Unit {
        this.realm = realm
    }
    
    /**
     * get realm value.
     *
     * @return Type of String
     * @since 0.37.2
     */
    public func getRealm(): String {
        return this.realm
    }
    
    /**
     * Returns the complete url String.
     * (host + resource + encoded querystring parameters).
     *
     * @return Type of String, the complete url.
     * @since 0.37.2
     */
    public func getCompleteUrl(): String {
        return querystringParams.appendTo(url);
    }
    
    /**
     * Add an HTTP Header to the Request.
     * Convert string key to uppercase storage.
     *
     * @param key of String, key the header name
     * @param value of String, value the header value
     * @since 0.37.2
     */
    public func addHeader(key: String, value: String): Unit {
        this.headers.put(key.toAsciiUpper(), value)
    }
    
    /**
     * Add a body Parameter (for POST/ PUT Requests).
     *
     * @param key of String, key the parameter name
     * @param value of String, value the parameter value
     * @since 0.37.2
     */
    public func addBodyParameter(key: String, value: String): Unit {
        this.bodyParams.add(key, value)
    }
    
    /**
     * Add a QueryString parameter.
     *
     * @param key of String, key the parameter name
     * @param value of String, value the parameter value
     * @since 0.37.2
     */
    public func addQuerystringParameter(key: String, value: String): Unit {
        this.querystringParams.add(key, value)
    }
    
    /**
     * Add a parameter.
     *
     * @param key of String, key the parameter name
     * @param value of String, value the parameter value
     * @since 0.37.2
     */
    public func addParameter(key: String, value: String): Unit {
        if (verb.isPermitBody()) {
            this.bodyParams.add(key, value)
        } else {
            this.querystringParams.add(key, value)
        }
    }
    
    /**
     * Get the multipartPayload.
     *
     * @return Type of MultipartPayload
     * @since 0.37.2
     */
    public func getMultipartPayload(): MultipartPayload {
        return this.multipartPayload
    }
    
    /**
     * Set the multipartPayload.
     *
     * @param key of MultipartPayload
     * @since 0.37.2
     */
    public func setMultipartPayload(multipartPayload: MultipartPayload): Unit {
        this.multipartPayload = multipartPayload
    }
    
    /**
     * Create a MultipartPayload instance, and set to this multipartPayload value.
     *
     * @since 0.37.2
     */
    public func initMultipartPayload(): Unit {
        this.multipartPayload = MultipartPayload()
    }
    
    /**
     * Create a MultipartPayload instance according to the parameter, and set to this multipartPayload value.
     *
     * @param boundary of String
     * @since 0.37.2
     */
    public func initMultipartPayload(boundary: String): Unit {
        this.multipartPayload = MultipartPayload(boundary)
    }
    
    /**
     * Create a MultipartPayload instance according to the parameters, and set to this multipartPayload value.
     *
     * @param subtype of String
     * @param boundary of String
     * @since 0.37.2
     */
    public func initMultipartPayload(subtype: String, boundary: String): Unit {
        this.multipartPayload = MultipartPayload(subtype, boundary)
    }
    
    /**
     * Create a MultipartPayload instance according to the parameter, and set to this multipartPayload value.
     *
     * @param headers of HashMap<String, String>
     * @since 0.37.2
     */
    public func initMultipartPayload(headers: HashMap<String, String>): Unit {
        this.multipartPayload = MultipartPayload(headers)
    }
    
    /**
     * Create a MultipartPayload instance according to the parameters, and set to this multipartPayload value.
     *
     * @param boundary of String
     * @param headers of HashMap<String, String>
     * @since 0.37.2
     */
    public func initMultipartPayload(boundary: String, headers: HashMap<String, String>): Unit {
        this.multipartPayload = MultipartPayload(boundary, headers)
    }
    
    /**
     * Create a MultipartPayload instance according to the parameters, and set to this multipartPayload value.
     *
     * @param subtype of String
     * @param boundary of String
     * @param headers of HashMap<String, String>
     * @since 0.37.2
     */
    public func initMultipartPayload(subtype: String, boundary: String, headers: HashMap<String, String>): Unit {
        this.multipartPayload = MultipartPayload(subtype, boundary, headers)
    }

    /**
     * Create a MultipartPayload instance, and set to this multipartPayload value.
     * Then add the bodyPartPayload to multipartPayload.
     *
     * @param key of BodyPartPayload
     * @since 0.37.2
     */
    public func setBodyPartPayloadInMultipartPayload(bodyPartPayload: BodyPartPayload): Unit {
        initMultipartPayload()
        addBodyPartPayloadInMultipartPayload(bodyPartPayload)
    }

    /**
     * Add the bodyPartPayload to multipartPayload.
     *
     * @param key of BodyPartPayload
     * @since 0.37.2
     */
    public func addBodyPartPayloadInMultipartPayload(bodyPartPayload: BodyPartPayload): Unit {
        multipartPayload.addBodyPart(bodyPartPayload)
    }

    /**
    * Set the vehicle body payload.
    * This method is used when the HTTP body is not a form-url-encoded String, but another String.
    * For example, XML. Note: This content is not part of the OAuth signature.
    *
    * @param payload of String, body of the request
    * @since 0.37.2
    */
    public func setPayload(payload: String): Unit {
        resetPayload()
        this.stringPayload = payload
    }

    /**
     * Overloaded version for byte arrays.
     *
     * @param payload of Array<UInt8>
     * @since 0.37.2
     */
    public func setPayload(payload: Array<UInt8>): Unit {
        resetPayload()
        byteArrayPayload = payload.clone()
    }

    /**
     * Overloaded version for File.
     *
     * @param payload of File
     * @since 0.37.2
     */
    public func setPayload(payload: File): Unit {
        resetPayload()
        filePayload = Some(payload)
    }

    private func resetPayload(): Unit {
        this.stringPayload = ""
        this.byteArrayPayload = Array<UInt8>()
        this.filePayload = None
        this.multipartPayload = MultipartPayload()
    }

    /**
     * Get a ParameterList with query string parameters.
     *
     * @return Type of ParameterList, a ParameterList containing query string parameters.
     *
     * @throws OAuth4cjException ,invalid request URL。
     * @since 0.37.2
     */
    public func getQueryStringParams(): ParameterList {
        try {
            let result: ParameterList = ParameterList()
            let queryString: String = URL.parse(url).rawQuery
            result.addQuerystring(queryString)
            result.addAll(querystringParams)
            return result
        } catch (e: Exception) {
            throw OAuth4cjException("Malformed URL" + e.message)
        }
    }

    /**
     * Get the body parameters.
     *
     * @return Type of ParameterList, gets the body parameters.
     * @since 0.37.2
     */
    public func getBodyParams(): ParameterList {
        return this.bodyParams
    }

    /**
     * Get the URL of the HTTP request.
     *
     * @return Type of String, ohe original URL of the HTTP request.
     * @since 0.37.2
     */
    public func getUrl(): String {
        return this.url
    }

    /**
     * Returns a URL that does not contain port and query string parts.
     *
     * @return Type of String
     * @since 0.37.2
     */
    public func getSanitizedUrl(): String {
        let urlMatcher: Matcher = Regex("\\?.*").matcher(url)

        if (url.startsWith("http://") && (url.endsWith(":80") || url.contains(":80/"))) {
            return urlMatcher.replaceAll("").replace(":80", "")
        } else if (url.startsWith("https://") && (url.endsWith(":443") || url.contains(":443/"))) {
            return urlMatcher.replaceAll("").replace(":443", "")
        } else {
            return urlMatcher.replaceAll("")
        }
    }

    /**
     * Returns the body of the request.
     *
     * @return Type of String, form encoding string.
     * @since 0.37.2
     */
    public func getStringPayload(): String {
        return this.stringPayload
    }

    /**
     * Returns the body of the request.
     * set in function setPayload(payload: Array<UInt8>) or function addBodyParameter.
     *
     * @return Type of Array<UInt8>
     * @since 0.37.2
     */
    public func getByteArrayPayload(): Array<UInt8> {
        if (byteArrayPayload.size != 0) {
            return byteArrayPayload
        }
        let body: String = bodyParams.asFormUrlEncodedString()
        return body.toUtf8Array()
    }

    /**
     * Get the filePayload.
     *
     * @return Type of Option<File>
     * @since 0.37.2
     */
    public func getFilePayload(): Option<File> {
        return this.filePayload
    }

    /**
     * Obtain the string representation of the OAuth4cjRequest object.
     *
     * @return Type of String, converted string
     * @since 0.37.2
     */
    public func toString(): String {
        return "@Request(${getVerb()} ${getUrl()})"
    }

    /**
     * Get the verb.
     *
     * @return Type of Verb
     * @since 0.37.2
     */
    public func getVerb(): Verb {
        return this.verb
    }

    /**
     * Get the headers.
     *
     * @return Type of HashMap<String, String>
     * @since 0.37.2
     */
    public func getHeaders(): HashMap<String, String> {
        return this.headers
    }

    /**
     * Get Character Set.
     *
     * @return Type of String
     * @since 0.37.2
     */
    public func getCharset(): String {
        return this.charset
    }

    /**
     * Set the character set for the request body.
     * only supported UTF-8.
     *
     * @param charsetName of String
     * @since 0.37.2
     */
    public func setCharset(charsetName: String): Unit {
        if (!charsetName.equals("UTF-8") && !charsetName.equals("utf-8") &&
                                        !charsetName.equals("utf8") && !charsetName.equals("UTF8")) {
            throw OAuth4cjException("only supperd UTF-8")
        }
        this.charset = charsetName
    }

    /**
     * If the response is not included in the type&lt; T&gt；
     * Then close the response on OAuthAsyncRequestCallback.onCompleted(response: T)
     *
     * @param key of Response
     *
     * @return Type of Any
     * @since 0.37.2
     */
    public open func convert(response: Response): Any {}
}

/**
 * The response converter.
 */
public interface ResponseConverter {

    /**
     * If the response is not included in the type&lt; T&gt；
     * Then close the response on OAuthAsyncRequestCallback.onCompleted(response: T)
     *
     * @param key of Response
     *
     * @return Type of Any
     * @since 0.37.2
     */
    func convert(response: Response): Any
}
