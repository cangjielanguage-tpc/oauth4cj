## OAuth 库

### 介绍
是一种授权协议，应用于允许第三方程序通过访问令牌访问受保护的资源，而无需暴露用户的凭据。OAuth协议的主要就是种授权协议，就是在用户不将服务提供商的账号密码交给第三方应用的场景下，让第三方的应用有权限去访问用户存放在服务提供商上的一些资源。

### 1 提供 base64 编码功能--base64

##### 1.1 主要接口

##### 1.1.1 class Base64
直接包装标准库 base64 库。

```cangjie
public open class Base64Utils {
    
    /**
     * 使用 Base64 编码方案将指定的字节数组编码为字符串。--直接封装toBase64String
     * 参数 bytes - 要编码的字节数组
     * 返回值 String - 包含结果 Base64 编码字符的字符串
     */
    public static func encode(bytes: Array<UInt8>): String
}

```

#### 1.2 示例

```cangjie
from OAuth import utils.*
main(): Int64 {
    let bytes: Array<UInt8> = "Hello World".toUtf8Array()
    let encoded: String = "SGVsbG8gV29ybGQ="
    let str: String = Base64Utils.encode(bytes)
    println("encoded == str: ${encoded == str}")
    return 0
}
```

执行结果如下：

```shell
encoded == str: true
```

### 2 extractors
从OAuthRequest中提取url编码的基字符串 --BaseStringExtractor
从OAuthRequest中提取基字符串的简单命令对象

生成OAuth“Authorization”Http标头，以作为签名包含在请求中。  --HeaderExtractor
生成OAuth授权标头以包含在请求中的简单命令对象。

从Http Response的内容中提取具体类型的令牌  --TokenExtractor
从字符串中提取具体令牌的简单命令对象

#### 2.1 从 OAuthRequest 中提取 url 编码的基字符串  --BaseStringExtractor
将OAuthRequest中的信息，使用特定的编码方案将字符串转换为application/x-wwww-form-urlencoded格式的字符串。
Verb + URL + params

##### 2.1.1 主要接口

##### 2.1.1.1 interface BaseStringExtractor

```cangjie
/* 从 OAuthRequest 中提取基字符串的简单命令对象 */
public interface BaseStringExtractor {
    /*
    * 从 OAuthRequest 中提取 url 编码的基字符串
    * 参数 request - 要请求的服务
    * 返回值 String - 返回 url 编码的基础字符串
    */
    func extract(request: OAuthRequest): String
}
```

##### 2.1.1.2 class BaseStringExtractorImpl

实现接口 BaseStringExtractor 中的函数。

```cangjie
/**
 * BaseStringExtractor的默认实现。符合OAuth 1.0a
 * https://tools.ietf.org/html/rfc5849#section-3.4.1.1
 */
public class BaseStringExtractorImpl <: BaseStringExtractor { }
```

#### 2.2 生成 OAuth 'Authorization' Http 标头，以作为签名包含在请求中。  --HeaderExtractor
将 OAuthRequest 中的 oauthParameters 和 realm(如果 realm 不为空)，转为特定要求的字符串。
其中 oauthParameters 的 value 值，使用特定的编码方案将字符串转换为application/x-wwww-form-urlencoded格式的字符串

##### 2.2.1 主要接口

##### 2.2.1.1 interface HeaderExtractor

```cangjie
public interface HeaderExtractor {
    /*
    * 生成 OAuth 'Authorization' Http 标头，以作为签名包含在请求中。
    * 参数 request - AbstractRequest 检查并生成标头
    * 返回值 String - 返回 Http 标头值
    */
    func extract(request: OAuthRequest): String 
}
```

##### 2.2.1.2 class HeaderExtractorImpl
实现接口 HeaderExtractor 中的函数。

```cangjie
public class HeaderExtractorImpl <: HeaderExtractor { }
```

#### 2.3 从Http Response的内容中提取具体类型的令牌  --TokenExtractor
从 Response 的 body 中提取 token 信息，生成 token 令牌。--OAuth1Token
从 Response 的 body 中提取 token 信息，生成 token 令牌。--OAuth2AccessToken
从 Response 的 body 中提取 token 信息，生成 token 令牌。--OAuth2AccessToken
Response 的 code 不是200，从 Response 的 body 中提取 OAuth2AccessTokenErrorResponse 信息，抛出 OAuth2AccessTokenErrorResponse 异常。

##### 2.3.1 主要接口

##### 2.3.1.1 interface TokenExtractor
从字符串中提取具体令牌的简单命令对象。

