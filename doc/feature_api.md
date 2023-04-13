
## OAuth4cj 库

### 介绍
OAuth4cj 支持协议 OAuth1.0a 和 OAuth2.0，允许第三方程序通过访问令牌访问受保护的资源，而无需暴露用户的凭据。支持授权码模式，简化模式，密码模式，客户端模式四种模式。

### 1 支持授权码模式

前置条件：NA     
场景：    
1.通过客户端的后台服务器，与服务提供商的认证服务进行互动;通过授权服务器作为中介来获取，授权认证的过程也是资源所有者直接通过授权服务器进行身份认证。     
约束： 只支持UTF-8字符编码     
性能： NA    
可靠性： NA  

#### 1.1 提供 base64 编码功能
直接封装标准库 base64 库。

##### 1.1.1 主要接口

```cangjie
/**
 * base64编码工具类
 */
public open class Base64Utils {
    
    /**
     * 使用 Base64 编码方案将指定的字节数组编码为字符串。
     *
     * @参数 bytes - 要编码的字节数组
     * @返回值 String - 包含结果 Base64 编码字符的字符串
     */
    public static func encode(bytes: Array<UInt8>): String
}
```

##### 1.1.2 示例

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

#### 1.2 提供 URL 编解码功能和处理Streams的工具

以UTF-8编码字符串的形式返回流内容，从gzip流返回字符串内容。

##### 1.2.1 主要接口

```cangjie
/**
 * URL编解码类
 */
public class URLEncoder {
    /**
     * 使用特定的编码方案将字符串转换为application/x-www-form-urlencoded格式
     * 当前只支持UTF-8
     *
     * @参数 s 要编码的字符串
     * @参数 enc 支持的字符编码的名称
     * @返回值 String 编码后的字符串
     */
    public static func encode(s: String, enc: String): String
    
    /**
     * 使用特定的字符集将字符串转换为application/x-www-form-urlencoded格式
     * 该方法使用提供的字符集来获取不安全字符的字节，当前只支持UTF-8
     *
     * @参数 s 要编码的字符串
     * @返回值 String 编码后的字符串
     */
    public static func encode(s: String): String
    
    /**
     * 使用特定的编码方案解码application/x-www-form-urlencoded字符串
     * 当前只支持UTF-8
     *
     * @参数 s 要解码的字符串
     * @参数 enc 支持的字符解码的名称
     * @返回值 String 解码后的字符串
     */
    public static func decode(s: String, enc: String): String
    
    /**
     * 使用特定的字符集解码application/x-www-form-urlencoded字符串
     * 当前只支持UTF-8
     *
     * @参数 s 要解码的字符串
     * @返回值 String 解码后的字符串
     */
    public static func decode(s: String): String
} 
```

```cangjie
/**
 * OAuth编解码工具类
 */
public class OAuthEncoder {
    /**
     * 使用特定的字符集将字符串转换为application/x-www-form-urlencoded格式
     * 当前只支持UTF-8
     *
     * @参数 s 要编码的字符串
     * @返回值 String 编码后的字符串
     */
    public static func encode(src: String): String
    
    /**
     * 使用特定的编码方案解码application/x-www-form-urlencoded字符串
     * 当前只支持UTF-8
     *
     * @参数 s 要解码的字符串
     * @返回值 String 解码后的字符串
     */
    public static func decode(encoded: String): String
}
```

```cangjie
/**
 * Stream流工具类
 */
public class StreamUtils {
    /**
     * 以UTF-8编码的字符串形式返回流内容
     *
     * @参数 ins 输入流
     * @参数 isGzipStream 输入流是否为GzipStream，默认为false
     * @返回值 String 返回UTF-8编码的字符串
     */
    public static func getStreamContents(ins: InputStream, isGzipStream!: Bool = false): String
    
    /**
     * 返回gzip流中的字符串内容
     * 从要解压缩的InputStream流中读取并解压缩数据，并将其转换为字符串格式
     *
     * @参数 ins 输入流
     * @返回值 String 返回gzip流中的字符串内容
     */
    public static func getGzipStreamContents(ins: InputStream): String
}
```