```cangjie
public interface TokenExtractor<T> where T <: Token {

    /**
     * 从 Http Response 的内容中提取具体类型的令牌
     * 参数 response - 整个响应
     * 返回值 T - OAuth访问令牌
     * 异常 IOException - 在从响应中获取正文时遇到问题时抛出IOException
     */
    func extract(response: Response): T
}
```

##### 2.3.1.2 class AbstractOAuth1TokenExtractor
OAuth 1.0a的TokenExtractor的抽象基础实现。提取访问令牌和请求令牌的过程类似，因此该类可以同时完成这两项任务。
实现接口 TokenExtractor 中的函数。T 的约束为 OAuth1Token。

```cangjie
public abstract class AbstractOAuth1TokenExtractor<T> <: TokenExtractor<T> & where T <: OAuth1Token> { }
```

##### 2.3.1.3 class OAuth1AccessTokenExtractor

```cangjie
public class OAuth1AccessTokenExtractor <: AbstractOAuth1TokenExtractor<OAuth1AccessToken> {
    /**
     * 创建 OAuth1AccessTokenExtractor 实例。
     */
    public static func instance(): OAuth1AccessTokenExtractor
}
```

##### 2.3.1.4 class OAuth2AccessTokenExtractor

```cangjie
public class OAuth2AccessTokenExtractor <: TokenExtractor<OAuth2AccessToken> {
    /**
     * 创建 OAuth2AccessTokenExtractor 实例。
     */
    public static func instance(): OAuth2AccessTokenExtractor
}
```

##### 2.3.1.5 class OAuth2AccessTokenJsonExtractor

```cangjie
public class OAuth2AccessTokenJsonExtractor <: AbstractJsonExtractor & TokenExtractor<OAuth2AccessToken> {
    /**
     * 创建 OAuth2AccessTokenJsonExtractor 实例。
     */
    public static func instance(): OAuth2AccessTokenJsonExtractor
    
    /**
     * 相关文件：https://tools.ietf.org/html/rfc6749#section-5.2
     * 参数 response - Response 数据类型
     * 异常 IOException - 在从响应中获取正文时遇到问题时抛出IOException
     */
    public func generateError(response: Response): Unit
}
```

#### 2.4 示例

```cangjie
```

执行结果如下：

```shell
```

### 3 HttpClient

HttpClient 提供同步和异步调用接口。--调用 okhttp 或者 标注库 http？
正则比较，并从字符串中获取指定信息。
提供 MultipartPayload 数据类型创建，字段补充，数据存储，读取并封装成特定类型。

#### 3.1 主要接口

##### 3.1.1 class JDKHttpClient

```cangjie
public class JDKHttpClient <: HttpClient {
    /**
     * 创建 JDKHttpClient 实例。
     */
    public init()
    
    /**
     * 根据参数 clientConfig，创建 JDKHttpClient 实例。
     * 参数 clientConfig - JDKHttpClientConfig 数据结构
     */
    public init(clientConfig: JDKHttpClientConfig)
}
```

##### 3.1.2 interface HttpClient

```cangjie
public interface HttpClient <: Closeable {
    func executeAsync(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
            bodyContents: Array<UInt8>, callback: OAuthAsyncRequestCallback<T>, converter: OAuthRequest.ResponseConverter<T>): Future<T>

    func executeAsync(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
            bodyContents: MultipartPayload, callback: OAuthAsyncRequestCallback<T>,
            converter: OAuthRequest.ResponseConverter<T>): Future<T>

    func executeAsync(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
            bodyContents: String, callback: OAuthAsyncRequestCallback<T>, converter: OAuthRequest.ResponseConverter<T>): Future<T>

    func executeAsync(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
            bodyContents: File, callback: OAuthAsyncRequestCallback<T>, converter: OAuthRequest.ResponseConverter<T>): Future<T>

    func execute(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String, bodyContents: Array<UInt8>): Response 
    func execute(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String, bodyContents: MultipartPayload): Response 
    func execute(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String, bodyContents: String): Response 
    func execute(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String, bodyContents: File): Response 
}
```

#### 3.2 MultipartUtils

##### 3.2.1.1 class MultipartUtils

```cangjie
public class MultipartUtils {
    public static func checkBoundarySyntax(boundary: String): Unit
    public static func parseBoundaryFromHeader(contentTypeHeader: String): String
    public static func generateDefaultBoundary(): String
    public static func getPayload(multipartPayload: MultipartPayload): ByteArrayOutputStream
}
```

##### 3.2.1.2 class MultipartPayload

```cangjie
public class MultipartPayload <: BodyPartPayload {
    public init()
    public init(boundary: String)
    public init(subtype: String, boundary: String)
    public init(headers: HashMap<String, String>)
    public init(boundary: String, headers: HashMap<String, String>)
    public init(subtype: String, boundary: String, headers: HashMap<String, String>)

    public func addBodyPart(bodyPartPayload: BodyPartPayload ): Unit
    public func addBodyPart(multipartPayload: MultipartPayload ): Unit
    public func getBodyParts(): ArrayList<BodyPartPayload>
    public func String getBoundary(): String
    public func String getPreamble(): String
    public func setPreamble(preamble: String): Unit
    public func getEpilogue(): String
    public func setEpilogue(epilogue: String): Unit
}
```

##### 3.2.1.3 class BodyPartPayload

```cangjie
public abstract class BodyPartPayload {
    public init()
    public BodyPartPayload(contentType: String)
    public BodyPartPayload(headers: HashMap<String, String>)
    public func getHeaders(): HashMap<String, String>
}
```

#### 3.3 示例

```cangjie
```

执行结果如下：

```shell
```

### 4 model
提供 OAuth HttpRequest的表示形式，OAuthRequest。
ParameterList 和 Parameter 数据结构。
提供 OAuth（1和2）令牌（请求或访问令牌）Token；
HTTP响应，Response：此响应可能包含HttpUrlConnection的非空正文流。如果是这样，这个机构必须关闭，以避免资源泄漏。使用getBody（）或close（）关闭主体。

#### 4.1 主要接口

##### 4.1.1 class OAuthRequest
OAuth HttpRequest的表示形式。

```cangjie
public class OAuthRequest {
    public init(verb: Verb, url: String)
    public func addOAuthParameter(key: String, value: String): Unit

    public func getOauthParameters(): HashMap<String, String>
    public func setRealm(String realm): Unit
    public func getRealm(): String
    public func getCompleteUrl(): String
    public func addHeader(key: String, value: String): Unit
    public func addBodyParameter(key: String, value: String): Unit
    public func addQuerystringParameter(key: String, value: String): Unit
    public func addParameter(key: String, value: String): Unit
    public func getMultipartPayload(): MultipartPayload
    public func setMultipartPayload(multipartPayload: MultipartPayload): Unit
    public func initMultipartPayload(): Unit
    public func initMultipartPayload( boundary: String): Unit
    public func initMultipartPayload(String subtype, boundary: String): Unit
    public func initMultipartPayload(headers: HashMap<String, String>): Unit
    public func initMultipartPayload( boundary: String, headers: HashMap<String, String>): Unit
    public func initMultipartPayload(String subtype, boundary: String, headers: HashMap<String, String>): Unit
    public func setBodyPartPayloadInMultipartPayload(bodyPartPayload: BodyPartPayload): Unit
    public func addBodyPartPayloadInMultipartPayload(bodyPartPayload: BodyPartPayload): Unit
    public func setPayload(payload: String): Unit

    public func setPayload(payload: Array<UInt8>): Unit
    public func setPayload(payload: File): Unit
    public func getQueryStringParams(): ParameterList
    public func getBodyParams(): ParameterList
    public func getUrl(): String
    public func getSanitizedUrl(): String
    public func getStringPayload(): String
    public func getByteArrayPayload(): Array<UInt8>
    public func getFilePayload(): File

    public func toString(): String

    public func getVerb(): Verb
    public func getHeaders(): HashMap<String, String>
    public func getCharset(): String
    public func setCharset(charsetName: String): Unit

    public interface ResponseConverter<T> {
        func convert(response: Response): T
    }

}

```

##### 4.1.2 class ParameterList

```cangjie
public class ParameterList {
    public init()
    public init(map: HashMap<String, String>)
    
    public func add(key: String, value: String): Unit
    public func appendTo(url: String): String
    public func asOauthBaseString(): String
    public func asFormUrlEncodedString(): String
    public func addAll(other: ParameterList): Unit
    public func addQuerystring(queryString: String): Unit
    public func contains(param: Parameter): Bool
    public func size(): Int64
    public func getParams(): ArrayList<Parameter>
    public func sort(): ParameterList
}
```

##### 4.1.3 class OAuth1AccessToken
表示 OAuth 1 访问令牌 http://tools.ietf.org/html/rfc5849#section-2.3

```cangjie
public class OAuth1AccessToken <: OAuth1Token {
    public init(token: String, tokenSecret: String)
    public init(token: String, tokenSecret: String, rawResponse: String)
}
```

##### 4.1.4 class OAuth1Token
表示抽象OAuth 1令牌（请求或访问令牌）

```cangjie
public abstract class OAuth1Token <: Token {
    public init(token: String, tokenSecret: String, rawResponse: String)
    public func getToken(): String
    public func getTokenSecret(): String
    public func isEmpty(): Bool
}
```