```cangjie
/**
 * 判空工具
 */
public class Preconditions {
    /**
     * 检测字符串是否为空
     * 
     * @参数 str 要检查的字符串
     * @参数 errorMsg 异常信息
     * @异常 IllegalArgumentException 如果字符串为空或者字符串中的字符是Unicode空白字符时抛出
     */
    public static func checkEmptyString(str: String, errorMsg:String): Unit
    
    /**
     * 检测字符串是否为空，再判断字符串中的字符是否是Unicode空白字符
     *
     * @参数 str 要检查的字符串
     * @返回值 Bool 字符串不为空，并且字符串中的字符不是Unicode空白字符，返回true，否则返回false
     */
    public static func hasNext(str: String): Bool
}
```

##### 1.2.2 示例

```cangjie
from oauth4cj import utils.*
from std import io.*
main (){
    let str: String = "Hello World"
    let bytes: Array<UInt8> = str.toUtf8Array()
    let bas: ByteArrayStream = ByteArrayStream(526)
    bas.write(bytes)
    let decoded: String = StreamUtils.getStreamContents(bas)
    println("decoded == str: ${decoded == str}")
    if (!str.equals(decoded)) {
       println(1)
       return 1
    }
    return 0
}
```

执行结果如下：

```cangjie
decoded == str: true
```

#### 1.3 提供OAuth的请求/响应/令牌对象

提供 OAuth4cj HttpRequest的表示形式，OAuth4cjRequest；提供 OAuth4cj 请求或访问令牌 Token；提供 OAuth4cj 的 HTTP响应表示形式，Response。

##### 1.3.1 主要接口

提供 OAuth 请求或访问令牌 Token 和 oauth1、oauth2不同版本的子类

```cangjie
/**
 * OAuth令牌
 */
public open class Token {
    /**
     * 构造方法
     */
    public init()
    
    /**
     * 构造方法
     *
     * @参数 rawResponse 原始响应信息
     */
    public init(rawResponse:String)
    
    /**
     * 获取原始响应信息
     *
     * @返回值 String 原始响应信息
     * @异常 IllegalArgumentException 如果rawResponse值为空抛出异常
     */
    public func getRawResponse(): String
    
    /**
     * 获取指定参数对应的值
     *
     * @参数 parameter 要查找的参数名
     * @返回值 String 参数名对应的值
     */
    public func getParameter(parameter:String): String
}
```

```cangjie
/**
 * OAuth1令牌
 */
public open class OAuth1Token <: Token {
    /**
     * 构造方法
     */
    public init()
    
    /**
     * 构造方法
     *
     * @参数 token 令牌标识符
     * @参数 tokenSecret 令牌密钥
     * @参数 rawResponse 原始响应信息
     */
    public init(token:String, tokenSecret:String, rawResponse:String)
    
    /**
     * 获取令牌标识符
     *
     * @返回值 String 令牌标识符
     */
    public open func getToken():String
    
    /**
     * 获取令牌密钥
     *
     * @返回值 String 令牌密钥信息
     */
    public open func getTokenSecret():String
    
    /**
     * 判断OAuth1Token是否为空
     * 
     * @返回值 Bool 如果token和tokenSecret两个参数都为空 返回true 其他情况返回false
     */
    public func isEmpty():Bool 
}
```

```cangjie
/**
 * OAuth1访问令牌
 */
public class OAuth1AccessToken <: OAuth1Token {
    /**
     * 构造方法
     *
     * @参数 token 令牌标识符
     * @参数 tokenSecret 令牌密钥
     */
    public init(token:String, tokenSecret:String)
    
    /**
     * 构造方法
     *
     * @参数 token 令牌标识符
     * @参数 tokenSecret 令牌密钥
     * @参数 rawResponse 原始响应信息
     */
    public init(token:String, tokenSecret:String, rawResponse:String)
    
    /**
     * 获取令牌标识符
     *
     * @返回值 String 令牌标识符
     */
    public override func getToken():String
    
    /**
     * 获取令牌密钥
     *
     * @返回值 String 令牌密钥信息
     */
    public override func getTokenSecret():String
    
    /**
     * 比较方法覆写
     * 先判断传参是否为空，并且传参类型是否是OAuth1AccessToken，
     * 再判断getToken()值是否相同 最后返回getTokenSecret()值是否相同
     * 
     * @参数 object 要比较的对象
     * @返回值 Bool 传入参数类型为OAuth1AccessToken并且token值和tokenSecret值都相同时返回true 
     *              其他情况返回false
     */
    public func equals(object:Object):Bool
}
```