##### 4.1.5 class Token
表示抽象OAuth（1和2）令牌（请求或访问令牌）

```cangjie
public abstract class Token <: Serializable {
    public func getRawResponse(): String
    public func getParameter(parameter: String): String
}
```

##### 4.1.6 class OAuth2Authorization
表示授权响应 http://tools.ietf.org/html/rfc6749#section-4.1.2
如果资源所有者授予访问请求，授权服务器将发出一个授权代码，并通过使用“application/x-www-form-urlencoded”格式将以下参数添加到重定向URI的查询组件来将其传递给客户端。

```cangjie
public class OAuth2Authorization {
    public func getCode(): String
    public func setCode(String code): Unit
    public func getState(): String
    public func setState(String state): Unit
}
```

### 5 oauth
Builder模式的实现，具有创建OAuthService的流畅接口.
提供 OAuth（1和2）OAuthService 的接口，实现：HttpClient创建，添加回调url，配置api名称/密钥，HttpClient 同步/异步接口调用等。
获取访问/请求 token

#### 5.1 主要接口

##### 5.1.1 class BearerSignatureURIQueryParameter

```cangjie
public class BearerSignatureURIQueryParameter implements BearerSignature {
    public static func instance(): BearerSignatureURIQueryParameter
}
```

##### 5.1.2 class OAuth20Service

```cangjie
public class OAuth20Service <: OAuthService {
    public init(DefaultApi20 api, apiKey: String, apiSecret: String, callback: String, defaultScope: String,
            responseType: String, debugStream: OutputStream, userAgent: String, httpClientConfig: HttpClientConfig,
            httpClient: HttpClient)

    public func signRequest(accessToken: String, request: OAuthRequest): Unit
    public func signRequest(accessToken: OAuth2AccessToken, request: OAuthRequest): Unit

    public func getAuthorizationUrl(): String
    public func getAuthorizationUrl(state: String): String
    public func getAuthorizationUrl(additionalParams: HashMap<String, String>): String
    public func getAuthorizationUrl(pkce: PKCE): String
    public func createAuthorizationUrlBuilder(): AuthorizationUrlBuilder
    public func getApi(): DefaultApi20
    public func extractAuthorization(redirectLocation: String): OAuth2Authorization
    public func getResponseType(): String
    public func getDefaultScope(): String

    public func getAccessTokenAsync(code: String): Future<OAuth2AccessToken>
    public func getAccessTokenAsync(params: AccessTokenRequestParams): Future<OAuth2AccessToken>
    public func getAccessToken(code: String): OAuth2AccessToken
    public func getAccessToken(params: AccessTokenRequestParams): OAuth2AccessToken
    public func getAccessToken(params: AccessTokenRequestParams,
            callback: OAuthAsyncRequestCallback<OAuth2AccessToken>): Future<OAuth2AccessToken>
    public func getAccessToken(code: String,
            callback: OAuthAsyncRequestCallback<OAuth2AccessToken>): Future<OAuth2AccessToken>

    public func refreshAccessTokenAsync(refreshToken: String): Future<OAuth2AccessToken>
    public func refreshAccessTokenAsync(refreshToken: String, scope: String): Future<OAuth2AccessToken>
    public func refreshAccessToken(refreshToken: String): OAuth2AccessToken
    public func refreshAccessToken(refreshToken: String, scope: String): OAuth2AccessToken
    public func refreshAccessToken(refreshToken: String,
            callback: OAuthAsyncRequestCallback<OAuth2AccessToken>): Future<OAuth2AccessToken>
    public func refreshAccessToken(refreshToken: String, scope: String,
            callback: OAuthAsyncRequestCallback<OAuth2AccessToken>): Future<OAuth2AccessToken>
    public func getAccessTokenPasswordGrant(username: String, password: String): OAuth2AccessToken
    public func getAccessTokenPasswordGrant(username: String, password: String, scope: String): OAuth2AccessToken
    public func getAccessTokenPasswordGrantAsync(username: String, password: String): Future<OAuth2AccessToken>
    public func getAccessTokenPasswordGrantAsync(username: String, password: String, scope: String): Future<OAuth2AccessToken>
    public func getAccessTokenPasswordGrantAsync(username: String, password: String,
            callback: OAuthAsyncRequestCallback<OAuth2AccessToken>): Future<OAuth2AccessToken>
    public func getAccessTokenPasswordGrantAsync(username: String, password: String, scope: String,
            callback: OAuthAsyncRequestCallback<OAuth2AccessToken>): Future<OAuth2AccessToken>
    public func getAccessTokenClientCredentialsGrantAsync(): Future<OAuth2AccessToken>
    public func getAccessTokenClientCredentialsGrantAsync(scope: String): Future<OAuth2AccessToken>
    public func getAccessTokenClientCredentialsGrant(): OAuth2AccessToken
    public func getAccessTokenClientCredentialsGrant(scope: String): OAuth2AccessToken
    public func getAccessTokenClientCredentialsGrant(
            callback: OAuthAsyncRequestCallback<OAuth2AccessToken>): Future<OAuth2AccessToken>
    public func getAccessTokenClientCredentialsGrant(scope: String,
            callback: OAuthAsyncRequestCallback<OAuth2AccessToken>): Future<OAuth2AccessToken>
    public func revokeTokenAsync(tokenToRevoke: String): Future<Void>
    public func revokeTokenAsync(tokenToRevoke: String, tokenTypeHint: TokenTypeHint): Future<Void>
    public func revokeToken(tokenToRevoke: String): Unit
    public func revokeToken(tokenToRevoke: String, tokenTypeHint: TokenTypeHint): Unit
    public func revokeToken(tokenToRevoke: String, callback: OAuthAsyncRequestCallback<Void>): Future<Void>
    public func revokeToken(tokenToRevoke: String, callback: OAuthAsyncRequestCallback<Void>,
            tokenTypeHint: TokenTypeHint): Future<Void>
    public func getDeviceAuthorizationCodes(): DeviceAuthorization
    public func getDeviceAuthorizationCodes(scope: String): DeviceAuthorization
    public func getDeviceAuthorizationCodes(
            OAuthAsyncRequestCallback<DeviceAuthorization> callback): Future<DeviceAuthorization>
    public func getDeviceAuthorizationCodes(scope: String,
            OAuthAsyncRequestCallback<DeviceAuthorization> callback): Future<DeviceAuthorization>
    public func getDeviceAuthorizationCodesAsync(): Future<DeviceAuthorization>
    public func getDeviceAuthorizationCodesAsync(scope: String): Future<DeviceAuthorization>
    public func getAccessTokenDeviceAuthorizationGrant(deviceAuthorization: DeviceAuthorization): OAuth2AccessToken
    public func getAccessTokenDeviceAuthorizationGrant(deviceAuthorization: DeviceAuthorization,
            callback: OAuthAsyncRequestCallback<OAuth2AccessToken>): Future<OAuth2AccessToken>
    public func getAccessTokenDeviceAuthorizationGrantAsync(
            deviceAuthorization: DeviceAuthorization): Future<OAuth2AccessToken>
    public func pollAccessTokenDeviceAuthorizationGrant(deviceAuthorization: DeviceAuthorization): OAuth2AccessToken
}

```

##### 5.1.3 class OAuth10aService

```cangjie
public class OAuth10aService <: OAuthService {//request: OAuthRequest
    public init(api: DefaultApi10a , apiKey: String, apiSecret: String, callback: String, scope: String,
            debugStream: OutputStream, userAgent: String, httpClientConfig: HttpClientConfig, httpClient: HttpClient)
    public func getRequestToken() OAuth1RequestToken
    public func getRequestTokenAsync(): Future<OAuth1RequestToken>
    public func getRequestTokenAsync(callback: OAuthAsyncRequestCallback<OAuth1RequestToken>): Future<OAuth1RequestToken>
    public func getAccessToken(requestToken: OAuth1RequestToken, oauthVerifier: String): OAuth1AccessToken
    public func getAccessTokenAsync(requestToken: OAuth1RequestToken, oauthVerifier: String): Future<OAuth1AccessToken>
    public func getAccessTokenAsync(requestToken: OAuth1RequestToken, oauthVerifier: String,
            callback: OAuthAsyncRequestCallback<OAuth1AccessToken>): Future<OAuth1AccessToken>
    public func signRequest(token: OAuth1AccessToken, request: OAuthRequest): Unit
    public func getAuthorizationUrl(requestToken: OAuth1RequestToken): String
    public func getApi(): DefaultApi10a
}
```

##### 5.1.4 class OAuthService

```cangjie
public abstract class OAuthService <: Closeable {
    public init(apiKey: String, apiSecret: String, callback: String, debugStream: OutputStream,
            userAgent: String, httpClientConfig: HttpClientConfig, httpClient: HttpClient)
    public func getApiKey(): String
    public func getApiSecret(): String
    public func getCallback(): String
    public abstract func getVersion(): String
    public func executeAsync(request: OAuthRequest): Future<Response>
    public func execute(request: OAuthRequest, OAuthAsyncRequestCallback<Response> callback): Future<Response>
    public func execute(request: OAuthRequest, OAuthAsyncRequestCallback<R> callback,
            OAuthRequest.ResponseConverter<R> converter): Future<R>
    public func execute(request: OAuthRequest):  Response
    public func log(String message): Unit
    public func log(String messagePattern, Object... params): Unit
}
```