```cangjie
/**
 * OAuth1请求令牌
 */
public class OAuth1RequestToken <: OAuth1Token {
    /**
     * 构造方法
     *
     * @参数 token 令牌标识符
     * @参数 tokenSecret 令牌密钥
     */
    public init(token:String, tokenSecret:String)
    
    /**
     * 构造方法
     *
     * @参数 token 令牌标识符
     * @参数 tokenSecret 令牌密钥
     * @参数 rawResponse 原始响应信息
     */
    public init(token:String, tokenSecret:String, rawResponse:String)
    
    /**
     * 构造方法
     *
     * @参数 token 令牌标识符
     * @参数 tokenSecret 令牌密钥
     * @参数 oauthCallbackConfirmed 已确认oauth回调的标识
     * @参数 rawResponse 原始响应信息
     */
    public init(token:String, tokenSecret:String, oauthCallbackConfirmed:Bool, rawResponse:String)
    
    /**
     * 获取临时令牌识符
     *
     * @返回值 String 临时凭据标识符
     */
    public override func getToken():String
    
    /**
     * 获取临时令牌密钥
     *
     * @返回值 String 临时令牌密钥
     */
    public override func getTokenSecret():String
    
    /**
     * 是否已确认oauth回调
     *
     * @返回值 Bool 已确认oauth回调的标识
     */
    public func isOauthCallbackConfirmed():Bool
    
    /**
     * 比较方法覆写
     * 先判断传参是否为空，并且传参类型是否是OAuth1RequestToken，
     * 再判断getToken()值是否相同 最后返回getTokenSecret()值是否相同
     * 
     * @参数 object 要比较的对象
     * @返回值 Bool 传入参数类型为OAuth1RequestToken并且token值和tokenSecret值都相同时返回true
     *              其他情况返回false
     */
    public func equals(object:Object):Bool
}
```

```cangjie
/**
 * OAuth2访问令牌
 */
public class OAuth2AccessToken <: Token {
    /**
     * 构造方法
     *
     * @参数 accessToken 访问令牌
     */
    public init(accessToken:String)
    
    /**
     * 构造方法
     *
     * @参数 accessToken 访问令牌
     * @参数 rawResponse 原始响应信息
     */
    public init(accessToken:String, rawResponse:String)
    
    /**
     * 构造方法
     *
     * @参数 accessToken 访问令牌
     * @参数 tokenType 令牌类型
     * @参数 expiresIn 访问令牌的有效时间
     * @参数 refreshToken 刷新令牌
     * @参数 scope 访问范围
     * @参数 rawResponse 原始响应信息
     */
    public init(accessToken:String, tokenType:String, expiresIn:Int32, refreshToken:String, scope:String, rawResponse:String)
    
    /**
     * 获取访问令牌
     *
     * @返回值 String 访问令牌
     */
    public func getAccessToken():String
    
    /**
     * 获取令牌类型
     *
     * @返回值 String 令牌类型
     */
    public func getTokenType():String
    
    /**
     * 获取访问令牌的有效时间
     *
     * @返回值 Int32 访问令牌的有效时间
     */
    public func getExpiresIn():Int32
    
    /**
     * 获取刷新令牌
     *
     * @返回值 String 刷新令牌
     */
    public func getRefreshToken():String
    
    /**
     * 获取访问范围
     *
     * @返回值 String 访问范围
     */
    public func getScope():String
    
    /**
     * 比较方法覆写
     * 先判断传参是否为空，并且传参类型是否是OAuth2AccessToken，再判断各个参数值是否相同
     * 
     * @参数 object 要比较的对象
     * @返回值 Bool 传入参数类型为OAuth2AccessToken并且各个参数值都相同时返回true 
     *               其他情况返回false
     */
    public func equals(object:Object):Bool 
}
```

```cangjie
/**
 * 设备授权
 */
public class DeviceAuthorization {
    /**
     * 构造方法
     *
     * @参数 deviceCode 设备验证码
     * @参数 userCode 最终用户验证码
     * @参数 verificationUri 授权服务器上的最终用户验证URI
     * @参数 expiresInSeconds 验证码有效时间
     */
    public init(deviceCode:String, userCode:String, verificationUri:String, expiresInSeconds:Int64)
    
    /**
     * 设置完整的验证URI
     *
     * @参数 verificationUriComplete 完整的验证URI
     */
    public func setVerificationUriComplete(verificationUriComplete:String): Unit
    
    /**
     * 设置客户端在向令牌端点发出轮询请求之间应等待的最短时间 
     *
     * @参数 intervalSeconds 时间
     */
    public func setIntervalSeconds(intervalSeconds:Int32): Unit
    
    /**
     * 获取设备验证码
     *
     * @返回值 String 设备验证码
     */
    public func getDeviceCode():String
    
    /**
     * 获取最终用户验证码
     *
     * @返回值 String 最终用户验证码
     */
    public func getUserCode():String
    
    /**
     * 获取授权服务器上的最终用户验证URI
     *
     * @返回值 String 授权服务器上的最终用户验证URI
     */
    public func getVerificationUri():String
    
    /**
     * 获取完整的验证URI
     *
     * @返回值 String 完整的验证URI
     */
    public func getVerificationUriComplete():String
    
    /**
     * 获取验证码有效时间
     *
     * @返回值 Int64 验证码有效时间 以秒为单位
     */
    public func getExpiresInSeconds():Int64
    
    /**
     * 获取客户端在向令牌端点发出轮询请求之间应等待的最短时间
     *
     * @返回值 Int32 客户端在向令牌端点发出轮询请求之间应等待的最短时间 以秒为单位 默认为5秒
     */
    public func getIntervalSeconds():Int32
    
    /**
     * 当前的参数值转为字符串
     */
    public func toString(): String 
}
```

```cangjie
/**
 * OAuth2授权
 */
public class OAuth2Authorization {
    /**
     * 构造函数
     */
    public init()
    
    /**
     * 获取授权服务器生成的授权代码
     *
     * @返回值 String 授权服务器生成的授权代码
     */
    public func getCode():String
    
    /**
     * 设置授权服务器生成的授权代码
     *
     * @参数 code 授权服务器生成的授权代码
     */
    public func setCode(code:String): Uint
    
    /**
     * 获取状态码
     *
     * @返回值 String 状态码
     */
    public func getState():String
    
    /**
     * 设置状态码
     *
     * @参数 state 状态码
     */
    public func setState(state:String): Uint
}
```

提供 OAuth 的 HTTP响应表示形式，Response

```cangjie
/**
 * 响应
 */
public class Response <: Closeable {
    /**
     * 构造方法
     *
     * @参数 code 状态码
     * @参数 message 状态信息
     * @参数 headers 响应头
     * @参数 body 响应体
     */
    public init(code:Int32, message:String, headers:HashMap<String, String>, body:String) 
    
    /**
     * 构造方法
     *
     * @参数 code 状态码
     * @参数 message 状态信息
     * @参数 headers 响应头
     * @参数 stream 重要的流数据
     * @参数 closeables 可关闭的数据源集合
     */
    public init(code:Int32, message:String, headers:HashMap<String, String>, stream:InputStream, closeables:ArrayList<Closeable>)
    
    /**
     * 是否响应成功
     *
     * @返回值 Bool 状态码等于200或介于200和400之间返回true
     */
    public func isSuccessful():Bool
    
    /**
     * 以字符串形式返回响应体，关闭返回该响应体的流
     *
     * @返回值 String 字符串形式的响应体
     */
    public func getBody():String
    
    /**
     * 获取HttpUrlConnection的流，可以是inputStream或者errorInputStream
     *
     * @返回值 InputStream 根据状态码获取输入流/错误流
     */
    public func getStream():InputStream 
    
    /**
     * 获取HTTP状态码
     *
     * @返回值 Int32 状态码
     */
    public func getCode():Int32
    
    /**
     * 获取HTTP状态消息
     *
     * @返回值 String 状态消息 如果不能从响应中识别出消息，则返回""
     */
    public func getMessage():String
    
    /**
     * 获取HTTP响应头
     *
     * @返回值 HashMap<String, String> 响应头
     */
    public func getHeaders():HashMap<String, String>
    
    /**
     * 获取指定HTTP响应头参数值
     *
     * @参数 name 响应头参数名
     * @返回值 String 响应头参数值，没有该参数或者参数没有值返回""
     */
    public func getHeader(name:String):String
    
    /**
     * 返回字符串形式的响应信息
     * 
     * @返回值 String 响应信息字符串形式
     */
    public func toString():String
    
    /**
     * 关闭此流并释放与之关联的任何系统资源
     * 
     * @异常 IOException 如果关闭流或资源失败，抛出IOException
     */
    public func close():Unit
}
```