### 6 pkce
用于通过OAuth公共客户端实现代码交换的证明密钥。

#### 6.1 主要接口

##### 6.1.1 class PKCE
用于保存代码挑战、代码挑战方法和代码验证 https://tools.ietf.org/html/rfc7636

```cangjie
public class PKCE {
    public func getCodeChallenge(): String
    public func setCodeChallenge(codeChallenge: String): Unit
    public func getCodeChallengeMethod(): PKCECodeChallengeMethod
    public func setCodeChallengeMethod(codeChallengeMethod: PKCECodeChallengeMethod): Unit
    public func getCodeVerifier(): String
    public func setCodeVerifier(codeVerifier: String): Unit
    public func getAuthorizationUrlParams(): HashMap<String, String>
}

```

##### 6.1.2 class PKCEService
用于通过OAuth公共客户端实现代码交换的证明密钥 https://tools.ietf.org/html/rfc7636

```cangjie
public class PKCEService {
    public init(numberOFOctets: Int64)
    public init()
    public static func defaultInstance(): PKCEService
    public func generatePKCE(): PKCE
    public func generatePKCE(randomBytes: Array<UInt8>): PKCE
}
```

##### 6.1.3 enum PKCECodeChallengeMethod

```cangjie
public enum PKCECodeChallengeMethod {
    |S256
    |PLAIN
    public abstract func transform2CodeChallenge(String codeVerifier): String
}
```

### 7 services
对基字符串进行签名，返回OAuth签名--SignatureService
Unix时间戳生成器。此类对于测试中的存根非常有用--TimestampService
SignatureService 的 HMAC-SHA1实现--HMACSha1SignatureService
使用RSA-SHA1算法的签名服务。--RSASha1SignatureService
使用纯java类实现TimestampService。--TimestampServiceImpl

#### 7.1 主要接口

##### 7.1.1 interface TimestampService
Unix时间戳生成器。此类对于测试中的存根非常有用。

```cangjie
public interface TimestampService {
    func getTimestampInSeconds(): String 
    func getNonce(): String 
}
```

##### 7.1.2 class TimestampServiceImpl

```cangjie
public class TimestampServiceImpl implements TimestampService {
    public TimestampServiceImpl()
}
```

##### 7.1.3 interface SignatureService

```cangjie
public interface SignatureService {
    func getSignature(baseString: String, apiSecret: String, tokenSecret: String): String 
    func getSignatureMethod(): String 
}
```

##### 7.1.4 class RSASha1SignatureService

```cangjie
public class RSASha1SignatureService implements SignatureService {
    public RSASha1SignatureService(privateKey: PrivateKey)
}
```

##### 7.1.5 class HMACSha1SignatureService

```cangjie
public class HMACSha1SignatureService implements SignatureService { }
```

### 8 utils
OAuthEncoder 提供 URL 编解码功能；
处理Streams的工具：1. 以UTF-8编码字符串的形式返回流内容； 2. 从gzip流返回字符串内容。

#### 8.1 主要接口

##### 8.1.1 class OAuthEncoder

```cangjie
public abstract class OAuthEncoder {
    
    /**
     * 使用特定的编码方案将字符串转换为application/x-wwww-form-urlencoded格式。
     * 此方法的行为与encode（Strings，Charset Charset）相同，只是它将使用给定的编码名称查找字符集 "UTF-8"。
     * 参数 bytes - 要编码的字符串
     * 返回值 String - 返回编码后的字符串
     */
    public static func encode(plain: String): String
    public static func decode(encoded: String): String
}
```

##### 8.1.2 class Preconditions

```cangjie
public abstract class Preconditions {
    public static func checkNotNull(object: Object, errorMsg: String): Unit
    public static func checkEmptyString(string: String, errorMsg: String): Unit
    public static Bool hasText(str: String): Bool
}
```

##### 8.1.3 class StreamUtils

```cangjie
public abstract class StreamUtils {
    public static func getStreamContents(is: InputStream): String
    public static func getGzipStreamContents(is: InputStream): String
}

```


### 9 builder
Builder模式的实现，具有创建OAuthService的流畅接口

OAuth协议1.0a/2.0版的默认实现。
该类旨在通过API的具体实现进行扩展，提供端点和端点http请求类型。
如果您的Api正确地遵循1.0a/2.0协议，您只需要扩展这个类并为端点定义getter。
如果你的Api做了一些不同的事情，你可以重写不同的提取器或服务，以便对流程进行微调。请阅读接口的javadocs以了解要做什么。