```cangjie
/**
 * 可以关闭的数据源接口
 */
public interface Closeable {
    func close():Unit
}
```

```cangjie
/**
 * 响应异常类
 */
public class OAuthResponseException <: OAuth4cjException {
    /**
     * 构造函数
     *
     * @参数 rawResponse 响应数据
     */
    public init(rawResponse: Response)
    
    /**
     * 获取响应对象
     *
     * @返回值 Response 响应对象
     */
    public func getResponse(): Response
    
    /**
     * 确定两个OAuthResponseException对象是否相等
     * 如果两个对象的内存地址一致直接返回true，不一致时再判断字符串内容是否一致
     *
     * @参数 obj 要比较的对象
     * @返回值 Bool 两个对象内存相同或者字符串内容一致返回true，否则返回false
     */
    public func equals(obj: OAuthResponseException): Bool
}
```

提供 OAuth4cj Http请求的表示形式，OAuth4cjRequest

```cangjie
/**
 * 请求
 */
public class OAuth4cjRequest {
    /**
     * 构造函数
     *
     * @参数 verb http操作类型
     * @参数 url 请求地址
     */
    public init(verb: Verb, url: String)
    
    /**
     * 添加OAuth参数
     *
     * @参数 key 参数名
     * @参数 value 参数值
     */
    public func addOAuthParameter(key: String, value: String): Unit
    
    /**
     * 获取OAuth参数集合
     *
     * @返回值 HashMap<String, String> OAuth参数集合
     */
    public func getOauthParameters(): HashMap<String, String>
    
    /**
     * 设置范围
     *
     * @参数 realm 范围
     */
    public func setRealm(realm: String): Unit
    
    /**
     * 获取范围
     *
     * @返回值 String 范围
     */
    public func getRealm(): String
    
    /**
     * 返回完整的url字符串
     * (主机ip+资源路径+编码的查询字符串参数)
     *
     * @返回值 String 完整的url字符串
     */
    public func getCompleteUrl(): String
    
    /**
     * 向请求中添加HTTP报头
     *
     * @参数 key 参数名
     * @参数 value 参数值
     */
    public func addHeader(key: String, value: String): Unit
    
    /**
     * 添加请求体参数(POST/PUT请求)
     *
     * @参数 key 参数名
     * @参数 value 参数值
     */
    public func addBodyParameter(key: String, value: String):Unit
    
    /**
     * 添加查询参数
     *
     * @参数 key 参数名
     * @参数 value 参数值
     */
    public func addQuerystringParameter(key: String, value: String):Unit
    
    /**
     * 添加参数
     *
     * @参数 key 参数名
     * @参数 value 参数值
     */
    public func addParameter(key: String, value: String):Unit
    
    /**
     * 获取MultipartPayload对象
     *
     * @返回值 MultipartPayload MultipartPayload对象
     */
    public func getMultipartPayload(): MultipartPayload
    
    /**
     * 设置MultipartPayload对象
     *
     * @参数 multipartPayload MultipartPayload对象
     */
    public func setMultipartPayload(multipartPayload: MultipartPayload): Unit
    
    /**
     * 初始化MultipartPayload对象
     */
    public func initMultipartPayload(): Unit
    
    /**
     * 初始化MultipartPayload对象
     *
     * @参数 boundary 边界值
     */
    public func initMultipartPayload(boundary: String): Unit
    
    /**
     * 初始化MultipartPayload对象
     *
     * @参数 subtype multipart类型(默认是form-data)
     * @参数 boundary 边界值
     */
    public func initMultipartPayload(subtype: String, boundary: String): Unit
    
    /**
     * 初始化MultipartPayload对象
     *
     * @参数 headers 请求头
     */
    public func initMultipartPayload(headers: HashMap<String, String>): Unit
    
    /**
     * 初始化MultipartPayload对象
     *
     * @参数 boundary 边界值
     * @参数 headers 请求头
     */
    public func initMultipartPayload(boundary: String, headers: HashMap<String, String>): Unit

    /**
     * 初始化MultipartPayload对象
     *
     * @参数 subtype multipart类型(默认是form-data)
     * @参数 boundary 边界值
     * @参数 headers 请求头
     */
    public func initMultipartPayload(subtype: String, boundary: String, headers: HashMap<String, String>): Unit
    
    /**
     * 设置BodyPartPayload对象
     *
     * @参数 bodyPartPayload BodyPartPayload对象
     */
    public func setBodyPartPayloadInMultipartPayload(bodyPartPayload: BodyPartPayload): Unit
    
    /**
     * 添加BodyPartPayload对象
     *
     * @参数 bodyPartPayload BodyPartPayload对象
     */
    public func addBodyPartPayloadInMultipartPayload(bodyPartPayload: BodyPartPayload): Unit
    
    /**
     * 设置请求数据
     * 当HTTP正文不是一个表单url编码的String，而是另一个String时，使用此方法
     * 例如，XML。注意:此内容不是OAuth签名的一部分
     *
     * @参数 payload 请求的主体数据
     */
    public func setPayload(payload: String): Unit
    
    /**
     * 设置请求数据
     *
     * @参数 payload Array<UInt8>类型的请求数据
     */
    public func setPayload(payload: Array<UInt8>): Unit
    
    /**
     * 设置请求数据
     *
     * @参数 payload 文件类型的请求数据
     */
    public func setPayload(payload: File): Unit
    
    /**
     * 获取带有查询字符串参数的参数列表
     *
     * @返回值 ParameterList 带有查询字符串参数的参数列表
     * @异常 OAuth4cjException 请求地址无效时抛出此异常
     */
    public func getQueryStringParams(): ParameterList
    
    /**
     * 获取请求体参数
     *
     * @返回值 ParameterList 请求体body参数
     */
    public func getBodyParams(): ParameterList
    
    /**
     * 获取HTTP请求的URL
     *
     * @返回值 String HTTP请求的原始URL
     */
    public func getUrl(): String
    
    /**
     * 获取不包含端口和查询字符串部分的URL
     *
     * @返回值 String 不包含端口和查询字符串部分的URL
     */
    public func getSanitizedUrl(): String
    
    /**
     * 获取请求体
     *
     * @返回值 String 请求体表单编码字符串
     */
    public func getStringPayload(): String
    
    /**
     * 获取请求体
     * 在函数setPayload(payload: Array<UInt8>)或函数addBodyParameter中设置
     *
     * @返回值 Array<UInt8> 请求体的Array<UInt8>类型形式
     */
    public func getByteArrayPayload(): Array<UInt8>
    
    /**
     * 获取请求体
     *
     * @返回值 Option<File> 文件类型的请求体
     */
    public func getFilePayload(): Option<File>
    
    /**
     * 获取OAuth4cjRequest对象的字符串表示形式
     *
     * @返回值 String 转换后的字符串
     */
    public func toString(): String
    
    /**
     * 获取HTTP操作类型
     *
     * @返回值 Verb HTTP操作类型
     */
    public func getVerb(): Verb
    
    /**
     * 获取请求头
     *
     * @返回值 HashMap<String, String> 请求头
     */
    public func getHeaders(): HashMap<String, String>
    
    /**
     * 获取字符集
     *
     * @返回值 String 字符集名称
     */
    public func getCharset(): String
    
    /**
     * 设置请求体的字符集
     * 当前仅支持UTF-8
     *
     * @参数 charsetName 字符集名称
     */
    public func setCharset(charsetName: String): Unit
    
    /**
     * 继承此方法的实现应该关闭提供的响应，防止响应不包括在Any<T>的返回对象中
     * 如果响应不包括在返回对象中，那么要在请求回调完成的方法中关闭响应
     *
     * @参数 response 响应对象
     * @返回值 Any 
     */
    public open func convert(response: Response): Any
}
```

```cangjie
/**
 * 参数类
 */
public class Parameter {
    /**
     * 构造函数
     *
     * @参数 key 键
     * @参数 value 值
     */
    public init(key: String, value: String)
    
    /**
     * 根据OAuthEncoder对Parameter对象中的信息进行编码，并将其拼接成字符串
     *
     * @返回值 String 编码拼接后的字符串
     */
    public func asUrlEncodedPair(): String
    
    /**
     * 获取键
     *
     * @返回值 String 键
     */
    public func getKey(): String
    
    /**
     * 获取值
     *
     * @返回值 String 值
     */
    public func getValue(): String
    
    /**
     * 获取哈希码
     *
     * @返回值 Int64 哈希码
     */
    public func hashCode(): Int64
    
    /**
     * 重载运算符'=='，返回两个Parameter实例的比较结果
     * 如果两个对象的内存地址一致直接返回true，不一致时再判断键和值是否都一致
     *
     * @参数 that 要比较的Parameter最新
     * @返回值 Bool 如果两个对象的内存一致或者key和value的值都一致时返回true，否则返回false
     */
    public operator func ==(that: Parameter): Bool
    
    /**
     * 两个Parameter比较大小
     *
     * @参数 parameter 要比较的另一个Parameter
     * @返回值 Ordering, 如果是大于,返回Ordering.GT
     *               如果相等，返回Ordering.EQ
     *               如果小于，返回Ordering.LT
     */
    public func compareTo(parameter: Parameter): Ordering
}
```