#### 9.1 api

##### 9.1.1 class DefaultApi10a
OAuth协议1.0a版的默认实现
该类旨在通过API的具体实现进行扩展，提供端点和端点http谓词。
如果您的Api正确地遵循1.0a协议，您只需要扩展这个类并为端点定义getter。
如果你的Api做了一些不同的事情，你可以重写不同的提取器或服务，以便对流程进行微调。请阅读接口的javadocs以了解要做什么。

```cangjie
public abstract class DefaultApi10a {
    public func getAccessTokenExtractor(): TokenExtractor<OAuth1AccessToken>
    public func getBaseStringExtractor(): BaseStringExtractor
    public func getHeaderExtractor(): HeaderExtractor
    public func getRequestTokenExtractor(): TokenExtractor<OAuth1RequestToken>
    public func getSignatureService(): SignatureService
    public func getSignatureType(): OAuth1SignatureType
    public func getTimestampService(): TimestampService
    public func getAccessTokenVerb(): Verb
    public func getRequestTokenVerb(): Verb
    public func getRequestTokenEndpoint(): String
    public func getAccessTokenEndpoint(): String
    public func String getAuthorizationUrl(requestToken: OAuth1RequestToken): String
    public func createService(apiKey: String, apiSecret: String, callback: String, scope: String,
            debugStream: OutputStream, userAgent: String, httpClientConfig: HttpClientConfig, httpClient: HttpClient): OAuth10aService
    public func isEmptyOAuthTokenParamIsRequired(): Bool
}
```

##### 9.1.2 class DefaultApi20

OAuth协议2.0版的默认实现
该类旨在通过API的具体实现进行扩展，提供端点和端点http谓词。
如果您的API正确地遵循2.0协议，您只需要扩展这个类并为端点定义getter。
如果您的API做的事情稍有不同，您可以覆盖不同的提取器或服务，以便对流程进行微调。请阅读接口的javadocs以了解要做什么。
```cangjie
public abstract class DefaultApi20 {

    /**
     * 返回访问令牌提取器。
     * 返回值 TokenExtractor<OAuth2AccessToken> - 返回访问令牌提取器
     */
    public func getAccessTokenExtractor(): TokenExtractor<OAuth2AccessToken>

    /**
     * 返回访问令牌端点的 HTTP 请求类型（默认为 POST）
     * 返回值 Verb - 访问令牌端点的 HTTP 请求类型。
     */
    public func getAccessTokenVerb(): Verb

    /**
     * 返回接收访问令牌请求的URL。
     * 返回值 String - 访问令牌URL。
     */
    public func getAccessTokenEndpoint(): String

    /**
     * 返回接收刷新令牌请求的URL。
     * 返回值 String - 返回接收刷新令牌请求的URL。
     */
    public func getRefreshTokenEndpoint(): String

    /**
     * 返回接收撤销令牌请求的URL。
     * 如RFC 7009 OAuth 2.0令牌撤销中所述，
     * 它允许客户端通知授权服务器不再需要先前获得的刷新或访问令牌。
     * "https://tools.ietf.org/html/rfc7009"
     * 返回值 String - 返回接收撤销令牌请求的URL。
     */
    public func getRevokeTokenEndpoint(): String

    /**
     * 返回应该重定向用户以验证应用程序的URL。
     * 参数 responseType - String 数据类型
     * 参数 apiKey - String 数据类型
     * 参数 callback - String 数据类型
     * 参数 scope - String 数据类型
     * 参数 state - String 数据类型
     * 参数 additionalParams - HashMap<String, String> 数据类型，要添加到URL的任何其他GET参数
     * 返回值 String - 应该重定向用户的URL。
     */
    public func getAuthorizationUrl(responseType: String, apiKey: String, callback: String, scope: String, state: String,
            additionalParams: HashMap<String, String>):  String

    /**
     * 根据参数，创建 OAuth20Service 对象。
     * 参数 apiKey - String 数据类型，api 的 key
     * 参数 apiSecret - String 数据类型，api 的 Secret
     * 参数 callback - String 数据类型，回调用的信息
     * 参数 defaultScope - String 数据类型
     * 参数 responseType - String 数据类型
     * 参数 debugStream - OutputStream 数据类型，debug 输出流
     * 参数 userAgent - String 数据类型，用户代理
     * 参数 httpClientConfig - HttpClientConfig 数据类型
     * 参数 httpClient - HttpClient 数据类型
     * 返回值 OAuth20Service - 返回创建的 OAuth20Service 对象。
     */
    public func createService(apiKey: String, apiSecret: String, callback: String, defaultScope: String,
            responseType: String, debugStream: OutputStream, userAgent: String, httpClientConfig: HttpClientConfig,
            httpClient: HttpClient): OAuth20Service

    public func getBearerSignature(): BearerSignature

    public func getClientAuthentication(): ClientAuthentication

    /**
     * 返回设备授权端点。
     * RFC 8628 OAuth 2.0设备授权，
     * "https://tools.ietf.org/html/rfc8628"
     * 返回值 String - 设备授权端点。
     */
    public func getDeviceAuthorizationEndpoint(): String

    public func getDeviceAuthorizationExtractor(): DeviceAuthorizationJsonExtractor
}
```

##### 9.1.3 enum OAuth1SignatureType

```cangjie
public enum OAuth1SignatureType {
    |HEADER
    |QUERY_STRING
}
```

#### 9.2 builder

##### 9.2.1.1 class ScopeBuilder

OAuth2.0范围生成器。它允许逐个指定多个作用域。它将在单个空格分隔的字符串中组合它们。
OAuth 2.0标准指定空间作为作用域的分隔符(https://tools.ietf.org/html/rfc6749#section-3.3）。

```cangjie
public class ScopeBuilder {

    /**
     * 创建 ScopeBuilder 实例。
     */
    public init() { }
    
    /**
     * 根据 scope，创建 ScopeBuilder 实例。
     * 参数 scope - String 数据类型
     */
    public init(scope: String)
    
    /**
     * 根据 scopes，创建 ScopeBuilder 实例。
     * 参数 scopes - Array<String> 数据类型
     */
    public init(scopes: Array<String>)
    
    /**
     * 根据 scopes，创建 ScopeBuilder 实例。
     * 参数 scopes - Collection<String> 数据类型
     */
    public init(scopes: Collection<String>)

    /**
     * 添加 scope，并返回当前 ScopeBuilder 实例。
     * 参数 scope - String 数据类型
     */
    public func withScope(scope: String): ScopeBuilder

    /**
     * 添加 scopes，并返回当前 ScopeBuilder 实例。
     * 参数 scopes - Array<String> 数据类型
     */
    public func withScopes(scopes: Array<String>): ScopeBuilder

    /**
     * 添加 scopes，并返回当前 ScopeBuilder 实例。
     * 参数 scopes - Collection<String> 数据类型
     */
    public func withScopes(scopes: Collection<String>): ScopeBuilder

    public func build(): String
}
```

##### 9.2.1.2 interface ServiceBuilderCommon
Builder模式的实现，具有创建OAuthService的流畅接口

```cangjie
public interface ServiceBuilderCommon {
    func callback(callback: String): ServiceBuilderCommon
    func apiKey(apiKey: String): ServiceBuilderCommon
    func apiSecret(apiSecret: String): ServiceBuilderCommon
    func apiSecretIsEmptyStringUnsafe(): ServiceBuilderCommon
    func httpClientConfig(httpClientConfig: HttpClientConfig): ServiceBuilderCommon
    func httpClient(httpClient: HttpClient): ServiceBuilderCommon
    func userAgent(userAgent: String): ServiceBuilderCommon
    func debugStream(debugStream: OutputStream): ServiceBuilderCommon
    func debug(): ServiceBuilderCommon
}
```

##### 9.2.1.3 interface ServiceBuilderOAuth10a
```cangjie
public interface ServiceBuilderOAuth10a <: ServiceBuilderCommon {
    func withScope(scope: String): ServiceBuilderOAuth10a
    func build(api: DefaultApi10a): OAuth10aService
}
```

##### 9.2.1.4 interface ServiceBuilderOAuth20
```cangjie
public interface ServiceBuilderOAuth20 extends ServiceBuilderCommon {
    func responseType(responseType: String): ServiceBuilderOAuth20
    func defaultScope(defaultScope: String): ServiceBuilderOAuth20
    func defaultScope(scopeBuilder: ScopeBuilder): ServiceBuilderOAuth20
    func build(api:DefaultApi20): OAuth20Service
}
```

##### 9.2.1.5 class ServiceBuilder
实现 ServiceBuilderOAuth10a 和 ServiceBuilderOAuth20 接口中的函数。

```cangjie
public class ServiceBuilder <: ServiceBuilderOAuth10a & ServiceBuilderOAuth20 {
    
    /**
     * 根据 apiKey，创建 ServiceBuilder 实例。
     * 参数 apiKey - String 数据类型
     */
    public init(apiKey: String)
}
```

#### 9.3 示例

执行结果如下：

```shell

```