```cangjie
/**
 * 参数集合类
 */
public class ParameterList {
    /**
     * 构造函数
     */
    public init()
    
    /**
     * 构造函数
     *
     * @参数 map HashMap类型数据
     */
    public init(map: HashMap<String, String>)
    
    /**
     * 添加键值对
     *
     * @参数 key 键
     * @参数 value 值
     */
    public func add(key: String, value: String): Unit
    
    /**
     * 处理url并返回一个新字符串
     *
     * @参数 url 要处理的url
     * @返回值 String 处理后的url字符串
     */
    public func appendTo(url: String): String
    
    /**
     * 处理ParameterList对象中的信息并根据OAuthEncoder对其进行编码
     *
     * @返回值 String 处理并编码后的字符串
     */
    public func asOauthBaseString(): String
    
    /**
     * 处理ParameterList对象中的信息并将其拼接成字符串
     *
     * @返回值 String 拼接后的字符串
     */
    public func asFormUrlEncodedString(): String
    
    /**
     * 将另一个ParameterList添加到这个ParameterList对象中
     *
     * @参数 other 另一个ParameterList
     */
    public func addAll(other: ParameterList): Unit
    
    /**
     * 处理queryString并添加到这个ParameterList对象中
     *
     * @参数 queryString 要处理的字符串
     */
    public func addQuerystring(queryString: String): Unit
    
    /**
     * 确定当前ParameterList对象是否包含指定的参数对象
     *
     * @参数 param 要确定的参数对象
     * @返回值 Bool 包含要确定的参数对象时返回true，否则返回false
     */
    public func contains(param: Parameter): Bool
    
    /**
     * 获取当前ParameterList对象的长度
     *
     * @返回值 Int64
     */
    public func size(): Int64
    
    /**
     * 获取Parameter对象集合
     *
     * @返回值 ArrayList<Parameter> Parameter对象集合
     */
    public func getParams(): ArrayList<Parameter>
    
    /**
     * 返回排序后的新ParameterList对象
     *
     * @返回值 ParameterList 排序后的新ParameterList对象
     */
    public func sort(): ParameterList
}
```

```cangjie
/**
 * 包含最常见HTTP请求类型的枚举
 */
public enum Verb <: ToString{
    | GET
    | POST
    | PUT
    | DELETE
    | HEAD
    | OPTIONS 
    | TRACE
    | PATCH
    
    /**
     * 是否需要请求体
     * 
     * @返回值 Bool 不同操作返回值不同 GET=false POST=true PUT=true DELETE=false
     *         HEAD=false OPTIONS=false TRACE=false PATCH=false
     */
    public func isRequiresBody():Bool
    
    /**
     * 是否需要许可证
     *
     * @返回值 Bool 只有DELETE为true，其他都为false
     */
    public func isPermitBody():Bool
    
    /**
     * 转换成字符串形式
     *
     * @返回值 String 请求类型的字符串
     */
    public func toString():String
}
```

```cangjie
/**
 * OAuth常量类
 */
public class OAuthConstants {
    /**
     * oauth时间戳参数名字符串
     */
    public static let TIMESTAMP: String = "oauth_timestamp"
    
    /**
     * oauth签名方法参数名字符串
     */
    public static let SIGN_METHOD: String = "oauth_signature_method"
    
    /**
     * oauth签名参数名字符串
     */
    public static let SIGNATURE: String = "oauth_signature"
    
    /**
     * oauth用户密钥参数名字符串
     */
    public static let CONSUMER_SECRET: String = "oauth_consumer_secret"
    
    /**
     * oauth用户key参数名字符串
     */
    public static let CONSUMER_KEY: String = "oauth_consumer_key"
    
    /**
     * oauth回调参数名字符串
     */
    public static let CALLBACK: String = "oauth_callback"
    
    /**
     * oauth版本参数名字符串
     */
    public static let VERSION: String = "oauth_version"
    
    /**
     * 参数名字符串
     */
    public static let NONCE: String = "oauth_nonce"
    
    /**
     * 领域参数名字符串
     */
    public static let REALM: String = "realm"
    
    /**
     * oauth参数名字符串
     */
    public static let PARAM_PREFIX: String = "oauth_"
    
    /**
     * oauth令牌参数名字符串
     */
    public static let TOKEN: String = "oauth_token"
    
    /**
     * oauth令牌密钥参数名字符串
     */
    public static let TOKEN_SECRET: String = "oauth_token_secret"
    
    /**
     * oauth验证器参数名字符串
     */
    public static let VERIFIER: String = "oauth_verifier"
    
    /**
     * 授权参数名字符串
     */
    public static let HEADER: String = "Authorization"
    
    /**
     * 范围参数名字符串
     */
    public static let SCOPE: String = "scope"
    
    /**
     * 基本认证参数名字符串
     */
    public static let BASIC: String = "Basic"

    // OAuth 1.0
    /**
     * 带外配置
     * 传输层协议使用带外数据（out-of-band，OOB）来发送一些重要的数据
     */
    public static let BOOB: String = "oob"

    // OAuth 2.0
    /**
     * 访问令牌参数名字符
     */
    public static let ACCESS_TOKEN: String = "access_token"
    
    /**
     * 客户端id参数名字符串
     */
    public static let CLIENT_ID: String = "client_id"
    
    /**
     * 客户端密钥参数名字符串
     */
    public static let CLIENT_SECRET: String = "client_secret"
    
    /**
     * 重定向uri参数名字符串
     */
    public static let REDIRECT_URI: String = "redirect_uri"
    
    /**
     * 状态码参数名字符串
     */
    public static let CODE: String = "code"
    
    /**
     * 刷新令牌参数名字符串
     */
    public static let REFRESH_TOKEN: String = "refresh_token"
    
    /**
     * 授权模式参数名字符串
     */
    public static let GRANT_TYPE: String = "grant_type"
    
    /**
     * 授权码参数名字符串
     */
    public static let AUTHORIZATION_CODE: String = "authorization_code"
    
    /**
     * 客户端凭证参数名字符串
     */
    public static let CLIENT_CREDENTIALS: String = "client_credentials"
    
    /**
     * 状态参数名字符串
     */
    public static let STATE: String = "state"
    
    /**
     * 用户名参数名字符串
     */
    public static let USERNAME: String = "username"
    
    /**
     * 密码参数名字符串
     */
    public static let PASSWORD: String = "password"
    
    /**
     * 响应类型参数名字符串
     */
    public static let RESPONSE_TYPE: String = "response_type"
    
    /**
     * 响应码参数名字符串
     */
    public static let RESPONSE_TYPE_CODE: String = "code"

    /**
     * 报文头中的"User-Agent"参数名字符串，不是OAuth特有的
     */
    public static let USER_AGENT_HEADER_NAME: String = "User-Agent"
}
```

##### 1.3.2 示例

```cangjie
from oauth4cj import model.*
from std import collection.HashMap
from std import collection.ArrayList
from std import io.*
main (){
    var headers:HashMap<String, String> = HashMap<String, String>()
    var stream:ByteArrayStream = ByteArrayStream()
    var closeables:ArrayList<Closeable> = ArrayList<Closeable>()
    stream.write("abcdefg".toUtf8Array()) // 向流中写入测试数据
    var response:Response = Response(200, "message", headers, stream, closeables)
    var responseStream = response.getStream()
    var buffer:Array<Byte> = Array<Byte>(7, item:0)
    responseStream.read(buffer) 
    var str_1 = String.fromUtf8(buffer)
    println(str_1)
    if (!"abcdefg".equals(str_1)){ 
       return -1
    }
    var str_2:String = response.toString()
    println(str_2)
    if (!"Response{code=200, message='message', body='', headers=[]}" .equals(str_2)){ 
       return -1
    }
    return 0
}
```

执行结果如下：

```cangjie
abcdefg
Response{code=200, message='message', body='', headers=[]}
```


