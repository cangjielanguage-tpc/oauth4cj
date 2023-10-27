主要接口
## OAuth4cj 库

### 介绍
OAuth4cj 支持协议 OAuth1.0 和 OAuth2.0，允许第三方程序通过访问令牌访问受保护的资源，而无需暴露用户的凭据。支持授权码模式，简化模式，密码模式，客户端模式四种模式。

### 1 支持协议 OAuth1.0 和 OAuth2.0，支持授权码模式，简化模式，密码模式，客户端模式四种模式。

前置条件：NA     
场景：    
1.是一种授权协议，应用于允许第三方程序通过访问令牌访问受保护的资源，而无需暴露用户的凭据；     
2.支持协议 OAuth1.0 和 OAuth2.0；     
3.支持授权码模式，简化模式，密码模式，客户端模式四种模式。   
约束： 只支持UTF-8字符编码     
性能： NA    
可靠性： NA  

#### 1.1 提供 base64 编码功能

##### 1.1.1 主要接口

```cangjie
/**
 * base64编码工具类
 */
public open class Base64Utils {
    
    /**
     * 使用 Base64 编码方案将指定的字节数组编码为字符串。
     * 注: 
     *    1. 使用 RFC2045（和 RFC4648）的“表1: Base64 字母表”;
     *    2. 使用“=”填充剩余的1或2个字节。
     *
     * @参数 bytes - 要编码的字节数组
     * @返回值 String - Base64 编码生成的字符串
     */
    public static func encode(bytes: Array<UInt8>): String
    
    /**
     * 使用 Base64 编码方案将指定的字节数组编码为字符串，无需填充。
     * 注：
     *    1. 使用 RFC4648 的表2（“URL 和文件名安全 Base64”），将“+”和“/”更改为“-”和“_”;
     *    2. 不使用'='填充剩余的1或2个字节。
     *
     * @参数 bytes - 要编码的字节数组
     * @返回值 String - Base64 编码生成的字符串
     */
    public static func encodeUrlWithoutPadding(bytes: Array<UInt8>): String
}
```

##### 1.1.2 示例

```cangjie
from oauth4cj import oauth4cj.*
main(): Int64 {
    let bytes: Array<UInt8> = "Hello World".toUtf8Array()
    let encoded: String = "SGVsbG8gV29ybGQ="
    let str: String = Base64Utils.encode(bytes)
    if(encoded == str){
        println("encoded == str: ${encoded == str}")
        return 0
    }
    return 1
}
```

执行结果如下：

```shell
encoded == str: true
```

#### 1.2 提供 URL 编解码功能和处理Streams的工具

##### 1.2.0 主要接口

###### 1.2.0.1 URL编解码类

```cangjie
public class URLEncoder {
    /**
     * 使用特定的编码方案将字符串转换为application/x-www-form-urlencoded格式
     * 当前只支持UTF-8字符集
     *
     * @参数 s 要编码的字符串
     * @参数 enc 支持的字符编码的名称，当前只支持UTF-8字符集
     * @返回值 String 编码后的字符串
     * @异常 OAuth4cjException 使用不支持的字符集、字符集为空或编码失败时抛出
     */
    public static func encode(s: String, enc: String): String
    
    /**
     * 使用特定的字符集将字符串转换为application/x-www-form-urlencoded格式
     * 该方法使用提供的字符集来获取不安全字符的字节，当前只支持UTF-8字符集
     *
     * @参数 s 要编码的字符串
     * @返回值 String 编码后的字符串
     */
    public static func encode(s: String): String
    
    /**
     * 使用特定的编码方案解码application/x-www-form-urlencoded字符串
     * 当前只支持UTF-8字符集
     *
     * @参数 s 要解码的字符串
     * @参数 enc 支持的字符解码的名称，当前只支持UTF-8字符集
     * @返回值 String 解码后的字符串
     * @异常 OAuth4cjException 使用不支持的字符集、字符集为空或解码失败时抛出
     */
    public static func decode(s: String, enc: String): String
    
    /**
     * 使用特定的字符集解码application/x-www-form-urlencoded字符串
     * 当前只支持UTF-8字符集
     *
     * @参数 s 要解码的字符串
     * @返回值 String 解码后的字符串
     * @异常 IllegalArgumentException 解码字符串中有非法字符时抛出
     */
    public static func decode(s: String): String
} 
```

###### 1.2.0.2 OAuth编解码工具类

```cangjie
public class OAuthEncoder {
    /**
     * 使用特定的字符集将字符串转换为application/x-www-form-urlencoded格式
     * 当前只支持UTF-8字符集
     *
     * @参数 s 要编码的字符串
     * @返回值 String 编码后的字符串
     * @异常 OAuth4cjException 编码失败时抛出
     */
    public static func encode(src: String): String
    
    /**
     * 使用特定的编码方案解码application/x-www-form-urlencoded字符串
     * 当前只支持UTF-8字符集
     *
     * @参数 s 要解码的字符串
     * @返回值 String 解码后的字符串
     * @异常 OAuth4cjException 解码失败时抛出
     */
    public static func decode(encoded: String): String
}
```

###### 1.2.0.3 Stream流工具类

```cangjie
public class StreamUtils {
    /**
     * 以UTF-8编码的字符串形式返回流内容
     *
     * @参数 ins 输入流
     * @参数 isGzipStream 输入流是否为GzipStream，默认为false
     * @返回值 String 返回UTF-8编码的字符串
     * @异常 OAuth4cjException 输入流长度为0、读取流失败时抛出
     */
    public static func getStreamContents(ins: InputStream, isGzipStream!: Bool = false): String
    
    /**
     * 返回gzip流中的字符串内容
     * 从要解压缩的InputStream流中读取并解压缩数据，并将其转换为字符串格式
     *
     * @参数 ins 输入流
     * @返回值 String 返回gzip流中的字符串内容
     * @异常 OAuth4cjException 输入流长度为0、读取流失败时抛出
     */
    public static func getGzipStreamContents(ins: InputStream): String
}
```

###### 1.2.0.4 判空工具

```cangjie
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
from oauth4cj import oauth4cj.*
from std import io.*
main (){
    let str: String = "Hello World"
    let bytes: Array<UInt8> = str.toUtf8Array()
    let bas: ByteArrayStream = ByteArrayStream(526)
    bas.write(bytes)
    let decoded: String = StreamUtils.getStreamContents(bas)
    if(decoded == str){
        println("decoded == str: ${decoded == str}")
        return 0
    }
    return 1
}
```

执行结果如下：

```cangjie
decoded == str: true
```

#### 1.3 提供OAuth的请求/响应/令牌对象

OAuth4cj 提供 OAuth4cjRequest 类表示 HttpRequest，提供 OAuth4cjResponse 类表示 HttpResponse, 提供 Token 及其子类表示访问令牌。

##### 1.3.1 主要接口

提供 Token 及其子类表示访问令牌。

###### 1.3.1.1 OAuth令牌

```cangjie
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

###### 1.3.1.2 OAuth1令牌

```cangjie
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

###### 1.3.1.3 OAuth1访问令牌

```cangjie
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

###### 1.3.1.4 OAuth1请求令牌

```cangjie
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
     * 获取确认 oauth 回调状态
     *
     * @返回值 Bool oauth 回调状态
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

###### 1.3.1.5 OAuth2访问令牌

```cangjie
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
     *
     * @异常 OAuth4cjException 有效时间参数为负数时抛出
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

###### 1.3.1.6 设备授权

```cangjie
public class DeviceAuthorization {
    /**
     * 构造方法
     *
     * @参数 deviceCode 设备验证码
     * @参数 userCode 最终用户验证码
     * @参数 verificationUri 授权服务器上的最终用户验证URI
     * @参数 expiresInSeconds 验证码有效时间
     *
     * @异常 OAuth4cjException 时间参数不能为负数
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
     *
     * @异常 OAuth4cjException 时间参数不能为负数
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

###### 1.3.1.7 OAuth2授权

```cangjie
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

###### 1.3.1.8 响应

提供 OAuth4cjResponse 表示 Http 响应形式

```cangjie
public class OAuth4cjResponse <: Resource {
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
    public init(code:Int32, message:String, headers:HashMap<String, String>, stream:InputStream, closeables:ArrayList<Resource>)
    
    /**
     * 是否响应成功
     *
     * @返回值 Bool 状态码等于200或介于200和400之间返回true
     */
    public func isSuccessful():Bool
    
    /**
     * 以字符串形式返回响应体
     *
     * @返回值 String 字符串形式的响应体
     * @异常 OAuth4cjException 使用空的流构造对象时，获取响应体会抛出异常
     */
    public func getBody():String
    
    /**
     * 获取响应体中的流
     *
     * @返回值 InputStream 获取响应体中的流
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
     * @返回值 String 状态消息
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
     * @返回值 String 响应头参数值
     * @异常 NoneValueException 如果参数名不存在，抛出异常
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

    /**
     * 是否已经关闭，覆写Resource的方法
     *
     * @返回值 Bool 如果已经调用过 close 方法，返回 true，否则返回 false
     */
    public func isClosed(): Bool
}
```

###### 1.3.1.9 响应异常类

```cangjie
public open class OAuth4cjResponseException <: OAuth4cjException {
    /**
     * 构造函数
     *
     * @参数 rawResponse 响应数据
     */
    public init(rawResponse: OAuth4cjResponse)
    
    /**
     * 获取响应对象
     *
     * @返回值 Response 响应对象
     */
    public func getResponse(): OAuth4cjResponse
    
    /**
     * 获取HashCode
     *
     * @返回值 Int64 HashCode值
     */
    public func hashCode(): Int64

    /**
     * 确定两个 OAuth4cjResponseException 对象是否相等
     *
     * @参数 obj 要比较的对象
     * @返回值 Bool 相等返回 true，否则返回 false
     */
    public func equals(obj: OAuth4cjResponseException): Bool
    
    /**
     * 覆写toString方法 
     *
     * @return String 异常信息
     */
    public open func toString(): String
}
```

###### 1.3.1.10 请求

提供 OAuth4cj Http请求的表示形式，OAuth4cjRequest

```cangjie
public open class OAuth4cjRequest {
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
     * @参数 key 参数名（"oauth_"、"scope"、"realm"）
     * @参数 value 参数值
     * @异常 OAuth4cjParametersMissingException key值不在识别范围内时抛出
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
     * 返回完整的url字符串。
     * 查询参数进行了编码处理。
     *
     * @返回值 String 完整的url字符串
     */
    public func getCompleteUrl(): String
    
    /**
     * 向请求中添加HTTP报头。
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
     * 获取multipartPayload
     *
     * @返回值 MultipartPayload MultipartPayload实例
     */
    public func getMultipartPayload(): Option<MultipartPayload>
    
    /**
     * 设置multipartPayload
     *
     * @参数 multipartPayload MultipartPayload实例
     */
    public func setMultipartPayload(multipartPayload: MultipartPayload): Unit 

    /**
     * 初始化MultipartPayload对象
     */
    public func initMultipartPayload(): Unit
    
    /**
     * 初始化MultipartPayload对象
     *
     * @参数 boundary 边界字符串
     * @异常 IllegalArgumentException boundary为空或者含有非法字符时抛出
     */
    public func initMultipartPayload(boundary: String): Unit 
    
    /**
     * 初始化MultipartPayload对象
     *
     * @参数 subtype multipart类型(默认是form-data)
     * @参数 boundary 边界字符串
     * @异常 IllegalArgumentException boundary为空或者含有非法字符时抛出
     */
    public func initMultipartPayload(subtype: String, boundary: String): Unit
    
    /**
     * 初始化MultipartPayload对象
     *
     * @参数 headers 头信息
     */
    public func initMultipartPayload(headers: HashMap<String, String>): Unit 
    
    /**
     * 初始化MultipartPayload对象
     *
     * @参数 boundary 边界字符串
     * @参数 headers 头信息
     * @异常 IllegalArgumentException boundary为空或者含有非法字符时抛出、boundary参数值和headers中的边界值不同时抛出
     */
    public func initMultipartPayload(boundary: String, headers: HashMap<String, String>): Unit
    
    /**
     * 初始化MultipartPayload对象
     *
     * @参数 subtype multipart类型(默认是form-data)
     * @参数 boundary 边界字符串
     * @参数 headers 头信息
     * @异常 IllegalArgumentException boundary为空或者含有非法字符时抛出、boundary参数值和headers中的边界值不同时抛出
     */
    public func initMultipartPayload(subtype: String, boundary: String, headers: HashMap<String, String>): Unit

    /**
     * 设置BodyPartPayload对象到MultipartPayload对象中
     *
     * @参数 bodyPartPayload BodyPartPayload对象
     */
    public func setBodyPartPayloadInMultipartPayload(bodyPartPayload: BodyPartPayload): Unit

    /**
     * 添加BodyPartPayload对象到MultipartPayload对象中
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
     * 当前仅支持UTF-8字符集
     *
     * @参数 charsetName 字符集名称,当前仅支持UTF-8字符集
     * @异常 OAuth4cjException 使用不支持的字符集时抛出
     */
    public func setCharset(charsetName: String): Unit
}

public interface ResponseConverter {
    /**
     * 继承此方法的实现应该关闭提供的响应，防止响应不包括在Any<T>的返回对象中
     * 如果响应不包括在返回对象中，那么要在请求回调完成的方法中关闭响应
     *
     * @参数 response 响应对象
     * @返回值 Any 
     */
    func convert(response: OAuth4cjResponse): Any
}
```

###### 1.3.1.11 参数类

```cangjie
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
     * @异常 OAuth4cjException 创建时使用了不支持的字符集
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

###### 1.3.1.12 参数集合类

```cangjie
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

###### 1.3.1.13 包含最常见HTTP请求类型的枚举

```cangjie
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
     *         HEAD=false OPTIONS=false TRACE=false PATCH=true
     */
    public func isRequiresBody():Bool
    
    /**
     * 是否有权限操作请求体
     *
     * @返回值 Bool 不同操作返回值不同 GET=false POST=true PUT=true DELETE=true
     *         HEAD=false OPTIONS=false TRACE=false PATCH=true
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

###### 1.3.1.14 OAuth常量类

```cangjie
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
    public static let HEADER_AUTHORIZATION: String = "Authorization"
    
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
    public static let OOB: String = "oob"

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
###### 1.3.1.15 OAuth异步请求回调

```cangjie
public interface OAuthAsyncRequestCallback {
    /**
     * 请求完成后调用此方法
     *
     * @参数 response 响应对象
     */
    func onCompleted(response: Any): Unit

    /**
     * 发生异常时调用此方法
     *
     * @参数 e 异常对象
     */
    func onThrowable(e: Exception): Unit
}
```

###### 1.3.1.16 OAuth2访问令牌错误响应

```cangjie
public class OAuth2AccessTokenErrorResponseException <: OAuth4cjResponseException {
    /**
     * 构造方法
     *
     * @参数 error Option<OAuth2Error>实例
     * @参数 errorDescription  错误信息描述
     * @参数 errorUrl 错误信息URL实例
     * @参数 rawResponse 响应信息
     */
    public init(error: Option<OAuth2Error>, errorDescription: String, errorUrl: URL, rawResponse: OAuth4cjResponse)

    /**
     * 获取OAuth2Error实例
     *
     * @返回值 Option<OAuth2Error> OAuth2Error实例
     */
    public func getError(): Option<OAuth2Error>

    /**
     * 获取错误信息描述
     *
     * @返回值 String 错误信息描述
     */
    public func getErrorDescription(): String

    /**
     * 获取错误信息URL实例
     *
     * @返回值 URL 错误信息URL实例
     */
    public func getErrorUri(): URL
    
    /**
     * 覆写toString方法 
     *
     * @return String 异常信息
     */
    public open func toString(): String
}
```

##### 1.3.2 示例

```cangjie
from oauth4cj import oauth4cj.*
from std import collection.HashMap
from std import collection.ArrayList
from std import io.*

main (){
    var headers:HashMap<String, String> = HashMap<String, String>()
    var stream:ByteArrayStream = ByteArrayStream()
    var closeables:ArrayList<Resource> = ArrayList<Resource>()
    stream.write("abcdefg".toUtf8Array()) // 向流中写入测试数据
    var response:OAuth4cjResponse = OAuth4cjResponse(200, "message", headers, stream, closeables)
    var responseStream = response.getStream()
    var buffer:Array<Byte> = Array<Byte>(7, item:0)
    responseStream.read(buffer)
    var str_1 = String.fromUtf8(buffer)
    var str_2:String = response.toString()
    if ("abcdefg"!=str_1){
       return -1
    }
    println(str_1)
    if ("Response{code=200, message='message', body='', headers=[]}" !=str_2){
       return -2
    }
    println(str_2)
    return 0
}
```

执行结果如下：

```cangjie
abcdefg
Response{code=200, message='message', body='', headers=[]}
```

#### 1.4 提供对基字符串使用算法进行签名，返回 OAuth4cj 签名，提供 unix 时间戳生成器。

##### 1.4.1 主要接口

###### 1.4.1.1 SignatureService 接口

```cangjie
/**
 * 对基本字符串进行签名并返回 OAuth4cj 签名。
 */
public interface SignatureService {

    /**
     * 返回签名。
     *
     * @参数 baseString 要签名的 url 编码字符串
     * @参数 apiSecret 你的应用程序 api 密钥
     * @参数 tokenSecret 令牌密钥（请求令牌步骤的空字符串）
     * @返回值 String 签名
     */
    func getSignature(baseString: String, apiSecret: String, tokenSecret: String): String

    /**
     * 返回签名方法名称。
     *
     * @返回值 String 签名方法名称。
     */
    func getSignatureMethod(): String
}
```

###### 1.4.1.2 HMACSha1SignatureService 类

```cangjie
/**
 * SignatureService 接口的 HMAC-SHA1 实现。
 */
public class HMACSha1SignatureService <: SignatureService {

    /**
     * 返回签名。
     *
     * @参数 baseString 要签名的 url 编码字符串
     * @参数 apiSecret 你的应用程序 api 密钥
     * @参数 tokenSecret 令牌密钥（请求令牌步骤的空字符串）
     * @返回值 String 签名
     * @异常 OAuth4cjSignatureException 获取 signature 失败时抛出
     */
    public func getSignature(baseString: String, apiSecret: String, tokenSecret: String): String

    /**
     * 返回签名方法名称。
     *
     * @返回值 String 签名方法名称。
     */
    public func getSignatureMethod(): String
}
```

###### 1.4.1.3 PlaintextSignatureService 类

```cangjie
/**
 * SignatureService 接口的明文实现。
 */
public class PlaintextSignatureService <: SignatureService {

    /**
     * 返回签名。
     *
     * @参数 baseString 获取 signature 失败时，baseString 是抛出的异常中的部分信息
     * @参数 apiSecret 你的应用程序 api 密钥
     * @参数 tokenSecret 令牌密钥（请求令牌步骤的空字符串）
     * @返回值 String 签名
     * @异常 OAuth4cjSignatureException 获取 signature 失败时抛出
     */
    public func getSignature(baseString: String, apiSecret: String, tokenSecret: String): String

    /**
     * 返回签名方法名称。
     *
     * @返回值 String 签名方法名称。
     */
    public func getSignatureMethod(): String
}
```

###### 1.4.1.4 RSASha1SignatureService 类

```cangjie
/**
 * SignatureService 接口的 RSA-SHA1 实现。
 * 一种使用 RSA-SHA1 算法的签名服务。
 */
public class RSASha1SignatureService <: SignatureService {

    /**
     * 根据参数创建一个 RSASha1SignatureService 实例。
     *
     * @参数 privateKey 私钥文件路径。
     */
    public init(privateKey: String)

    /**
     * 返回签名。
     *
     * @参数 baseString 要签名的 url 编码字符串
     * @参数 apiSecret 在此子类 RSASha1SignatureService 中，此参数未使用
     * @参数 tokenSecret 在此子类 RSASha1SignatureService 中，此参数未使用
     * @返回值 String 签名
     * @异常 OAuth4cjSignatureException 获取 signature 失败时抛出
     */
    public func getSignature(baseString: String, apiSecret: String, tokenSecret: String): String

    /**
     * 返回签名方法名称。
     *
     * @返回值 String 签名方法名称。
     */
    public func getSignatureMethod(): String
}
```

###### 1.4.1.5 TimestampService 接口

```cangjie
/**
 * 时间戳生成器。
 */
public interface TimestampService {

    /**
     * 以秒为单位返回 unix 时间戳。
     *
     * @返回值 String 时间戳
     */
    func getTimestampInSeconds(): String

    /**
     * 返回一个 nonce（每个请求的唯一值）。
     *
     * @返回值 String 一个 nonce
     */
    func getNonce(): String
}
```

###### 1.4.1.6 TimestampServiceImpl 类

```cangjie
/**
 * TimestampServiceImpl 是接口 TimestampService 的实现类。
 */
public class TimestampServiceImpl <: TimestampService {

    /**
     * 创建一个 TimestampServiceImpl 实例。
     */
    public init()

    /**
     * 返回一个 nonce（每个请求的唯一值）。
     *
     * @返回值 String 一个 nonce
     */
    public func getNonce(): String

    /**
     * 以秒为单位返回 unix 时间戳。
     *
     * @返回值 String 时间戳
     */
    public func getTimestampInSeconds(): String
}
```

##### 1.4.2 示例

```cangjie
from oauth4cj import oauth4cj.*

public func testHMACSha1SignatureService_01(): Int32 {
    let hmac: HMACSha1SignatureService = HMACSha1SignatureService()
    let str: String = hmac.getSignatureMethod()
    let result: String = "HMAC-SHA1"
	if(str!=result){
	    return 1
	}
	println("str = ${str}")
    return 0
}

public func testHMACSha1SignatureService_02(): Int32 {
    let hmac: HMACSha1SignatureService = HMACSha1SignatureService()
    let apiSecret: String = "api secret"
    let tokenSecret: String = "token secret"
    let baseString: String = "base string"
    let signature: String = "uGymw2KHOTWI699YEaoi5xyLT50="
    let str: String = hmac.getSignature(baseString, apiSecret, tokenSecret)
    if (str!=signature) {
        return 2
    }
    println("str = ${str}")
    return 0
}

main() {
    var test_01 = testHMACSha1SignatureService_01()
    if (test_01 != 0){
        return test_01
    }
    test_01 = testHMACSha1SignatureService_02()
    if (test_01 != 0){
        return test_01
    }
	println("ok!")
    return test_01
}
```

执行结果如下：

```shell
str = HMAC-SHA1
str = uGymw2KHOTWI699YEaoi5xyLT50=
ok!
```

#### 1.5 提供从 OAuth4cj 的请求/响应中，解析 base 字符串，生成指定签名请求，获取响应中令牌。

##### 1.5.1 主要接口

###### 1.5.1.1 TokenExtractor 接口

```cangjie
/**
 * 一个简单的命令对象，用于从字符串中提取特定的令牌。
 * T 的具体类型是 Token。
 */
public interface TokenExtractor<T> where T <: Token {
    /**
     * 从 HTTP 响应的内容中提取特定类型的令牌。
     *
     * @参数 response 从响应中获取令牌
     * @返回值 T 特定类型的 Token
     * @异常 IOException 从响应中检索正文失败时抛出
     */
    func extract(response: OAuth4cjResponse): T
}
```

###### 1.5.1.2 AbstractJsonExtractor 类

```cangjie
/**
 * 抽象类 AbstractJsonExtractor，用于获取响应中的参数值。
 */
public abstract class AbstractJsonExtractor 
```

###### 1.5.1.3 AbstractOAuth1JSONTokenExtractor 类

```cangjie
/**
 * AbstractOAuth1JSONTokenExtractor 是接口 TokenExtractor 的实现类。
 */
public abstract class AbstractOAuth1JSONTokenExtractor<T> <: TokenExtractor<T> where T <: OAuth1Token {
    /**
     * 从 HTTP 响应的内容中提取特定类型的令牌。
     *
     * @参数 response 从响应中获取令牌
     * @返回值 T 特定类型的 Token
     * @异常 IOException 从响应中检索正文失败时抛出
     * @异常 IllegalArgumentException 响应体为空时抛出
     * @异常 OAuth4cjException 响应正文不正确时抛出
     */
    public func extract(response: OAuth4cjResponse): T
}
```

###### 1.5.1.4 AbstractOAuth1TokenExtractor 类

```cangjie
/**
 * 用于 OAuth 1.0a 的 TokenExtractor 的抽象基础实现。
 * 提取访问令牌和请求令牌的过程是相似的，所以这个类可以同时执行这两种操作。
 * T - OAuth1Token 的具体类型。访问或请求。
 */
public abstract class AbstractOAuth1TokenExtractor<T> <: TokenExtractor<T> where T <: OAuth1Token {
    /**
     * 从 HTTP 响应的内容中提取特定类型的令牌。
     *
     * @参数 response 从响应中获取令牌
     * @返回值 T 特定类型的 Token
     * @异常 IOException 从响应中检索正文失败时抛出
     * @异常 IllegalArgumentException 响应体为空时抛出
     * @异常 OAuth4cjException 响应正文不正确时抛出
     */
    public func extract(response: OAuth4cjResponse): T
}
```

###### 1.5.1.5 BaseStringExtractor 接口

```cangjie
/**
 * 一个简单的命令对象，用于从 OAuth4cjRequest 中提取基本字符串。
 */
public interface BaseStringExtractor {
    /**
     * 从 OAuth4cjRequest 中提取 url 编码的基本字符串。
     *
     * @参数 request OAuth4cjRequest 类型
     * @返回值 String url 编码的基本字符串
     */
    func extract(request: OAuth4cjRequest): String
}
```

###### 1.5.1.6 BaseStringExtractorImpl 类

```cangjie
/**
 * BaseStringExtractor 接口的默认实现。符合 OAuth 1.0a。
 */
public class BaseStringExtractorImpl <: BaseStringExtractor {
    /**
     * 从 OAuth4cjRequest 中提取 url 编码的基本字符串。
     *
     * @参数 request OAuth4cjRequest 类型
     * @返回值 String url 编码的基本字符串
     * @异常 OAuth4cjParametersMissingException 从响应主体中无法获取到参数时抛出
     */
    public func extract(request: OAuth4cjRequest): String
}
```

###### 1.5.1.7 DeviceAuthorizationJsonExtractor 类

```cangjie
/**
 * DeviceAuthorizationJsonExtractor 是抽象类 AbstractJsonExtractor 的子类。
 */
public class DeviceAuthorizationJsonExtractor <: AbstractJsonExtractor {

    /**
     * 生成一个新的 DeviceAuthorizationJsonExtractor 实例。
     *
     * @返回值 DeviceAuthorizationJsonExtractor 生成的 DeviceAuthorizationJsonExtractor 实例。
     */
    public static func instance(): DeviceAuthorizationJsonExtractor

    /**
     * 如果响应的状态码是200，从响应主体中获取设备授权响应对应的字段信息，封装成一个 DeviceAuthorization 对象并返回。
     * 如果响应的状态代码不是200，则调用 generateError 函数，抛出异常 OAuth2AccessTokenErrorResponse。
     *
     * @参数 response 从此响应中获取消息
     * @返回值 DeviceAuthorization 返回生成的 DeviceAuthorization 实例。
     * @异常 IOException 如果在以字符串形式获取响应主体时发生错误，则会抛出 IOException。
     * @异常 IllegalArgumentException 响应体为空时抛出
     * @异常 OAuth2AccessTokenErrorResponseException 从响应主体中获取错误响应的字段信息，封装并抛出
     */
    public func extract(response: OAuth4cjResponse): DeviceAuthorization

    /**
     * 从响应主体中获取错误响应的字段信息，封装成一个 OAuth2AccessTokenErrorResponse 异常并抛出。
     *
     * @参数 response 从此响应中获取错误消息
     * @异常 IOException 如果在以字符串形式获取响应主体时发生错误，则会抛出 IOException。
     * @异常 OAuth2AccessTokenErrorResponseException 从响应主体中获取错误响应的字段信息，封装并抛出
     */
    public func generateError(response: OAuth4cjResponse): Unit
}
```

###### 1.5.1.8 HeaderExtractor 接口

```cangjie
/**
 * 生成 OAuth4cj Authorization 标头，以便在请求中包含一个简单的命令对象。
 */
public interface HeaderExtractor {
    /**
     * 生成一个 OAuth4cj “Authorization” Http 标头，作为签名包含在请求中。
     *
     * @参数 request 检查请求并生成标头
     * @返回值 String Http 标头
     */
    func extract(request: OAuth4cjRequest): String
}
```

###### 1.5.1.9 HeaderExtractorImpl 类

```cangjie
/**
 * HeaderExtractor 接口的默认实现。符合 OAuth 1.0a。
 */
public class HeaderExtractorImpl <: HeaderExtractor {
    /**
     * 生成一个 OAuth4cj “Authorization” Http 标头，作为签名包含在请求中。
     *
     * @参数 request 检查请求并生成标头
     * @返回值 String Http 标头
     * @异常 OAuth4cjParametersMissingException 从响应主体中无法获取到参数时抛出
     */
    public func extract(request: OAuth4cjRequest): String
}
```

###### 1.5.1.10 OAuth1AccessTokenExtractor 类

```cangjie
/**
 * OAuth1AccessTokenExtractor 是抽象类 AbstractOAuth1TokenExtractor 的子类。
 */
public class OAuth1AccessTokenExtractor <: AbstractOAuth1TokenExtractor<OAuth1AccessToken> {
    /**
     * 生成一个新的 OAuth1AccessTokenExtractor 实例。
     *
     * @返回值 OAuth1AccessTokenExtractor 生成的 OAuth1AccessTokenExtractor 实例。
     */
    public static func instance(): OAuth1AccessTokenExtractor
}
```

###### 1.5.1.11 OAuth1AccessTokenJSONExtractor 类

```cangjie
/**
 * OAuth1AccessTokenJSONExtractor 是抽象类 AbstractOAuth1JSONTokenExtractor 的子类。
 */
public class OAuth1AccessTokenJSONExtractor <: AbstractOAuth1JSONTokenExtractor<OAuth1AccessToken> {
    /**
     * 生成一个新的 OAuth1AccessTokenJSONExtractor 实例。
     *
     * @返回值 OAuth1AccessTokenJSONExtractor 生成的 OAuth1AccessTokenJSONExtractor 实例。
     */
    public static func instance(): OAuth1AccessTokenJSONExtractor
}
```

###### 1.5.1.12 OAuth1RequestTokenExtractor 类

```cangjie
/**
 * OAuth1RequestTokenExtractor 是抽象类 AbstractOAuth1TokenExtractor 的子类。
 */
public class OAuth1RequestTokenExtractor <: AbstractOAuth1TokenExtractor<OAuth1RequestToken> {
    /**
     * 生成一个新的 OAuth1RequestTokenExtractor 实例。
     *
     * @返回值 OAuth1RequestTokenExtractor 生成的 OAuth1RequestTokenExtractor 实例。
     */
    public static func instance(): OAuth1RequestTokenExtractor
}
```

###### 1.5.1.13 OAuth1RequestTokenJSONExtractor 类

```cangjie
/**
 * OAuth1RequestTokenJSONExtractor 是抽象类 AbstractOAuth1JSONTokenExtractor 的子类。
 */
public class OAuth1RequestTokenJSONExtractor <: AbstractOAuth1JSONTokenExtractor<OAuth1RequestToken> {
    /**
     * 生成一个新的 OAuth1RequestTokenJSONExtractor 实例。
     *
     * @返回值 OAuth1RequestTokenJSONExtractor 生成的 OAuth1RequestTokenJSONExtractor 实例。
     */
    public static func instance(): OAuth1RequestTokenJSONExtractor
}
```

###### 1.5.1.14 OAuth2AccessTokenExtractor 类

```cangjie
/**
 * 用于 OAuth 2.0 的 TokenExtractor 的自定义实现。
 */
public class OAuth2AccessTokenExtractor <: TokenExtractor<OAuth2AccessToken> {
    /**
     * 生成一个新的 OAuth2AccessTokenExtractor 实例。
     *
     * @返回值 OAuth2AccessTokenExtractor 生成的 OAuth2AccessTokenExtractor 实例。
     */
    public static func instance(): OAuth2AccessTokenExtractor

    /**
     * 从 HTTP 响应的内容中提取特定类型的令牌。
     *
     * @参数 response 从此响应中获取令牌
     * @返回值 OAuth2AccessToken Token 的子类型
     * @异常 IOException 从响应中检索正文失败时抛出
     * @异常 IllegalArgumentException 响应体为空时抛出
     * @异常 OAuth4cjException 获取响应失败、响应正文有误时抛出
     */
    public func extract(response: OAuth4cjResponse): OAuth2AccessToken
}
```

###### 1.5.1.15 OAuth2AccessTokenJsonExtractor 类

```cangjie
/**
 * OAuth 2.0 的 AbstractJsonExtractor 抽象类和 TokenExtractor 接口的实现类。
 * 用于 OAuth 2.0 的 TokenExtractor 的 JSON 实现.
 */
public class OAuth2AccessTokenJsonExtractor <: AbstractJsonExtractor & TokenExtractor<OAuth2AccessToken> {
    /**
     * 生成一个新的 OAuth2AccessTokenJsonExtractor 实例。
     *
     * @返回值 OAuth2AccessTokenJsonExtractor 生成的 OAuth2AccessTokenJsonExtractor 实例。
     */
    public static func instance(): OAuth2AccessTokenJsonExtractor

    /**
     * 从 HTTP 响应的内容中提取特定类型的令牌。
     *
     * @参数 response 从响应中获取令牌
     * @返回值 OAuth2AccessToken Token 的子类型
     * @异常 IOException 从响应中检索正文失败时抛出
     * @异常 IllegalArgumentException 响应体为空时抛出
     */
    public func extract(response: OAuth4cjResponse): OAuth2AccessToken

    /**
     * 从响应主体中获取错误响应的字段信息，封装成一个 OAuth2AccessTokenErrorResponseException 异常并抛出。
     *
     * @参数 response 从此响应中获取错误消息
     * @异常 IOException 如果在以字符串形式获取响应主体时发生错误，则会抛出 IOException。
     * @异常 OAuth2AccessTokenErrorResponseException 从响应主体中获取错误响应的字段信息，封装并抛出 
     */
    public func generateError(response: OAuth4cjResponse): Unit
}
```

##### 1.5.2 示例

```cangjie
from oauth4cj import oauth4cj.*

public func createSampleOAuthRequest(): OAuth4cjRequest {
    let request: OAuth4cjRequest = OAuth4cjRequest(Verb.GET, "http://example.com")
    request.addOAuthParameter(OAuthConstants.TIMESTAMP, "123456")
    request.addOAuthParameter(OAuthConstants.CONSUMER_KEY, "AS#$^*@&")
    request.addOAuthParameter(OAuthConstants.CALLBACK, "http://example/callback")
    request.addOAuthParameter(OAuthConstants.SIGNATURE, "OAuth-Signature")
    return request
}

public func testBaseStringExtractor_01(): Int32 {
    let extractor: BaseStringExtractorImpl = BaseStringExtractorImpl()
    let expected: String = "GET&http%3A%2F%2Fexample.com&oauth_callback%3Dhttp%253A%252F%252Fexample%252Fcallback" +
            "%26oauth_consumer_key%3DAS%2523%2524%255E%252A%2540%2526%26oauth_signature%3DOAuth-Signature" +
            "%26oauth_timestamp%3D123456"
    let request: OAuth4cjRequest = createSampleOAuthRequest()
    let baseString: String = extractor.extract(request)
    if (baseString != expected) {
        return 1
    }
    println("baseString.equals(expected) = ${baseString.equals(expected)}")
    return 0
}

main() {
    var test_01 = testBaseStringExtractor_01()
    if (test_01 != 0){
        return test_01
    }
    return test_01
}
```

执行结果如下：

```shell
baseString.equals(expected) = true
```

#### 1.6 Builder模式的实现，具有创建OAuthService的流畅接口，OAuth协议1.0a/2.0版的默认实现

1.Builder模式的实现，具有创建OAuthService的流畅接口
2.OAuth协议1.0a/2.0版的默认实现, 通过API的具体实现进行扩展，提供端点和端点http请求类型

##### 1.6.1 主要接口

###### 1.6.1.1 BearerSignature签名接口

```cangjie
public interface BearerSignature {
    /**
     * 签名请求
     *
     * @参数 accessToken 访问令牌
     * @参数 request oauth请求
     */
    func signRequest(accessToken: String, request: OAuth4cjRequest): Unit
}
```

```cangjie
public class BearerSignatureAuthorizationRequestHeaderField {
    /**
     * 获取签名授权请求头字段的实例
     * 
     * @返回值 BearerSignatureAuthorizationRequestHeaderField实例
     */
    public static func instance(): BearerSignatureAuthorizationRequestHeaderField 
}

extend BearerSignatureAuthorizationRequestHeaderField <: BearerSignature {
    /**
     * 签名请求
     *
     * @参数 accessToken 访问令牌
     * @参数 request oauth请求
     */
    public func signRequest(accessToken: String, request: OAuth4cjRequest): Unit 
}
```

```cangjie
public class BearerSignatureURIQueryParameter {
    /**
     * 获取签名URI查询参数的实例
     * 
     * @返回值 BearerSignatureURIQueryParameter BearerSignatureURIQueryParameter实例
     */
    public static func instance(): BearerSignatureURIQueryParameter
}

extend BearerSignatureURIQueryParameter <: BearerSignature {
    /**
     * 签名请求
     *
     * @参数 accessToken 访问令牌
     * @参数 request oauth请求
     */
    public func signRequest(accessToken: String, request: OAuth4cjRequest): Unit
}
```
###### 1.6.1.2 ClientAuthentication接口

```cangjie
public interface ClientAuthentication {
    /**
     * 向请求添加客户端身份验证
     *
     * @参数 request oauth请求
     * @参数 apiKey api密钥
     * @参数 apiSecret api加密
     */
    func addClientAuthentication(request: OAuth4cjRequest, apiKey: String, apiSecret: String): Unit
}
```

```cangjie
public class HttpBasicAuthenticationScheme {
    /**
     * 获取HttpBasic身份验证方案的实例
     * 
     * @返回值 HttpBasicAuthenticationScheme HttpBasicAuthenticationScheme实例
     */
    public static func instance(): HttpBasicAuthenticationScheme
}

extend HttpBasicAuthenticationScheme <: ClientAuthentication {
    /**
     * 向请求添加客户端身份验证
     *
     * @参数 request oauth请求
     * @参数 apiKey api密钥
     * @参数 apiSecret api加密
     */
    public func addClientAuthentication(request: OAuth4cjRequest, apiKey: String, apiSecret: String): Unit 
}
```

```cangjie
public class RequestBodyAuthenticationScheme {
    /**
     * 获取请求体身份验证方案的实例
     * 
     * @返回值 RequestBodyAuthenticationScheme RequestBodyAuthenticationScheme实例
     */
    public static func instance(): RequestBodyAuthenticationScheme 
}

extend RequestBodyAuthenticationScheme <: ClientAuthentication {
    /**
     * 向请求添加客户端身份验证
     *
     * @参数 request oauth请求
     * @参数 apiKey api密钥
     * @参数 apiSecret api加密
     */
    public func addClientAuthentication(request: OAuth4cjRequest, apiKey: String, apiSecret: String): Unit
}
```

###### 1.6.1.3 OAuth2Error错误类型枚举

```cangjie
public enum OAuth2Error {
    | INVALID_REQUEST
    | UNAUTHORIZED_CLIENT
    | ACCESS_DENIED
    | UNSUPPORTED_RESPONSE_TYPE
    | INVALID_SCOPE
    | SERVER_ERROR
    | TEMPORARILY_UNAVAILABLE
    | INVALID_CLIENT
    | INVALID_GRANT
    | UNSUPPORTED_GRANT_TYPE
    | INVALID_TOKEN
    | INSUFFICIENT_SCOPE
    | UNSUPPORTED_TOKEN_TYPE
    | AUTHORIZATION_PENDING
    | SLOW_DOWN
    | EXPIRED_TOKEN

    /**
     * 解析字符串生成OAuth2Error对象
     *
     * @返回值 OAuth2Error OAuth2Error对象
     * @异常 IllegalArgumentException errorString字符串不在给定范围内时抛出
     */
    public static func parseFrom(errorString: String): OAuth2Error 

    /**
     * 获取错误类型字符串
     *
     * @返回值 String 错误类型字符串
     */
    public func getErrorString(): String
}

```

###### 1.6.1.4 OAuth2撤销令牌响应转换器

```cangjie
public class OAuth2RevokeTokenResponseConverter {
    /**
     * 构造函数
     */
    public init()
    
    /**
     * 检测响应是否成功，如果失败，可以提取响应中的错误信息进行处理
     * 
     * @参数 response 撤销操作响应信息
     */
    public func convert(response: OAuth4cjResponse): Unit
}
```

###### 1.6.1.5 撤销请求类型枚举

```cangjie
public enum TokenTypeHint {
    | ACCESS_TOKEN_HINT
    | REFRESH_TOKEN_HINT

    /**
     * 获取token类型字符串
     * 
     * @返回值 String token类型字符串
     */
    public func getValue(): String 
}
```

###### 1.6.1.6 范围字符串构造器

```cangjie
public class ScopeBuilder {
    /**
     * 构造函数
     */
    public init()

    /**
     * 构造函数
     *
     * @参数 scope 范围字符串
     */
    public init(scope: String)

    /**
     * 构造函数
     *
     * @参数 scopes 范围字符串数组
     */
    public init(scopes: Array<String>)

    /**
     * 构造函数
     *
     * @参数 scopes 范围字符串集合
     */
    public init(scopes: Collection<String>)

    /**
     * Add scope
     *
     * @参数 scope 范围字符串
     * @返回值 ScopeBuilder ScopeBuilder实例
     */
    public func withScope(scope: String): ScopeBuilder

    /**
     * Add scopes
     *
     * @参数 scopes 范围字符串数组
     * @返回值 ScopeBuilder ScopeBuilder实例
     */
    public func withScopes(scopes: Array<String>): ScopeBuilder

    /**
     * Add scopes
     *
     * @参数 scopes 范围字符串集合
     * @返回值 ScopeBuilder ScopeBuilder实例
     */
    public func withScopes(scopes: Collection<String>): ScopeBuilder

    /**
     * 构造完整的范围字符串
     *
     * @返回值 String 完整的范围字符串
     * @异常 IllegalArgumentException scope内容为空时抛出
     */
    public func build(): String
}
```

###### 1.6.1.7 service构造器通用接口 

```cangjie
public interface ServiceBuilderCommon {
    /**
     * 添加回调url
     *
     * @参数 callback 回调url。必须是有效的url或“oob”
     * @返回值 ServiceBuilderCommon ServiceBuilderCommon实例
     */
    func setCallback(callback: String): ServiceBuilderCommon

    /**
     * 配置 api key
     *
     * @参数 apiKey 应用程序的api密钥
     * @返回值 ServiceBuilderCommon ServiceBuilderCommon实例
     */
    func setApiKey(apiKey: String): ServiceBuilderCommon

    /**
     * 配置 api secret
     *
     * @参数 apiSecret 应用程序的api密码
     * @返回值 ServiceBuilderCommon ServiceBuilderCommon实例
     */
    func setApiSecret(apiSecret: String): ServiceBuilderCommon

    /**
     * 配置空 api secret
     *
     * @返回值 ServiceBuilderCommon ServiceBuilderCommon实例
     */
    func setApiSecretIsEmptyStringUnsafe(): ServiceBuilderCommon

    /**
     * 配置 HttpClientConfig
     *
     * @参数 httpClientConfig Http客户端配置实例
     * @返回值 ServiceBuilderCommon ServiceBuilderCommon实例
     */
    func setHttpClientConfig(httpClientConfig: Option<HttpClientConfig>): ServiceBuilderCommon

    /**
     * 配置 HttpClient
     *
     * @参数 httpClient 外部创建的HTTP客户端
     * @返回值 ServiceBuilderCommon ServiceBuilderCommon实例
     */
    func setHttpClient(httpClient: Option<HttpClient>): ServiceBuilderCommon

    /**
     * 配置 HttpClientProvider
     *
     * @参数 HttpClientProvider 外部创建的HTTP客户端提供者
     * @返回值 ServiceBuilderCommon ServiceBuilderCommon实例
     */
    public func setHttpClientProvider(httpClientProvider: Option<HttpClientProvider>): ServiceBuilderCommon 

    /**
     * 配置用户代理
     *
     * @参数 userAgent 用户代理
     * @返回值 ServiceBuilderCommon ServiceBuilderCommon实例
     */
    func setUserAgent(userAgent: String): ServiceBuilderCommon
}
```

###### 1.6.1.8 service构造器oauth1.0实现 

```cangjie
public class ServiceBuilderOAuth10a <: ServiceBuilderCommon {
    /**
     * 构造函数
     *
     * @参数 apiKey apikey字符串
     * @异常 IllegalArgumentException 如果字符串为空或者字符串中的字符是Unicode空白字符时抛出
     */
    public init(apiKey: String)

    /**
     * 设置回调url字符串
     *
     * @参数 callback 回调url字符串
     * @返回值 ServiceBuilderOAuth10a ServiceBuilderOAuth10a实例
     */
    public func setCallback(callback: String): ServiceBuilderOAuth10a

    /**
     * 设置 Api Key
     *
     * @参数 apiKey apikey字符串
     * @返回值 ServiceBuilderOAuth10a ServiceBuilderOAuth10a实例
     * @异常 IllegalArgumentException 如果字符串为空或者字符串中的字符是Unicode空白字符时抛出
     */
    public func setApiKey(apiKey: String): ServiceBuilderOAuth10a

    /**
     * 设置 Api Secret
     *
     * @参数 apiSecret apiSecret字符串
     * @返回值 ServiceBuilderOAuth10a ServiceBuilderOAuth10a实例
     * @异常 IllegalArgumentException 如果字符串为空或者字符串中的字符是Unicode空白字符时抛出
     */
    public func setApiSecret(apiSecret: String): ServiceBuilderOAuth10a 

    /**
     * 设置空的 Api Secret
     *
     * @返回值 ServiceBuilderOAuth10a ServiceBuilderOAuth10a实例
     */
    public func setApiSecretIsEmptyStringUnsafe(): ServiceBuilderOAuth10a 

    /**
     * 设置默认范围
     *
     * @参数 scope 范围字符串
     * @返回值 ServiceBuilderOAuth10a ServiceBuilderOAuth10a实例
     * @异常 IllegalArgumentException 如果字符串为空或者字符串中的字符是Unicode空白字符时抛出
     */
    public func withScope(scope: String): ServiceBuilderOAuth10a 

    /**
     * 配置 HttpClientConfig
     *
     * @参数 httpClientConfig Http客户端配置实例
     * @返回值 ServiceBuilderOAuth10a ServiceBuilderOAuth10a实例
     * @异常 IllegalArgumentException httpClientConfig为空时抛出
     */
    public func setHttpClientConfig(httpClientConfig: Option<HttpClientConfig>): ServiceBuilderOAuth10a 

    /**
     * 配置 HttpClient
     *
     * @参数 httpClient 外部创建的HTTP客户端
     * @返回值 ServiceBuilderOAuth10a ServiceBuilderOAuth10a实例
     */
    public func setHttpClient(httpClient: Option<HttpClient>): ServiceBuilderOAuth10a 

    /**
     * 配置 HttpClientProvider
     *
     * @参数 HttpClientProvider 外部创建的HTTP客户端提供者
     * @返回值 ServiceBuilderOAuth10a ServiceBuilderOAuth10a实例
     */
    public func setHttpClientProvider(httpClientProvider: Option<HttpClientProvider>): ServiceBuilderOAuth10a 

    /**
     * 配置用户代理
     *
     * @参数 userAgent 用户代理
     * @返回值 ServiceBuilderOAuth10a ServiceBuilderOAuth10a实例
     */
    public func setUserAgent(userAgent: String): ServiceBuilderOAuth10a 

    /**
     * 构造OAuth10aService实例
     *
     * @参数 api DefaultApi10a实例
     * @返回值 OAuth10aService OAuth10aService实例
     */
    public func build(api: DefaultApi10a): OAuth10aService 

    /**
     * 设置debugStream, 后续优化的预留接口
     *
     * @param debugStream Option<OutputStream>对象
     * @return ServiceBuilderOAuth10a ServiceBuilderOAuth10a实例
     */
    public func setDebugStream(debugStream: Option<OutputStream>): ServiceBuilderOAuth10a 
}

```

###### 1.6.1.9 service构造器oauth2.0实现  

```cangjie
public class ServiceBuilderOAuth20 <: ServiceBuilderCommon {
    /**
     * 构造函数
     *
     * @参数 apiKey apikey字符串
     * @异常 IllegalArgumentException 如果字符串为空或者字符串中的字符是Unicode空白字符时抛出
     */
    public init(apiKey: String) {
        setApiKey(apiKey)
    }

    /**
     * 添加回调url
     *
     * @参数 callback 回调url。必须是有效的url或“oob”
     * @返回值 ServiceBuilderOAuth20 ServiceBuilderOAuth20实例
     */
    public func setCallback(callback: String): ServiceBuilderOAuth20

    /**
     * 配置 api key
     *
     * @参数 apiKey 应用程序的api密钥
     * @返回值 ServiceBuilderOAuth20 ServiceBuilderOAuth20实例
     * @异常 IllegalArgumentException 如果字符串为空或者字符串中的字符是Unicode空白字符时抛出
     */
    public func setApiKey(apiKey: String): ServiceBuilderOAuth20 

    /**
     * 配置 api secret
     *
     * @参数 apiSecret 应用程序的api密码
     * @返回值 ServiceBuilderOAuth20 ServiceBuilderOAuth20实例
     * @异常 IllegalArgumentException 如果字符串为空或者字符串中的字符是Unicode空白字符时抛出
     */
    public func setApiSecret(apiSecret: String): ServiceBuilderOAuth20 

    /**
     * 配置空 api secret
     *
     * @返回值 ServiceBuilderOAuth20 ServiceBuilderOAuth20实例
     */
    public func setApiSecretIsEmptyStringUnsafe(): ServiceBuilderOAuth20 

    /**
     * 配置默认的 OAuth 2.0 范围
     *
     * @参数 defaultScope OAuth作用域，用作默认作用域
     * @返回值 ServiceBuilderOAuth20 ServiceBuilderOAuth20实例
     * @异常 IllegalArgumentException 如果字符串为空或者字符串中的字符是Unicode空白字符时抛出
     */
    public func setDefaultScope(defaultScope: String): ServiceBuilderOAuth20

    /**
     * 配置默认的 OAuth 2.0 范围
     *
     * @参数 defaultScope OAuth作用域，用作默认作用域
     * @返回值 ServiceBuilderOAuth20 ServiceBuilderOAuth20实例
     */
    public func setDefaultScope(scopeBuilder: ScopeBuilder): ServiceBuilderOAuth20 

    /**
     * 配置响应类型
     *
     * @参数 responseType 响应类型
     * @返回值 ServiceBuilderOAuth20 ServiceBuilderOAuth20实例
     * @异常 IllegalArgumentException 如果字符串为空或者字符串中的字符是Unicode空白字符时抛出
     */
    public func setResponseType(responseType: String): ServiceBuilderOAuth20

    /**
     * 配置 HttpClientConfig
     *
     * @参数 httpClientConfig Http客户端配置实例
     * @返回值 ServiceBuilderOAuth20 ServiceBuilderOAuth20实例
     * @异常 IllegalArgumentException httpClientConfig为空时抛出
     */
    public func setHttpClientConfig(httpClientConfig: Option<HttpClientConfig>): ServiceBuilderOAuth20 

    /**
     * 配置 HttpClient
     *
     * @参数 httpClient 外部创建的HTTP客户端
     * @返回值 ServiceBuilderOAuth20 ServiceBuilderOAuth20实例
     */
    public func setHttpClient(httpClient: Option<HttpClient>): ServiceBuilderOAuth20

    /**
     * 配置 HttpClientProvider
     *
     * @参数 HttpClientProvider 外部创建的HTTP客户端提供者
     * @返回值 ServiceBuilderOAuth20 ServiceBuilderOAuth20实例
     */
    public func setHttpClientProvider(httpClientProvider: Option<HttpClientProvider>): ServiceBuilderOAuth20

    /**
     * 配置用户代理
     *
     * @参数 userAgent 用户代理
     * @返回值 ServiceBuilderOAuth20 ServiceBuilderOAuth20实例
     */
    public func setUserAgent(userAgent: String): ServiceBuilderOAuth20 

    /**
     * 构建OAuth20Service实例
     *
     * @参数 api DefaultApi20实例
     * @返回值 OAuth20Service OAuth20Service实例
     */
    public func build(api: DefaultApi20): OAuth20Service 

    /**
     * 设置debugStream, 后续优化的预留接口
     *
     * @param debugStream Option<OutputStream>对象
     * @return ServiceBuilderOAuth20 ServiceBuilderOAuth20实例
     */
    public func setDebugStream(debugStream: Option<OutputStream>): ServiceBuilderOAuth20
}

```

###### 1.6.1.10 AccessTokenRequestParams
```cangjie
public class AccessTokenRequestParams {
    /**
     * 创建AccessTokenRequestParams对象
     *
     * @参数 code 请求状态码
     */
    public init(code: String)

    /**
     * 创建AccessTokenRequestParams对象
     *
     * @参数 code 请求状态码
     * @返回值 AccessTokenRequestParams AccessTokenRequestParams对象
     */
    public static func create(code: String): AccessTokenRequestParams

    /**
     * 设置pkce编码验证字符串
     *
     * @参数 pkceCodeVerifier pkce编码验证字符串
     * @返回值 AccessTokenRequestParams AccessTokenRequestParams对象
     */
    public func setPKCECodeVerifier(pkceCodeVerifier: String): AccessTokenRequestParams

    /**
     * 设置范围
     *
     * @参数 scope 范围字符串
     * @返回值 AccessTokenRequestParams AccessTokenRequestParams对象
     */
    public func setScope(scope: String): AccessTokenRequestParams

    /**
     * 设置范围
     *
     * @参数 scope ScopeBuilder对象
     * @返回值 AccessTokenRequestParams AccessTokenRequestParams对象
     * @异常 IllegalArgumentException 如果字符串为空或者字符串中的字符是Unicode空白字符时抛出
     */
    public func setScope(scope: ScopeBuilder): AccessTokenRequestParams 

    /**
     * 添加附加参数集合
     *
     * @参数 extraParameters 附加参数集合
     * @返回值 AccessTokenRequestParams AccessTokenRequestParams对象
     */
    public func addExtraParameters(extraParameters: HashMap<String, String>): AccessTokenRequestParams

    /**
     * 添加附加参数
     *
     * @参数 name 参数名
     * @参数 value 参数值
     * @返回值 AccessTokenRequestParams AccessTokenRequestParams对象
     */
    public func addExtraParameter(name: String, value: String): AccessTokenRequestParams

    /**
     * 设置附加参数集合
     *
     * @参数 extraParameters 附加参数集合
     * @返回值 AccessTokenRequestParams AccessTokenRequestParams对象
     */
    public func setExtraParameters(extraParameters: HashMap<String, String>): AccessTokenRequestParams

    /**
     * 获取附加参数集合
     *
     * @返回值 HashMap<String, String> 附加参数集合
     */
    public func getExtraParameters(): HashMap<String, String> 

    /**
     * 获取状态码
     *
     * @返回值 String 状态码
     */
    public func getCode(): String

    /**
     * 获取pkce编码验证字符串
     *
     * @返回值 String pkce编码验证字符串
     */
    public func getPkceCodeVerifier(): Option<String> 

    /**
     * 获取范围字符串
     *
     * @返回值 String 范围字符串
     */
    public func getScope(): Option<String> 
}
```

###### 1.6.1.11 授权Url构造器
```cangjie
public class AuthorizationUrlBuilder {
    /**
     * 创建AuthorizationUrlBuilder对象
     *
     * @参数 oauth20Service OAuth20Service对象
     */
    public init(oauth20Service: OAuth20Service)

    /**
     * 设置状态
     *
     * @参数 state 状态字符串
     * @返回值 AuthorizationUrlBuilder AuthorizationUrlBuilder对象
     */
    public func setState(state: String): AuthorizationUrlBuilder

    /**
     * 设置附加参数集合
     *
     * @参数 additionalParams 附加参数集合
     * @返回值 AuthorizationUrlBuilder AuthorizationUrlBuilder对象
     */
    public func setAdditionalParams(additionalParams: HashMap<String, String>): AuthorizationUrlBuilder

    /**
     * 设置PKCE对象
     *
     * @参数 pkce Option<PKCE>对象
     * @返回值 AuthorizationUrlBuilder AuthorizationUrlBuilder对象
     */
    public func setPkce(pkce: Option<PKCE>): AuthorizationUrlBuilder

    /**
     * 初始化默认的PKCE对象
     *
     * @返回值 AuthorizationUrlBuilder AuthorizationUrlBuilder对象
     */
    public func initPKCE(): AuthorizationUrlBuilder

    /**
     * 设置范围
     *
     * @参数 scope 范围字符串
     * @返回值 AuthorizationUrlBuilder AuthorizationUrlBuilder对象
     */
    public func setScope(scope: Option<String>): AuthorizationUrlBuilder

    /**
     * 获取PKCE对象
     *
     * @返回值 Option<PKCE> Option<PKCE>对象
     */
    public func getPkce(): Option<PKCE>

    /**
     * 构建授权Url字符串
     *
     * @返回值 String 授权Url字符串
     */
    public func build(): String
}
```

##### 1.6.2 示例

```cangjie
from std import collection.*
from oauth4cj import oauth4cj.*
main() {
    var scopeString: ArrayList<String> = ArrayList<String>()
    scopeString.append("scope_1")
    scopeString.append("scope_2")
    scopeString.append("scope_3")
    var scopeString_add: String = "scope_4"
    var scope: String = ScopeBuilder(scopeString).withScopes(scopeString_add).build()
    var montageString: String = "scope_1 scope_2 scope_3 scope_4"
    if (montageString!=scope) {
        return 1
    }
    println("Scope=${scope}")
    return 0
}
```

执行结果如下：
```cangjie
scope = scope_1 scope_2 scope_3 scope_4
```

#### 1.7 Builder模式的实现，提供 OAuth 和 OAuthService 的接口

Builder模式的实现，提供 OAuth 和 OAuthService 的接口

##### 1.7.1 主要接口

###### 1.7.1.1 OAuth1签名类型

```cangjie
public enum OAuth1SignatureType <: ToString  {
    | HEADER_SIGNATURE
    | QUERY_STRING_SIGNATURE
    
    /**
     * 获取OAuth1签名类型字符串
     * 
     * @返回值 String OAuth1签名类型字符串
     */
    public func toString(): String
}
```

###### 1.7.1.2 Oauth1.0的默认Api抽象类

```cangjie
public abstract class DefaultApi10a {
    /**
     * 返回访问令牌提取器
     *
     * @返回值 TokenExtractor<OAuth1AccessToken> 访问令牌提取器
     */
    public open func getAccessTokenExtractor(): TokenExtractor<OAuth1AccessToken>

    /**
     * 返回基础信息提取器
     *
     * @返回值 BaseStringExtractor 基础信息提取器
     */
    public open func getBaseStringExtractor(): BaseStringExtractor

    /**
     * 返回头信息提取器
     *
     * @返回值 HeaderExtractor 头信息提取器
     */
    public open func getHeaderExtractor(): HeaderExtractor

    /**
     * 返回请求令牌提取器
     *
     * @返回值 TokenExtractor<OAuth1RequestToken> 请求令牌提取器
     */
    public open func getRequestTokenExtractor(): TokenExtractor<OAuth1RequestToken>

    /**
     * 返回签名服务
     *
     * @返回值 SignatureService 签名服务
     */
    public open func getSignatureService(): SignatureService

    /**
     * 返回签名类型
     * 
     * @返回值 OAuth1SignatureType 签名类型, 在header、querystring等之间进行选择。默认为header
     */
    public open func getSignatureType(): OAuth1SignatureType

    /**
     * 返回时间戳服务
     *
     * @返回值 TimestampService 时间戳服务
     */
    public open func getTimestampService(): TimestampService

    /**
     * 返回访问令牌端点的操作类型，默认为POST
     *
     * @返回值 Verb 访问令牌端点的操作类型
     */
    public open func getAccessTokenVerb(): Verb

    /**
     * 返回请求令牌端点的操作类型，默认为POST
     *
     * @返回值 Verb 请求令牌端点的操作类型
     */
    public open func getRequestTokenVerb(): Verb

    /**
     * 返回接收请求令牌请求的URL
     *
     * @返回值 String 接收请求令牌请求的URL
     */
    public func getRequestTokenEndpoint(): String

    /**
     * 返回接收访问令牌请求的URL
     *
     * @返回值 String 接收访问令牌请求的URL
     */
    public func getAccessTokenEndpoint(): String 

    /**
     * 返回应该重定向用户以验证应用程序的URL
     *
     * @参数 requestToken 您需要授权的请求令牌
     * @返回值 String 应该重定向用户的URL
     */
    public open func getAuthorizationUrl(requestToken: OAuth1RequestToken): String

    /**
     * 创建OAuth10aService实例
     *
     * @参数 apiKey api key
     * @参数 apiSecret api secret
     * @参数 callback 回调url
     * @参数 scope 范围信息
     * @参数 debugStream debug流（java中标注为后续优化使用，暂时保留，传空即可）
     * @参数 userAgent 用户代理
     * @参数 httpClientConfig HTTP客户端配置信息
     * @参数 httpClient HTTP客户端
     * @参数 httpClientProvider HTTP客户端提供者
     * @返回值 OAuth10aService OAuth10aService实例
     */
    public func createService(apiKey:String, apiSecret: String, callback: String, scope: String,
            debugStream: Option<OutputStream>, userAgent: String, httpClientConfig: Option<HttpClientConfig>,
            httpClient: Option<HttpClient>, httpClientProvider: Option<HttpClientProvider>): OAuth10aService

    /**
     * 是否在请求中加入空的oauth_token参数
     * 客户端可能会从请求中省略空的“oauth_token”协议参数，但并非所有的oauth服务器都支持
     *
     * @返回值 Bool 是否在请求中加入空的oauth_token参数
     */
    public open func isEmptyOAuthTokenParamIsRequired(): Bool
}
```

###### 1.7.1.3 Oauth2.0的默认Api抽象类

```cangjie
public abstract class DefaultApi20 {

    /**
     * 返回访问令牌提取器
     *
     * @返回值 TokenExtractor<OAuth2AccessToken> 访问令牌提取器
     */
    public open func getAccessTokenExtractor(): TokenExtractor<OAuth2AccessToken>

    /**
     * 返回访问令牌端点的操作类型，默认为POST
     *
     * @返回值 Verb 访问令牌端点的操作类型
     */
    public open func getAccessTokenVerb(): Verb

    /**
     * 返回接收访问令牌请求的URL
     *
     * @返回值 String 接收访问令牌请求的URL
     */
    public func getAccessTokenEndpoint(): String

    /**
     * 返回刷新令牌的端点
     *
     * @返回值 String 刷新令牌的端点
     */
    public open func getRefreshTokenEndpoint(): String

    /**
     * 返回OAuth 2.0 令牌撤销端点
     *
     * @返回值 String 令牌撤销端点，允许客户端通知授权服务器不再需要以前获得的刷新或访问令牌
     * @异常 IllegalArgumentException API不支持撤销令牌或者没有获取到相关信息时抛出，默认不支持，子类实现时可以覆写该方法
     */
    public open func getRevokeTokenEndpoint(): String

    /**
     * 返回应该重定向用户以验证应用程序的URL
     *
     * @参数 responseType 响应类型
     * @参数 apiKey apiKey
     * @参数 additionalParams 要添加到URL的GET参数
     * @参数 callback 回调url
     * @参数 state 状态信息
     * @参数 scope 范围信息
     * @返回值 String 应该重定向用户的URL
     */
    public open func getAuthorizationUrl(responseType: String, apiKey: String, callback: ?String, scope: ?String,
            state: ?String, additionalParams: HashMap<String, String>): String

    /**
     * 创建OAuth20Service实例
     *
     * @参数 apiKey api key
     * @参数 apiSecret api secret
     * @参数 callback 回调url
     * @参数 defaultScope 范围信息
     * @参数 responseType 响应类型
     * @参数 debugStream debug流（java中标注为后续优化使用，暂时保留，传空即可）
     * @参数 userAgent 用户代理
     * @参数 httpClientConfig HTTP客户端配置信息
     * @参数 httpClient HTTP客户端
     * @参数 httpClientProvider HTTP客户端提供者
     * @返回值 OAuth20Service OAuth20Service实例
     */
    public open func createService(apiKey: String, apiSecret: String, callback: String, defaultScope: String,
            responseType: String, debugStream: Option<OutputStream>, userAgent: String, 
            httpClientConfig: Option<HttpClientConfig>, httpClient: Option<HttpClient>,
            httpClientProvider: Option<HttpClientProvider>): OAuth20Service

    /**
     * 返回签名
     *
     * @返回值 BearerSignature BearerSignature实例
     */
    public open func getBearerSignature(): BearerSignature

    /**
     * 返回客户端身份验证
     *
     * @返回值 ClientAuthentication ClientAuthentication实例
     */
    public open func getClientAuthentication(): ClientAuthentication

    /**
     * 返回OAuth 2.0设备授权端点
     *
     * @返回值 String 设备授权端点
     * @异常 IllegalArgumentException API不支持设备授权或者没有获取到相关信息时抛出，默认不支持，子类实现时可以覆写该方法
     */
    public open func getDeviceAuthorizationEndpoint(): String 

    /**
     * 返回设备授权信息提取器
     *
     * @返回值 DeviceAuthorizationJsonExtractor DeviceAuthorizationJsonExtractor实例
     */
    public open func getDeviceAuthorizationExtractor(): DeviceAuthorizationJsonExtractor
}
```

###### 1.7.1.4 OAuthService抽象类 

```cangjie
public abstract class OAuthService <: Resource {
    /**
     * 构造函数
     *
     * @参数 apiKey api key
     * @参数 apiSecret api secret
     * @参数 callback 回调url
     * @参数 debugStream debug模式输出流，不开启debug模式时设置为Option<OutputStream>.None
     * @参数 userAgent 用户代理
     * @参数 httpClientConfig Http客户端配置信息对象
     * @参数 httpClient HTTP客户端对象
     * @参数 httpClientProvider HTTP客户端提供者对象
     */
    public init(apiKey: String, apiSecret: String, callback: String, debugStream: Option<OutputStream>,
            userAgent: String, httpClientConfig: Option<HttpClientConfig>, httpClient: Option<HttpClient>,
            httpClientProvider: Option<HttpClientProvider>) 

    /**
     * 获取apiKey
     *
     * @返回值 String apiKey字符串
     */
    public open func getApiKey(): String

    /**
     * 获取apiSecret
     *
     * @返回值 String apiSecret字符串
     */
    public open func getApiSecret(): String

    /**
     * 获取回调url
     *
     * @返回值 Option<String> 回调url
     */
    public open func getCallback(): Option<String>

    /**
     * 是否已经关闭，覆写Resource的方法
     *
     * @返回值 Bool 如果已经调用过 close 方法，返回 true，否则返回 false
     */
    public open func isClosed(): Bool

    /**
     * 关闭httpClient
     */
    public open func close(): Unit

    /**
     * 获取版本号
     *
     * @返回值 String 版本号
     */
    public func getVersion(): String

    /**
     * 异步请求执行
     * 
     * @参数 request OAuth4cjRequest请求对象
     * @返回值 Future<Any> Future格式的响应数据
     */
    public func executeAsync(request: OAuth4cjRequest): Future<Any>

    /**
     * 异步请求执行
     * 
     * @参数 request OAuth4cjRequest请求对象
     * @参数 callback OAuthAsyncRequestCallback请求回调对象, 允许为None
     * @返回值 Future<Any> Future格式的响应数据
     */
    public func execute(request: OAuth4cjRequest, callback: Option<OAuthAsyncRequestCallback>): Future<Any>

    /**
     * 异步请求执行
     * 
     * @参数 request OAuth4cjRequest请求对象
     * @参数 callback OAuthAsyncRequestCallback请求回调对象, 允许为None
     * @参数 converter ResponseConverter响应验证对象, 允许为None
     * @返回值 Future<Any> Future格式的响应数据
     */
    public func execute(request: OAuth4cjRequest, callback: Option<OAuthAsyncRequestCallback>,
            converter: Option<ResponseConverter>): Future<Any>

    /**
     * 同步请求执行
     * 
     * @参数 request OAuth4cjRequest请求对象
     * @返回值 OAuth4cjResponse Response格式的响应数据
     */
    public func execute(request: OAuth4cjRequest): OAuth4cjResponse
}
```

###### 1.7.1.5 OAuth10aService OAuth1.0服务类

```cangjie
public class OAuth10aService <: OAuthService {
    /**
     * 构造函数
     *
     * @参数 api DefaultApi10a对象
     * @参数 apiKey api key
     * @参数 apiSecret api secret
     * @参数 callback 回调url
     * @参数 scope 范围
     * @参数 debugStream debug模式输出流，不开启debug模式时设置为Option<OutputStream>.None
     * @参数 userAgent 用户代理
     * @参数 httpClientConfig Http客户端配置信息对象
     * @参数 httpClient HTTP客户端对象
     * @参数 httpClientProvider HTTP客户端提供者对象
     */
    public init(api: DefaultApi10a, apiKey: String, apiSecret: String, callback: String, scope: Option<String>,
            debugStream: Option<OutputStream>, userAgent: String, httpClientConfig: Option<HttpClientConfig>,
            httpClient: Option<HttpClient>, httpClientProvider: Option<HttpClientProvider>)

    /**
     * 获取OAuth1RequestToken对象
     *
     * @返回值 OAuth1RequestToken OAuth1RequestToken 对象
     * @异常 OAuth4cjException 如果请求过程中发生异常时抛出
     */
    public func getRequestToken(): OAuth1RequestToken

    /**
     * 异步获取OAuth1RequestToken实例
     *
     * @返回值 Future<OAuth1RequestToken> Future格式的OAuth1RequestToken实例
     * @异常 OAuth4cjException 从响应信息中解析OAuth1RequestToken失败时抛出
     */
    public func getRequestTokenAsync(): Future<OAuth1RequestToken>

    /**
     * 异步获取OAuth1RequestToken实例
     *
     * @参数 callback OAuthAsyncRequestCallback异步请求回调对象
     * @返回值 Future<OAuth1RequestToken> Future格式的OAuth1RequestToken实例
     * @异常 OAuth4cjException 从响应信息中解析OAuth1RequestToken失败时抛出
     */
    public func getRequestTokenAsync(callback: Option<OAuthAsyncRequestCallback>): Future<OAuth1RequestToken>

    /**
     * 获取OAuth1AccessToken实例
     *
     * @参数 requestToken OAuth1RequestToken对象
     * @参数 oauthVerifier Oauth验证器
     * @返回值 OAuth1AccessToken OAuth1AccessToken对象
     * @异常 OAuth4cjException 如果请求过程中发生异常时抛出
     */
    public func getAccessToken(requestToken: OAuth1RequestToken, oauthVerifier: String): OAuth1AccessToken

    /**
     * 异步获取OAuth1AccessToken实例
     *
     * @参数 requestToken OAuth1RequestToken对象
     * @参数 oauthVerifier Oauth验证器
     * @返回值 Future<OAuth1AccessToken> Future格式的OAuth1AccessToken实例
     * @异常 OAuth4cjException 如果请求过程中发生异常，抛出OAuth4cjException
     */
    public func getAccessTokenAsync(requestToken: OAuth1RequestToken, oauthVerifier: String): 
        Future<OAuth1AccessToken>

    /**
     * 异步获取OAuth1AccessToken实例
     *
     * @参数 requestToken OAuth1RequestToken对象
     * @参数 oauthVerifier Oauth验证器
     * @参数 callback OAuthAsyncRequestCallback异步请求回调对象
     * @返回值 Future<OAuth1AccessToken> Future格式的OAuth1AccessToken实例
     * @异常 OAuth4cjException 从响应信息中解析OAuth1AccessToken失败时抛出
     */
    public func getAccessTokenAsync(requestToken: OAuth1RequestToken, oauthVerifier: String,
        callback: Option<OAuthAsyncRequestCallback>): Future<OAuth1AccessToken>

    /**
     * 签名请求
     *
     * @参数 token OAuth1AccessToken对象
     * @参数 request OAuth4cjRequest请求对象
     * @异常 OAuth4cjParametersMissingException OAuth4cjRequest的请求头信息为空时抛出
     * @异常 OAuth4cjSignatureException 签名失败时抛出
     */
    public func signRequest(token: OAuth1AccessToken, request: OAuth4cjRequest): Unit
    
    /**
     * 获取版本号
     *
     * @返回值 String 版本号
     */
    public func getVersion(): String

    /**
     * 返回已经授权的URL，重定向到URL验证你的应用
     *
     * @参数 requestToken OAuth1RequestToken对象
     * @返回值 String 已授权的重定向用户的URL
     */
    public func getAuthorizationUrl(requestToken: OAuth1RequestToken): String

    /**
     * 获取Api对象
     *
     * @返回值 DefaultApi10a DefaultApi10a对象
     */
    public func getApi(): DefaultApi10a 
}
```

###### 1.7.1.6 OAuth20Service 类

```cangjie
public class OAuth20Service <: OAuthService {
    
    /**
     * 根据参数创建一个 OAuth20Service 实例。
     * 
     * @参数 api - DefaultApi20 数据类型, OAuth 协议 2.0 版的默认实现。
     * @参数 apiKey - String 数据类型, api 密钥。
     * @参数 apiSecret - String 数据类型, api 机密。
     * @参数 callback - String 数据类型, 回调 url。
     * @参数 defaultScope - Option<String> 数据类型, 默认作用域。
     * @参数 responseType - String 数据类型, 响应类型。
     * @参数 debugStream - Option<OutputStream> 数据类型, 调试模式输出流，不使用时为 None。
     * @参数 userAgent - String 数据类型, 用户代理。
     * @参数 httpClientConfig - Option<HttpClientConfig> 数据类型, Http 客户端配置。
     * @参数 httpClient - Option<HttpClient> 数据类型, Http 客户端实例。
     * @参数 httpClientProvider - Option<HttpClientProvider> 数据类型, Http 客户端提供实例。
     */
    public init(api: DefaultApi20, apiKey: String, apiSecret: String, callback: String, 
        defaultScope: Option<String>, responseType: String, debugStream: Option<OutputStream>, 
        userAgent: String, httpClientConfig: Option<HttpClientConfig>, httpClient: Option<HttpClient>, 
        httpClientProvider: Option<HttpClientProvider>)
    
    /**
     * 获取版本号
     *
     * @返回值 String - 版本号
     */
    public func getVersion(): String
    
    /**
     * 签名请求。
     * 
     * @参数 accessToken - String 数据类型, 访问令牌。
     * @参数 request - OAuth4cjRequest 数据类型, OAuth4cjRequest请求实例。
     */
    public func signRequest(accessToken: String, request: OAuth4cjRequest): Unit
    
    /**
     * 签名请求。
     * 
     * @参数 accessToken - OAuth2AccessToken 数据类型, OAuth2 访问令牌。
     * @参数 request - OAuth4cjRequest 数据类型, OAuth4cjRequest请求实例。
     */
    public func signRequest(accessToken: OAuth2AccessToken, request: OAuth4cjRequest): Unit
    
    /**
     * 返回应该重定向用户以验证应用程序的 URL。
     * 
     * @返回值 String - 应该重定向用户的 URL。
     */
    public func getAuthorizationUrl(): String
    
    /**
     * 返回应该重定向用户以验证应用程序的 URL。
     * 
     * @参数 state - String 数据类型, 状态码。
     * @返回值 String - 应该重定向用户的 URL。
     */
    public func getAuthorizationUrl(state: String): String
    
    /**
     * 返回应该重定向用户以验证应用程序的 URL。
     * 
     * @参数 additionalParams - HashMap<String,String> 数据类型, 要添加到URL的任何其他 GET 参数。
     * @返回值 String - 应该重定向用户的 URL。
     */
    public func getAuthorizationUrl(additionalParams: HashMap<String,String>): String
    
    /**
     * 返回应该重定向用户以验证应用程序的 URL。
     * 
     * @参数 pkce - PKCE 数据类型, PKCE 实例。
     * @返回值 String - 应该重定向用户的 URL。
     */
    public func getAuthorizationUrl(pkce: PKCE): String
    
    /**
     * 获取 DefaultApi20 实例。
     * 
     * @返回值 DefaultApi20 - DefaultApi20 实例。
     */
    public func getApi(): DefaultApi20
    
    /**
     * 提取授权。
     * 
     * @参数 redirectLocation - String 数据类型, 重定向位置。
     * @返回值 OAuth2Authorization - OAuth2 授权。
     * @异常 OAuth4cjException 解码失败时抛出
     */
    public func extractAuthorization(redirectLocation: String): OAuth2Authorization
    
    /**
     * 获取响应类型。
     * 
     * @返回值 String - 响应类型。
     */
    public func getResponseType(): String
    
    /**
     * 获取默认作用域。
     * 
     * @返回值 Option<String> - 默认作用域，未设置时为None。
     */
    public func getDefaultScope(): Option<String>
    
    /**
     * 异步获取 OAuth2 访问令牌。
     * 
     * @参数 code - String 数据类型, 授权码。
     * @返回值 Future<OAuth2AccessToken> - 执行异步获取 OAuth2 访问令牌后的返回值。
     * @异常 OAuth4cjException 从响应中解析OAuth2AccessToken失败时抛出
     */
    public func getAccessTokenAsync(code: String): Future<OAuth2AccessToken>
    
    /**
     * 异步获取 OAuth2 访问令牌。
     * 
     * @参数 params - AccessTokenRequestParams 数据类型, 访问令牌请求参数。
     * @返回值 Future<OAuth2AccessToken> - 执行异步获取 OAuth2 访问令牌后的返回值。
     * @异常 OAuth4cjException 从响应中解析OAuth2AccessToken失败时抛出
     */
    public func getAccessTokenAsync(params: AccessTokenRequestParams): Future<OAuth2AccessToken>
    
    /**
     * 获取 OAuth2 访问令牌。
     * 
     * @参数 code - String 数据类型, 授权码。
     * @返回值 OAuth2AccessToken - OAuth2 访问令牌。
     * @异常 IOException 在获取字符串形式的响应正文时发生错误会抛出
     * @异常 OAuth2AccessTokenErrorResponseException 从响应体中获取错误响应的字段信息，封装并抛出
     * @异常 IllegalArgumentException 响应体为空时抛出
     */
    public func getAccessToken(code: String): OAuth2AccessToken
    
    /**
     * 获取 OAuth2 访问令牌。
     * 
     * @参数 params - AccessTokenRequestParams 数据类型, 访问令牌请求参数。
     * @返回值 OAuth2AccessToken - OAuth2 访问令牌。
     * @异常 IOException 在获取字符串形式的响应正文时发生错误会抛出
     * @异常 OAuth2AccessTokenErrorResponseException 从响应体中获取错误响应的字段信息，封装并抛出 
     * @异常 IllegalArgumentException 响应体为空时抛出
     */
    public func getAccessToken(params: AccessTokenRequestParams): OAuth2AccessToken
    
    /**
     * 异步获取 OAuth2 访问令牌。
     * 可选提供的回调将在令牌可用时使用令牌进行调用。
     * 
     * @参数 params - AccessTokenRequestParams 数据类型, 访问令牌请求参数。
     * @参数 callback - Option<OAuthAsyncRequestCallback> 数据类型, OAuth 异步请求回调。
     * @返回值 Future<OAuth2AccessToken> - 执行异步获取 OAuth2 访问令牌后的返回值。
     * @异常 OAuth4cjException 从响应中解析OAuth2AccessToken失败时抛出
     */
    public func getAccessToken(params: AccessTokenRequestParams, callback: Option<OAuthAsyncRequestCallback>): Future<OAuth2AccessToken>
    
    /**
     * 异步获取 OAuth2 访问令牌。
     * 可选提供的回调将在令牌可用时使用令牌进行调用。
     * 
     * @参数 code - String 数据类型, 授权码。
     * @参数 callback - Option<OAuthAsyncRequestCallback> 数据类型, OAuth 异步请求回调。
     * @返回值 Future<OAuth2AccessToken> - 执行异步获取 OAuth2 访问令牌后的返回值。
     * @异常 OAuth4cjException 从响应中解析OAuth2AccessToken失败时抛出
     */
    public func getAccessToken(code: String, callback: Option<OAuthAsyncRequestCallback>): Future<OAuth2AccessToken>
    
    /**
     * 异步获取刷新令牌。
     * 
     * @参数 refreshToken - String 数据类型, 刷新令牌。
     * @返回值 Future<OAuth2AccessToken> - 执行异步获取刷新令牌后的返回值。
     * @异常 OAuth4cjException 从响应中解析OAuth2AccessToken失败时抛出
     */
    public func refreshAccessTokenAsync(refreshToken: String): Future<OAuth2AccessToken>
    
    /**
     * 异步获取刷新令牌。
     * 
     * @参数 refreshToken - String 数据类型, 刷新令牌。
     * @参数 scope - String 数据类型, 作用域。
     * @返回值 Future<OAuth2AccessToken> - 执行异步获取刷新令牌后的返回值。
     * @异常 OAuth4cjException 从响应中解析OAuth2AccessToken失败时抛出
     */
    public func refreshAccessTokenAsync(refreshToken: String, scope: String): Future<OAuth2AccessToken>
    
    /**
     * 获取刷新令牌。
     * 
     * @参数 refreshToken - String 数据类型, 刷新令牌。
     * @返回值 OAuth2AccessToken - 刷新令牌。
     * @异常 IOException 在获取字符串形式的响应正文时发生错误会抛出
     * @异常 OAuth2AccessTokenErrorResponseException 从响应体中获取错误响应的字段信息，封装并抛出 
     * @异常 IllegalArgumentException 响应体为空时抛出
     */
    public func refreshAccessToken(refreshToken: String): OAuth2AccessToken
    
    /**
     * 获取刷新令牌。
     * 
     * @参数 refreshToken - String 数据类型, 刷新令牌。
     * @参数 scope - String 数据类型, 作用域。
     * @返回值 OAuth2AccessToken - 刷新令牌。
     * @异常 IOException 在获取字符串形式的响应正文时发生错误会抛出
     * @异常 OAuth2AccessTokenErrorResponseException 从响应体中获取错误响应的字段信息，封装并抛出 
     * @异常 IllegalArgumentException 响应体为空时抛出
     */
    public func refreshAccessToken(refreshToken: String, scope: String): OAuth2AccessToken
    
    /**
     * 异步获取刷新令牌。
     * 
     * @参数 refreshToken - String 数据类型, 刷新令牌。
     * @参数 callback - Option<OAuthAsyncRequestCallback> 数据类型, OAuth 异步请求回调。
     * @返回值 Future<OAuth2AccessToken> - 执行异步获取刷新令牌后的返回值。
     * @异常 OAuth4cjException 从响应中解析OAuth2AccessToken失败时抛出
     */
    public func refreshAccessToken(refreshToken: String, callback: Option<OAuthAsyncRequestCallback>): Future<OAuth2AccessToken>
    
    /**
     * 异步获取刷新令牌。
     * 
     * @参数 refreshToken - String 数据类型, 刷新令牌。
     * @参数 scope - String 数据类型, 作用域。
     * @参数 callback - Option<OAuthAsyncRequestCallback> 数据类型, OAuth 异步请求回调。
     * @返回值 Future<OAuth2AccessToken> - 执行异步获取刷新令牌后的返回值。
     * @异常 OAuth4cjException 从响应中解析OAuth2AccessToken失败时抛出
     */
    public func refreshAccessToken(refreshToken: String, scope: String, callback: Option<OAuthAsyncRequestCallback>): Future<OAuth2AccessToken>
    
    /**
     * 通过密码授权模式获取 OAuth2 访问令牌。
     * 
     * @参数 username - String 数据类型, 用户名。
     * @参数 password - String 数据类型, 密码。
     * @返回值 OAuth2AccessToken - OAuth2 访问令牌。
     * @异常 IOException 在获取字符串形式的响应正文时发生错误会抛出
     * @异常 OAuth2AccessTokenErrorResponseException 从响应体中获取错误响应的字段信息，封装并抛出 
     * @异常 IllegalArgumentException 响应体为空时抛出
     */
    public func getAccessTokenPasswordGrant(username: String, password: String): OAuth2AccessToken
    
    /**
     * 通过密码授权模式获取 OAuth2 访问令牌。
     * 
     * @参数 username - String 数据类型, 用户名。
     * @参数 password - String 数据类型, 密码。
     * @参数 scope - String 数据类型, 作用域。
     * @返回值 OAuth2AccessToken - OAuth2 访问令牌。
     * @异常 IOException 在获取字符串形式的响应正文时发生错误会抛出
     * @异常 OAuth2AccessTokenErrorResponseException 从响应体中获取错误响应的字段信息，封装并抛出 
     * @异常 IllegalArgumentException 响应体为空时抛出
     */
    public func getAccessTokenPasswordGrant(username: String, password: String, scope: String): OAuth2AccessToken
    
    /**
     * 异步调用密码授权模式获取 OAuth2 访问令牌。
     * 
     * @参数 username - String 数据类型, 用户名。
     * @参数 password - String 数据类型, 密码。
     * @返回值 Future<OAuth2AccessToken> - 执行异步调用密码授权模式获取 OAuth2 访问令牌后的返回值。
     * @异常 OAuth4cjException 从响应中解析OAuth2AccessToken失败时抛出
     */
    public func getAccessTokenPasswordGrantAsync(username: String, password: String): Future<OAuth2AccessToken>
    
    /**
     * 异步调用密码授权模式获取 OAuth2 访问令牌。
     * 
     * @参数 username - String 数据类型, 用户名。
     * @参数 password - String 数据类型, 密码。
     * @参数 scope - String 数据类型, 作用域。
     * @返回值 Future<OAuth2AccessToken> - 执行异步调用密码授权模式获取 OAuth2 访问令牌后的返回值。
     * @异常 OAuth4cjException 从响应中解析OAuth2AccessToken失败时抛出
     */
    public func getAccessTokenPasswordGrantAsync(username: String, password: String, scope: String): Future<OAuth2AccessToken>
    
    /**
     * 异步调用密码授权模式获取 OAuth2 访问令牌。
     * 
     * @参数 username - String 数据类型, 用户名。
     * @参数 password - String 数据类型, 密码。
     * @参数 callback - Option<OAuthAsyncRequestCallback> 数据类型, OAuth 异步请求回调。
     * @返回值 Future<OAuth2AccessToken> - 执行异步调用密码授权模式获取 OAuth2 访问令牌后的返回值。
     * @异常 OAuth4cjException 从响应中解析OAuth2AccessToken失败时抛出
     */
    public func getAccessTokenPasswordGrantAsync(username: String, password: String, 
        callback: Option<OAuthAsyncRequestCallback>): Future<OAuth2AccessToken>
    
    /**
     * 异步调用密码授权模式获取 OAuth2 访问令牌。
     * 
     * @参数 username - String 数据类型, 用户名。
     * @参数 password - String 数据类型, 密码。
     * @参数 scope - String 数据类型, 作用域。
     * @参数 callback - Option<OAuthAsyncRequestCallback> 数据类型, OAuth 异步请求回调。
     * @返回值 Future<OAuth2AccessToken> - 执行异步调用密码授权模式获取 OAuth2 访问令牌后的返回值。
     * @异常 OAuth4cjException 从响应中解析OAuth2AccessToken失败时抛出
     */
    public func getAccessTokenPasswordGrantAsync(username: String, password: String, scope: String, 
        callback: Option<OAuthAsyncRequestCallback>): Future<OAuth2AccessToken>
    
    /**
     * 异步调用客户端模式获取 OAuth2 访问令牌。
     * 
     * @返回值 Future<OAuth2AccessToken> - 返回异步调用的结果。
     * @异常 OAuth4cjException 从响应中解析OAuth2AccessToken失败时抛出
     */
    public func getAccessTokenClientCredentialsGrantAsync(): Future<OAuth2AccessToken>
    
    /**
     * 异步调用客户端模式获取 OAuth2 访问令牌。
     * 
     * @参数 scope - String 数据类型, 作用域。
     * @返回值 Future<OAuth2AccessToken> - 返回异步调用的结果。
     * @异常 OAuth4cjException 从响应中解析OAuth2AccessToken失败时抛出
     */
    public func getAccessTokenClientCredentialsGrantAsync(scope: String): Future<OAuth2AccessToken>
    
    /**
     * 调用客户端模式获取 OAuth2 访问令牌。
     * 
     * @返回值 OAuth2AccessToken - OAuth2 访问令牌。
     * @异常 IOException 在获取字符串形式的响应正文时发生错误会抛出
     * @异常 OAuth2AccessTokenErrorResponseException 从响应体中获取错误响应的字段信息，封装并抛出 
     * @异常 IllegalArgumentException 响应体为空时抛出
     */
    public func getAccessTokenClientCredentialsGrant(): OAuth2AccessToken
    
    /**
     * 调用客户端模式获取 OAuth2 访问令牌。
     * 
     * @参数 scope - String 数据类型, 作用域。
     * @返回值 OAuth2AccessToken - OAuth2 访问令牌。
     * @异常 IOException 在获取字符串形式的响应正文时发生错误会抛出
     * @异常 OAuth2AccessTokenErrorResponseException 从响应体中获取错误响应的字段信息，封装并抛出 
     * @异常 IllegalArgumentException 响应体为空时抛出
     */
    public func getAccessTokenClientCredentialsGrant(scope: String): OAuth2AccessToken
    
    /**
     * 异步调用客户端模式获取 OAuth2 访问令牌。
     * 可选提供的回调将在令牌可用时使用令牌进行调用。
     * 
     * @参数 callback - Option<OAuthAsyncRequestCallback> 数据类型, OAuth 异步请求回调。
     * @返回值 Future<OAuth2AccessToken> - 返回异步调用的结果。
     * @异常 OAuth4cjException 从响应中解析OAuth2AccessToken失败时抛出
     */
    public func getAccessTokenClientCredentialsGrant(callback: Option<OAuthAsyncRequestCallback>): Future<OAuth2AccessToken>
    
    /**
     * 异步调用客户端模式获取 OAuth2 访问令牌。
     * 可选提供的回调将在令牌可用时使用令牌进行调用。
     * 
     * @参数 scope - String 数据类型, 作用域。
     * @参数 callback - Option<OAuthAsyncRequestCallback> 数据类型, OAuth 异步请求回调。
     * @返回值 Future<OAuth2AccessToken> - 返回异步调用的结果。
     * @异常 OAuth4cjException 从响应中解析OAuth2AccessToken失败时抛出
     */
    public func getAccessTokenClientCredentialsGrant(scope: String, callback: Option<OAuthAsyncRequestCallback>): Future<OAuth2AccessToken>
    
    /**
     * 异步执行撤消令牌。
     * 
     * @参数 tokenToRevoke - String 数据类型, 撤消令牌。
     * @返回值 Future<Unit> - 返回异步调用的结果。
     * @异常 OAuth4cjException 撤销失败或出现异常时抛出
     */
    public func revokeTokenAsync(tokenToRevoke: String): Future<Unit>
    
    /**
     * 异步执行撤消令牌。
     * 
     * @参数 tokenToRevoke - String 数据类型, 撤消令牌。
     * @参数 tokenTypeHint - Option<TokenTypeHint> 数据类型, 要撤销的令牌类型。
     * @返回值 Future<Unit> - 返回异步调用的结果。
     * @异常 OAuth4cjException 撤销失败或出现异常时抛出
     */
    public func revokeTokenAsync(tokenToRevoke: String, tokenTypeHint: Option<TokenTypeHint>): Future<Unit>
    
    /**
     * 撤消令牌。
     * 
     * @参数 tokenToRevoke - String 数据类型, 撤消令牌。
     * @异常 OAuth2AccessTokenErrorResponseException 从响应体中获取错误响应的字段信息，封装并抛出
     */
    public func revokeToken(tokenToRevoke: String): Unit
    
    /**
     * 撤消令牌。
     * 
     * @参数 tokenToRevoke - String 数据类型, 撤消令牌。
     * @参数 tokenTypeHint - Option<TokenTypeHint> 数据类型, 要撤销的令牌类型。
     * @异常 OAuth2AccessTokenErrorResponseException 从响应体中获取错误响应的字段信息，封装并抛出
     */
    public func revokeToken(tokenToRevoke: String, tokenTypeHint: Option<TokenTypeHint>): Unit
    
    /**
     * 异步执行撤消令牌。
     * 
     * @参数 tokenToRevoke - String 数据类型, 撤消令牌。
     * @参数 callback - Option<OAuthAsyncRequestCallback> 数据类型, OAuth 异步请求回调。
     * @返回值 Future<Unit> - 返回异步调用的结果。
     * @异常 OAuth4cjException 撤销失败或出现异常时抛出
     */
    public func revokeToken(tokenToRevoke: String, callback: Option<OAuthAsyncRequestCallback>): Future<Unit>
    
    /**
     * 异步执行撤消令牌。
     * 
     * @参数 tokenToRevoke - String 数据类型, 撤消令牌。
     * @参数 callback - Option<OAuthAsyncRequestCallback> 数据类型, OAuth 异步请求回调。
     * @参数 tokenTypeHint - Option<TokenTypeHint> 数据类型, 要撤销的令牌类型。
     * @返回值 Future<Unit> - 返回异步调用的结果。
     * @异常 OAuth4cjException 撤销失败或出现异常时抛出
     */
    public func revokeToken(tokenToRevoke: String, callback: Option<OAuthAsyncRequestCallback>, tokenTypeHint: Option<TokenTypeHint>): Future<Unit>
    
    /**
     * 获取设备授权响应。
     * 
     * @返回值 DeviceAuthorization - 设备授权响应。
     * @异常 IOException 在获取字符串形式的响应正文时发生错误会抛出
     * @异常 OAuth4cjException 获取设备授权失败或出现异常时抛出
     * @异常 OAuth2AccessTokenErrorResponseException 从响应体中获取错误响应的字段信息，封装并抛出
     */
    public func getDeviceAuthorizationCodes(): DeviceAuthorization
    
    /**
     * 获取设备授权响应。
     * 
     * @参数 scope - Option<String> 数据类型, 作用域。
     * @返回值 DeviceAuthorization - 设备授权响应。
     * @异常 IOException 在获取字符串形式的响应正文时发生错误会抛出
     * @异常 OAuth4cjException 获取设备授权失败或出现异常时抛出
     * @异常 OAuth2AccessTokenErrorResponseException 从响应体中获取错误响应的字段信息，封装并抛出
     */
    public func getDeviceAuthorizationCodes(scope: Option<String>): DeviceAuthorization
    
    /**
     * 异步执行获取设备授权响应。
     * 
     * @参数 callback - Option<OAuthAsyncRequestCallback> 数据类型, OAuth 异步请求回调。
     * @返回值 Future<DeviceAuthorization> - 返回异步调用的结果。
     * @异常 OAuth4cjException 获取设备授权失败或出现异常时抛出
     */
    public func getDeviceAuthorizationCodes(callback: Option<OAuthAsyncRequestCallback>): Future<DeviceAuthorization>
    
    /**
     * 异步执行获取设备授权响应。
     * 
     * @参数 scope - Option<String> 数据类型, 作用域。
     * @参数 callback - Option<OAuthAsyncRequestCallback> 数据类型, OAuth 异步请求回调。
     * @返回值 Future<DeviceAuthorization> - 返回异步调用的结果。
     * @异常 OAuth4cjException 获取设备授权失败或出现异常时抛出
     */
    public func getDeviceAuthorizationCodes(scope: Option<String>, callback: Option<OAuthAsyncRequestCallback>): Future<DeviceAuthorization>
    
    /**
     * 异步执行获取设备授权响应。
     * 
     * @返回值 Future<DeviceAuthorization> - 返回异步调用的结果。
     * @异常 OAuth4cjException 获取设备授权失败或出现异常时抛出
     */
    public func getDeviceAuthorizationCodesAsync(): Future<DeviceAuthorization>
    
    /**
     * 异步执行获取设备授权响应。
     * 
     * @参数 scope - Option<String> 数据类型, 作用域。
     * @返回值 Future<DeviceAuthorization> - 返回异步调用的结果。
     * @异常 OAuth4cjException 获取设备授权失败或出现异常时抛出
     */
    public func getDeviceAuthorizationCodesAsync(scope: Option<String>): Future<DeviceAuthorization>
    
    /**
     * 通过设备授权获取 OAuth2 访问令牌。
     * 
     * @参数 deviceAuthorization - DeviceAuthorization 数据类型, 设备授权响应。
     * @返回值 OAuth2AccessToken - OAuth2 访问令牌。
     * @异常 IOException 在获取字符串形式的响应正文时发生错误会抛出
     * @异常 OAuth4cjException 获取OAuth2访问令牌失败或出现异常时抛出
     * @异常 OAuth2AccessTokenErrorResponseException 从响应体中获取错误响应的字段信息，封装并抛出
     */
    public func getAccessTokenDeviceAuthorizationGrant(deviceAuthorization: DeviceAuthorization): OAuth2AccessToken
    
    /**
     * 异步执行通过设备授权获取 OAuth2 访问令牌。
     * 
     * @参数 deviceAuthorization - DeviceAuthorization 数据类型, 设备授权响应。
     * @参数 callback - Option<OAuthAsyncRequestCallback> 数据类型, OAuth 异步请求回调。
     * @返回值 Future<OAuth2AccessToken> - 返回异步调用的结果。
     * @异常 OAuth4cjException 获取OAuth2访问令牌失败或出现异常时抛出
     */
    public func getAccessTokenDeviceAuthorizationGrant(deviceAuthorization: DeviceAuthorization, callback: Option<OAuthAsyncRequestCallback>): Future<OAuth2AccessToken>
    
    /**
     * 异步执行通过设备授权获取 OAuth2 访问令牌。
     * 
     * @参数 deviceAuthorization - DeviceAuthorization 数据类型, 设备授权响应。
     * @返回值 Future<OAuth2AccessToken> - 返回异步调用的结果。
     * @异常 OAuth4cjException 获取OAuth2访问令牌失败或出现异常时抛出
     */
    public func getAccessTokenDeviceAuthorizationGrantAsync(deviceAuthorization: DeviceAuthorization): Future<OAuth2AccessToken>
    
    /**
     * 定期尝试从服务器获取令牌（等待用户同意）。仅同步版本。
     * 
     * @参数 deviceAuthorization - DeviceAuthorization 数据类型, 设备授权响应。
     * @返回值 OAuth2AccessToken - OAuth2 访问令牌。
     * @异常 OAuth4cjException 获取OAuth2访问令牌失败或出现异常时抛出
     * @异常 OAuth2AccessTokenErrorResponseException 从响应体中获取错误响应的字段信息，封装并抛出
     */
    public func pollAccessTokenDeviceAuthorizationGrant(deviceAuthorization: DeviceAuthorization): OAuth2AccessToken
}
```

##### 1.7.2 示例
```cangjie
from std import collection.*
from std import time.*
from oauth4cj import oauth4cj.*

main() {
    var apiA: A = A()
    var tokenEAccess: TokenExtractor<OAuth2AccessToken> = apiA.getAccessTokenExtractor()
    let responseBody: String = ##"{"access_token":"oauth2_token"}"##
    let response: OAuth4cjResponse = OAuth4cjResponse(200, "", HashMap<String, String>(), responseBody)
    let oauth2AccessToken: OAuth2AccessToken = tokenEAccess.extract(response)
    if (oauth2AccessToken.getAccessToken()!="oauth2_token") {
        return -1
    }
    println("oauth2AccessToken = ${oauth2AccessToken.getAccessToken()}")
    return 0
}

class A <: DefaultApi20 {
    public init(){}
    public func getAccessTokenEndpoint(): String {
        return "getAccessTokenEndpoint"
    }
    protected func getAuthorizationBaseUrl(): String {
        return "getAuthorizationBaseUrl"
    }
}
```
执行结果如下：
```cangjie
oauth2AccessToken = oauth2_token
```

#### 1.8 提供同步和异步调用接口。

提供同步和异步调用接口，正则比较从字符串中获取指定信息，提供 BodyPartPayload 及多种子类型的数据结构创建，请求字段补充，数据存储，读取并封装成特定类型。

##### 1.8.1 主要接口

###### 1.8.1.1 HttpClient 接口

```cangjie
/**
 * HttpClient 接口提供异步和同步执行api
 */
public interface HttpClient <: Closeable {

    /**
     * 异步执行。
     *
     * @参数 userAgent - String 数据类型, 用户代理
     * @参数 headers - HashMap<String, String> 数据类型
     * @参数 httpVerb - Verb 数据类型, Verb 是一个枚举，包含最常见的 HTTP 请求类型。
     * @参数 completeUrl - String 数据类型, 完整的 url
     * @参数 bodyContents - Array<UInt8> 数据类型, 正文内容
     * @参数 callback - Option<OAuthAsyncRequestCallback> 数据类型, oAuth 异步请求回调
     * @参数 converter - Option<ResponseConverter> 数据类型, 响应转换器
     *
     * @返回值 Future<Any> - Future<Any> 数据类型, 异步执行的结果。
     */
    func executeAsync(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
        bodyContents: Array<UInt8>, callback: Option<OAuthAsyncRequestCallback>, 
        converter: Option<ResponseConverter>): Future<Any>

    /**
     * 异步执行。
     *
     * @参数 userAgent - String 数据类型, 用户代理
     * @参数 headers - HashMap<String, String> 数据类型
     * @参数 httpVerb - Verb 数据类型, Verb 是一个枚举，包含最常见的 HTTP 请求类型。
     * @参数 completeUrl - String 数据类型, 完整的 url
     * @参数 bodyContents - MultipartPayload 数据类型, 正文内容
     * @参数 callback - Option<OAuthAsyncRequestCallback> 数据类型, oAuth 异步请求回调
     * @参数 converter - Option<ResponseConverter> 数据类型, 响应转换器
     *
     * @返回值 Future<Any> - Future<Any> 数据类型, 异步执行的结果。
     */
    func executeAsync(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
            bodyContents: MultipartPayload, callback: Option<OAuthAsyncRequestCallback>,
            converter: Option<ResponseConverter>): Future<Any>

    /**
     * 异步执行。
     *
     * @参数 userAgent - String 数据类型, 用户代理
     * @参数 headers - HashMap<String, String> 数据类型
     * @参数 httpVerb - Verb 数据类型, Verb 是一个枚举，包含最常见的 HTTP 请求类型。
     * @参数 completeUrl - String 数据类型, 完整的 url
     * @参数 bodyContents - String 数据类型, 正文内容
     * @参数 callback - Option<OAuthAsyncRequestCallback> 数据类型, oAuth 异步请求回调
     * @参数 converter - Option<ResponseConverter> 数据类型, 响应转换器
     *
     * @返回值 Future<Any> - Future<Any> 数据类型, 异步执行的结果。
     */
    func executeAsync(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
            bodyContents: String, callback: Option<OAuthAsyncRequestCallback>, 
            converter: Option<ResponseConverter>): Future<Any>

    /**
     * 异步执行。
     *
     * @参数 userAgent - String 数据类型, 用户代理
     * @参数 headers - HashMap<String, String> 数据类型
     * @参数 httpVerb - Verb 数据类型, Verb 是一个枚举，包含最常见的 HTTP 请求类型。
     * @参数 completeUrl - String 数据类型, 完整的 url
     * @参数 bodyContents - File 数据类型, 正文内容
     * @参数 callback - Option<OAuthAsyncRequestCallback> 数据类型, oAuth 异步请求回调
     * @参数 converter - Option<ResponseConverter> 数据类型, 响应转换器
     *
     * @返回值 Future<Any> - Future<Any> 数据类型, 异步执行的结果。
     */
    func executeAsync(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
            bodyContents: File, callback: Option<OAuthAsyncRequestCallback>, 
            converter: Option<ResponseConverter>): Future<Any>

    /**
     * 调用执行。
     *
     * @参数 userAgent - String 数据类型, 用户代理
     * @参数 headers - HashMap<String, String> 数据类型
     * @参数 httpVerb - Verb 数据类型, Verb 是一个枚举，包含最常见的 HTTP 请求类型。
     * @参数 completeUrl - String 数据类型, 完整的 url
     * @参数 bodyContents - Array<UInt8> 数据类型, 正文内容
     *
     * @返回值 OAuth4cjResponse - OAuth4cjResponse 数据类型的别名, 执行后返回响应
     */
    func execute(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
            bodyContents: Array<UInt8>): OAuth4cjResponse

    /**
     * 调用执行。
     *
     * @参数 userAgent - String 数据类型, 用户代理
     * @参数 headers - HashMap<String, String> 数据类型
     * @参数 httpVerb - Verb 数据类型, Verb 是一个枚举，包含最常见的 HTTP 请求类型。
     * @参数 completeUrl - String 数据类型, 完整的 url
     * @参数 bodyContents - MultipartPayload 数据类型, 正文内容
     *
     * @返回值 OAuth4cjResponse - OAuth4cjResponse 数据类型的别名, 执行后返回响应
     */
    func execute(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
            bodyContents: MultipartPayload): OAuth4cjResponse

    /**
     * 调用执行。
     *
     * @参数 userAgent - String 数据类型, 用户代理
     * @参数 headers - HashMap<String, String> 数据类型
     * @参数 httpVerb - Verb 数据类型, Verb 是一个枚举，包含最常见的 HTTP 请求类型。
     * @参数 completeUrl - String 数据类型, 完整的 url
     * @参数 bodyContents - String 数据类型, 正文内容
     *
     * @返回值 OAuth4cjResponse - OAuth4cjResponse 数据类型的别名, 执行后返回响应
     */
    func execute(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
            bodyContents: String): OAuth4cjResponse

    /**
     * 调用执行。
     *
     * @参数 userAgent - String 数据类型, 用户代理
     * @参数 headers - HashMap<String, String> 数据类型
     * @参数 httpVerb - Verb 数据类型, Verb 是一个枚举，包含最常见的 HTTP 请求类型。
     * @参数 completeUrl - String 数据类型, 完整的 url
     * @参数 bodyContents - File 数据类型, 正文内容
     *
     * @返回值 OAuth4cjResponse - OAuth4cjResponse 数据类型的别名, 执行后返回响应
     */
    func execute(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
            bodyContents: File): OAuth4cjResponse
}
```

###### 1.8.1.2 HttpClient 配置接口 HttpClientConfig

```cangjie
/**
 * HttpClient 配置接口。
 */
public interface HttpClientConfig {

    /**
     * 返回 HttpClientConfig。
     *
     * @返回值 HttpClientConfig - HttpClientConfig 数据类型, HttpClient 配置。
     */
    func createDefaultConfig(): HttpClientConfig
}
```

###### 1.8.1.3 HttpClientProvider 接口

```cangjie
/**
 * 基于 HttpClient 配置提供 HttpClient。
 */
public interface HttpClientProvider {

    /**
     * 基于 HttpClient 配置创建 HttpClient。
     *
     * @参数 httpClientConfig - HttpClientConfig 数据类型, HttpClient 配置。
     *
     * @返回值 HttpClient 通过HttpClientConfig创建Http客户端
     */
    func createClient(httpClientConfig: HttpClientConfig): Option<HttpClient>
}
```

###### 1.8.1.4 BodyPartPayload 类

```cangjie
/**
 * BodyPartPayload 中可以存放 http 请求头内容。
 */
public open class BodyPartPayload {
    
    /**
     * 创建一个 BodyPartPayload 实例。
     */
    public init ()
    
    /**
     * 根据参数创建一个 BodyPartPayload 实例。
     * 
     * @参数 contentType - String 数据类型，请求头中的 Content-Type 字段对应的信息。
     */
    public init (contentType: String)
    
    /**
     * 根据参数创建一个 BodyPartPayload 实例。
     * 
     * @参数 headers - HashMap<String, String> 数据类型，请求头。
     */
    public init (headers: HashMap<String, String>)
    
    /**
     * 获取 BodyPartPayload 的请求头数据。
     * 
     * @返回值 HashMap<String,String> - HashMap<String, String> 数据类型，请求头数据。
     */
    public func getHeaders (): HashMap<String,String>
}
```

###### 1.8.1.5 ByteArrayBodyPartPayload 类

```cangjie
/**
 * ByteArrayBodyPartPayload 中可以存放 http 请求头和请求体内容。
 */
public open class ByteArrayBodyPartPayload<: BodyPartPayload {
    
    /**
     * 根据参数创建一个 ByteArrayBodyPartPayload 实例。
     * 
     * @参数 payload - Array<UInt8> 数据类型，请求数据。
     * @参数 off - Int64 数据类型，偏移量。
     * @参数 len - Int64 数据类型，请求数据长度。
     * @参数 headers - HashMap<String, String> 数据类型，请求头。
     */
    public init (payload: Array<UInt8>, off: Int64, len: Int64, headers: HashMap<String, String>)
    
    /**
     * 根据参数创建一个 ByteArrayBodyPartPayload 实例。
     * 
     * @参数 payload - Array<UInt8> 数据类型，请求数据。
     * @参数 headers - HashMap<String, String> 数据类型，请求头。
     */
    public init (payload: Array<UInt8>, headers: HashMap<String, String>)
    
    /**
     * 根据参数创建一个 ByteArrayBodyPartPayload 实例。
     * 
     * @参数 payload - Array<UInt8> 数据类型，请求数据。
     * @参数 contentType - String 数据类型，请求头中的 Content-Type 字段对应的信息。
     */
    public init (payload: Array<UInt8>, contentType: String)
    
    /**
     * 根据参数创建一个 ByteArrayBodyPartPayload 实例。
     * 
     * @参数 payload - Array<UInt8> 数据类型，请求数据。
     * @参数 off - Int64 数据类型，偏移量。
     * @参数 len - Int64 数据类型，请求数据长度。
     * @参数 contentType - String 数据类型，请求头中的 Content-Type 字段对应的信息。
     */
    public init (payload: Array<UInt8>, off: Int64, len: Int64, contentType: String)
    
    /**
     * 根据参数创建一个 ByteArrayBodyPartPayload 实例。
     * 
     * @参数 payload - Array<UInt8> 数据类型，请求数据。
     */
    public init (payload: Array<UInt8>)
    
    /**
     * 根据参数创建一个 ByteArrayBodyPartPayload 实例。
     * 
     * @参数 payload - Array<UInt8> 数据类型，请求数据。
     * @参数 off - Int64 数据类型，偏移量。
     * @参数 len - Int64 数据类型，请求数据长度。
     */
    public init (payload: Array<UInt8>, off: Int64, len: Int64)
    
    /**
     * 获取请求数据。
     * 
     * @返回值 Array<UInt8> - Array<UInt8> 数据类型，请求数据。
     */
    public func getPayload (): Array<UInt8>
    
    /**
     * 获取偏移量。
     * 
     * @返回值 Int64 - Int64 数据类型，偏移量。
     */
    public func getOff (): Int64
    
    /*
     * 获取请求数据长度。
     * 
     * @返回值 Int64 - Int64 数据类型，请求数据长度。
     */
    public func getLen (): Int64
}
```

###### 1.8.1.6 FileByteArrayBodyPartPayload 类

```cangjie
/**
 * FileByteArrayBodyPartPayload 中可以存放 http 请求头和请求体内容。
 * 支持的传参类型是 form-data 格式。
 */
public class FileByteArrayBodyPartPayload<: ByteArrayBodyPartPayload {
    
    /**
     * 根据参数创建一个 FileByteArrayBodyPartPayload 实例。
     * 
     * @参数 payload - Array<UInt8> 数据类型，请求数据。
     */
    public init (payload: Array<UInt8>)
    
    /**
     * 根据参数创建一个 FileByteArrayBodyPartPayload 实例。
     * 
     * @参数 payload - Array<UInt8> 数据类型，请求数据。
     * @参数 off - Int64 数据类型，偏移量。
     * @参数 len - Int64 数据类型，请求数据长度。
     */
    public init (payload: Array<UInt8>, off: Int64, len: Int64)
    
    /**
     * 根据参数创建一个 FileByteArrayBodyPartPayload 实例。
     * 
     * @参数 payload - Array<UInt8> 数据类型，请求数据。
     * @参数 name - String 数据类型，form-data 中 name 对应的信息。
     */
    public init (payload: Array<UInt8>, name: String)
    
    /**
     * 根据参数创建一个 FileByteArrayBodyPartPayload 实例。
     * 
     * @参数 payload - Array<UInt8> 数据类型，请求数据。
     * @参数 off - Int64 数据类型，偏移量。
     * @参数 len - Int64 数据类型，请求数据长度。
     * @参数 name - String 数据类型，form-data 中 name 对应的信息。
     */
    public init (payload: Array<UInt8>, off: Int64, len: Int64, name: String)
    
    /**
     * 根据参数创建一个 FileByteArrayBodyPartPayload 实例。
     * 
     * @参数 payload - Array<UInt8> 数据类型，请求数据。
     * @参数 name - String 数据类型，form-data 中 name 对应的信息。
     * @参数 filename - String 数据类型，文件名，form-data 中 filename 对应的信息。
     */
    public init (payload: Array<UInt8>, name: String, filename: String)
    
    /**
     * 根据参数创建一个 FileByteArrayBodyPartPayload 实例。
     * 
     * @参数 payload - Array<UInt8> 数据类型，请求数据。
     * @参数 off - Int64 数据类型，偏移量。
     * @参数 len - Int64 数据类型，请求数据长度。
     * @参数 name - String 数据类型，form-data 中 name 对应的信息。
     * @参数 filename - String 数据类型，文件名，form-data 中 filename 对应的信息。
     */
    public init (payload: Array<UInt8>, off: Int64, len: Int64, name: String, filename: String)
    
    /**
     * 根据参数创建一个 FileByteArrayBodyPartPayload 实例。
     * 
     * @参数 contentTyp - String 数据类型，请求头中的 Content-Type 字段对应的信息。
     * @参数 payload - Array<UInt8> 数据类型，请求数据。
     */
    public init (contentType: String, payload: Array<UInt8>)
    
    /**
     * 根据参数创建一个 FileByteArrayBodyPartPayload 实例。
     * 
     * @参数 contentTyp - String 数据类型
     * @参数 payload - Array<UInt8> 数据类型，请求数据。
     * @参数 off - Int64 数据类型，偏移量。
     * @参数 len - Int64 数据类型，请求数据长度。
     */
    public init (contentType: String, payload: Array<UInt8>, off: Int64, len: Int64)
    
    /**
     * 根据参数创建一个 FileByteArrayBodyPartPayload 实例。
     * 
     * @参数 contentTyp - String 数据类型
     * @参数 payload - Array<UInt8> 数据类型，请求数据。
     * @参数 name - String 数据类型，form-data 中 name 对应的信息。
     */
    public init (contentType: String, payload: Array<UInt8>, name: String)
    
    /**
     * 根据参数创建一个 FileByteArrayBodyPartPayload 实例。
     * 
     * @参数 contentTyp - String 数据类型
     * @参数 payload - Array<UInt8> 数据类型，请求数据。
     * @参数 off - Int64 数据类型，偏移量。
     * @参数 len - Int64 数据类型，请求数据长度。
     * @参数 name - String 数据类型，form-data 中 name 对应的信息。
     */
    public init (contentType: String, payload: Array<UInt8>, off: Int64, len: Int64, name: String)
    
    /**
     * 根据参数创建一个 FileByteArrayBodyPartPayload 实例。
     * 
     * @参数 contentTyp - String 数据类型
     * @参数 payload - Array<UInt8> 数据类型，请求数据。
     * @参数 name - String 数据类型，form-data 中 name 对应的信息。
     * @参数 filename - String 数据类型，文件名，form-data 中 filename 对应的信息。
     */
    public init (contentType: String, payload: Array<UInt8>, name: String, filename: String)
    
    /**
     * 根据参数创建一个 FileByteArrayBodyPartPayload 实例。
     * 
     * @参数 contentTyp - String 数据类型
     * @参数 payload - Array<UInt8> 数据类型，请求数据。
     * @参数 off - Int64 数据类型，偏移量。
     * @参数 len - Int64 数据类型，请求数据长度。
     * @参数 name - String 数据类型，form-data 中 name 对应的信息。
     * @参数 filename - String 数据类型，文件名，form-data 中 filename 对应的信息。
     */
    public init (contentType: String, payload: Array<UInt8>, off: Int64, len: Int64, name: String, filename: String)
}
```

###### 1.8.1.7 MultipartPayload 类

```cangjie
/**
 * MultipartPayload 中可以存放 http 请求头和请求体内容。
 * 支持指定的的传参类型，默认是 multipart 格式。
 */
public class MultipartPayload<: BodyPartPayload {
    
    /** 
     * 创建一个 MultipartPayload 实例。
     */
    public init ()
    
    /** 
     * 根据参数创建一个 MultipartPayload 实例。
     * 
     * @参数 boundary - String 数据类型，边界字符串，作为分隔符区分multipart类型请求体中的不同部份。
     * @异常 IllegalArgumentException boundry为空或不符合规范时抛出
     */
    public init (boundary: String)
    
    /** 
     * 根据参数创建一个 MultipartPayload 实例。
     * 
     * @参数 subtype - String 数据类型
     * @参数 boundary - String 数据类型，边界字符串。
     * @异常 IllegalArgumentException boundry为空或不符合规范时抛出
     */
    public init (subtype: String, boundary: String)
    
    /** 
     * 根据参数创建一个 MultipartPayload 实例。
     * 
     * @参数 headers - HashMap<String, String> 数据类型，请求头。
     */
    public init (headers: HashMap<String,String>)
    
    /** 
     * 根据参数创建一个 MultipartPayload 实例。
     * 
     * @参数 boundary - String 数据类型，边界字符串。
     * @参数 headers - HashMap<String, String> 数据类型
     * @异常 IllegalArgumentException boundry为空或不符合规范时抛出
     */
    public init (boundary: String, headers: HashMap<String,String>)
    
    /** 
     * 根据参数创建一个 MultipartPayload 实例。
     * 
     * @参数 subtype - String 数据类型，multipart 类型(默认是 form-data)。
     * @参数 boundary - String 数据类型，边界字符串。
     * @参数 headers - HashMap<String, String> 数据类型，请求头。
     * @异常 IllegalArgumentException boundry为空或不符合规范时抛出
     */
    public init (subtype: String, boundary: String, headers: HashMap<String,String>)
    
    /**
     * 将 bodyPartPayload 添加到 MultipartPayload 中。
     * 
     * @参数 bodyPartPayload - BodyPartPayload 数据类型
     */
    public func addBodyPart(bodyPartPayload: BodyPartPayload): Unit
    
    /**
     * 将 multipartPayload 添加到 MultipartPayload 中。
     * 
     * @参数 multipartPayload - MultipartPayload 数据类型
     * @异常 IllegalArgumentException 入参的boundary值和当前boundary值相同时抛出
     */
    public func addBodyPart(multipartPayload: MultipartPayload): Unit
    
    /**
     * 获取 BodyPartPayload 对象集合。
     * 
     * @返回值 ArrayList<BodyPartPayload> - ArrayList<BodyPartPayload> 数据类型，BodyPartPayload 对象集合。
     */
    public func getBodyParts (): ArrayList<BodyPartPayload>
    
    /**
     * 获取边界值。
     * 
     * @返回值 String - String 数据类型，边界值。
     */
    public func getBoundary (): String
    
    /**
     * 获取前置值。
     * 
     * @返回值 String - String 数据类型，前置值。
     */
    public func getPreamble (): String
    
    /**
     * 设置前置值
     * 
     * @参数 preamble - String 数据类型，前置值。
     */
    public func setPreamble (preamble: String): Unit
    
    /**
     * 获取尾声值。
     * 
     * @返回值 String - String 数据类型，尾声值。
     */
    public func getEpilogue (): String
    
    /**
     * 设置尾声值。
     * 
     * @参数 epilogue - String 数据类型，尾声值。
     */
    public func setEpilogue (epilogue: String): Unit
}
```

###### 1.8.1.8 MultipartUtils 类

```cangjie
/**
 * multipart 格式工具类
 */
public class MultipartUtils {
    /**
     * 检查字符串 boundary 是否具有无效语法。
     *
     * @参数 boundary - String 数据类型，要检查字符串。
     * @异常 IllegalArgumentException boundry为空或不符合规范时抛出
     */
    public static func checkBoundarySyntax(boundary: String): Unit
    
    /**
     * 使用指定的常规规则检查 contentTypeHeader。
     * 如果检测通过，则返回匹配的第一组字符串，否则返回空字符串。
     * 
     * @参数 contentTypeHeader - String 数据类型，要检测的字符串。
     * @返回值 String - String 数据类型, 如果检测通过，则返回匹配的第一组字符串，否则返回空字符串。
     */
    public static func parseBoundaryFromHeader (contentTypeHeader: String): String
    
    /**
     * 返回当前的毫秒字符串。
     * 
     * @返回值 String - String 数据类型，当前的毫秒字符串。
     */
    public static func generateDefaultBoundary (): String
    
    /**
     * 处理 multipartPayload 中的信息，将其封装到 ByteArrayStream 中，然后返回。
     * 
     * @参数 multipartPayload - MultipartPayload 数据类型，要处理的 MultipartPayload
     * @返回值 ByteArrayStream - ByteArrayStream 数据类型，处理后封装的数据流。
     * @异常 OAuth4cjException 入参的内容不符合MultipartPayload也不符合ByteArrayBodyPartPayload格式时抛出
     */
    public static func getPayload (multipartPayload: MultipartPayload): ByteArrayStream
}
```

###### 1.8.1.9 OkHttpHttpClient 类

```cangjie
/**
 * OkHttpHttpClient 类提供异步和同步执行 api
 */
public class OkHttpHttpClient <: HttpClient {
    
    /**
     * 创建一个 OkHttpHttpClient 实例。
     */
    public init()
    
    /**
     * 根据参数创建一个 OkHttpHttpClient 实例。
     * 
     * @参数 config - OkHttpHttpClientConfig 数据类型, OkHttpHttpClient 的配置类。
     */
    public init(config: OkHttpHttpClientConfig)
    
    /**
     * 根据参数创建一个 OkHttpHttpClient 实例。
     * 
     * @参数 client - httpclient4cj.HttpClient 数据类型, Call 的工厂类。
     */
    public init(client: httpclient4cj.HttpClient)
    
    /**
     * 关闭 httpclient4cj.HttpClient 中的资源。
     */
    public func close(): Unit
    
    /**
     * 判断是否执行过 close 方法。
     * 
     * @返回值 Bool - 如果已经调用过 close 方法，返回 true，否则返回 false。
     */
    public func isClosed(): Bool
    
    /**
     * 异步执行。
     *
     * @参数 userAgent - String 数据类型, 用户代理
     * @参数 headers - HashMap<String, String> 数据类型
     * @参数 httpVerb - Verb 数据类型, Verb 是一个枚举，包含最常见的 HTTP 请求类型。
     * @参数 completeUrl - String 数据类型, 完整的 url
     * @参数 bodyContents - Array<UInt8> 数据类型, 正文内容
     * @参数 callback - Option<OAuthAsyncRequestCallback> 数据类型, oAuth 异步请求回调
     * @参数 converter - Option<ResponseConverter> 数据类型, 响应转换器
     *
     * @返回值 Future<Any> - Future<Any> 数据类型, 异步执行的结果。
     */
    func executeAsync(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
        bodyContents: Array<UInt8>, callback: Option<OAuthAsyncRequestCallback>, 
        converter: Option<ResponseConverter>): Future<Any>

    /**
     * 异步执行。
     *
     * @参数 userAgent - String 数据类型, 用户代理
     * @参数 headers - HashMap<String, String> 数据类型
     * @参数 httpVerb - Verb 数据类型, Verb 是一个枚举，包含最常见的 HTTP 请求类型。
     * @参数 completeUrl - String 数据类型, 完整的 url
     * @参数 bodyContents - MultipartPayload 数据类型, 正文内容
     * @参数 callback - Option<OAuthAsyncRequestCallback> 数据类型, oAuth 异步请求回调
     * @参数 converter - Option<ResponseConverter> 数据类型, 响应转换器
     *
     * @返回值 Future<Any> - Future<Any> 数据类型, 异步执行的结果。
     * @异常 OAuth4cjException 客户端 OkHttp 暂时不支持 MultipartPayload。
     */
    func executeAsync(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
            bodyContents: MultipartPayload, callback: Option<OAuthAsyncRequestCallback>,
            converter: Option<ResponseConverter>): Future<Any>

    /**
     * 异步执行。
     *
     * @参数 userAgent - String 数据类型, 用户代理
     * @参数 headers - HashMap<String, String> 数据类型
     * @参数 httpVerb - Verb 数据类型, Verb 是一个枚举，包含最常见的 HTTP 请求类型。
     * @参数 completeUrl - String 数据类型, 完整的 url
     * @参数 bodyContents - String 数据类型, 正文内容
     * @参数 callback - Option<OAuthAsyncRequestCallback> 数据类型, oAuth 异步请求回调
     * @参数 converter - Option<ResponseConverter> 数据类型, 响应转换器
     *
     * @返回值 Future<Any> - Future<Any> 数据类型, 异步执行的结果。
     */
    func executeAsync(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
            bodyContents: String, callback: Option<OAuthAsyncRequestCallback>, 
            converter: Option<ResponseConverter>): Future<Any>

    /**
     * 异步执行。
     *
     * @参数 userAgent - String 数据类型, 用户代理
     * @参数 headers - HashMap<String, String> 数据类型
     * @参数 httpVerb - Verb 数据类型, Verb 是一个枚举，包含最常见的 HTTP 请求类型。
     * @参数 completeUrl - String 数据类型, 完整的 url
     * @参数 bodyContents - File 数据类型, 正文内容
     * @参数 callback - Option<OAuthAsyncRequestCallback> 数据类型, oAuth 异步请求回调
     * @参数 converter - Option<ResponseConverter> 数据类型, 响应转换器
     *
     * @返回值 Future<Any> - Future<Any> 数据类型, 异步执行的结果。
     */
    func executeAsync(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
            bodyContents: File, callback: Option<OAuthAsyncRequestCallback>, 
            converter: Option<ResponseConverter>): Future<Any>

    /**
     * 调用执行。
     *
     * @参数 userAgent - String 数据类型, 用户代理
     * @参数 headers - HashMap<String, String> 数据类型
     * @参数 httpVerb - Verb 数据类型, Verb 是一个枚举，包含最常见的 HTTP 请求类型。
     * @参数 completeUrl - String 数据类型, 完整的 url
     * @参数 bodyContents - Array<UInt8> 数据类型, 正文内容
     *
     * @返回值 OAuth4cjResponse - OAuth4cjResponse 数据类型的别名, 执行后返回响应
     */
    func execute(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
            bodyContents: Array<UInt8>): OAuth4cjResponse

    /**
     * 调用执行。
     *
     * @参数 userAgent - String 数据类型, 用户代理
     * @参数 headers - HashMap<String, String> 数据类型
     * @参数 httpVerb - Verb 数据类型, Verb 是一个枚举，包含最常见的 HTTP 请求类型。
     * @参数 completeUrl - String 数据类型, 完整的 url
     * @参数 bodyContents - MultipartPayload 数据类型, 正文内容
     *
     * @返回值 OAuth4cjResponse - OAuth4cjResponse 数据类型的别名, 执行后返回响应
     * @异常 OAuth4cjException 客户端 OkHttp 暂时不支持 MultipartPayload。
     */
    func execute(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
            bodyContents: MultipartPayload): OAuth4cjResponse

    /**
     * 调用执行。
     *
     * @参数 userAgent - String 数据类型, 用户代理
     * @参数 headers - HashMap<String, String> 数据类型
     * @参数 httpVerb - Verb 数据类型, Verb 是一个枚举，包含最常见的 HTTP 请求类型。
     * @参数 completeUrl - String 数据类型, 完整的 url
     * @参数 bodyContents - String 数据类型, 正文内容
     *
     * @返回值 OAuth4cjResponse - OAuth4cjResponse 数据类型的别名, 执行后返回响应
     */
    func execute(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
            bodyContents: String): OAuth4cjResponse

    /**
     * 调用执行。
     *
     * @参数 userAgent - String 数据类型, 用户代理
     * @参数 headers - HashMap<String, String> 数据类型
     * @参数 httpVerb - Verb 数据类型, Verb 是一个枚举，包含最常见的 HTTP 请求类型。
     * @参数 completeUrl - String 数据类型, 完整的 url
     * @参数 bodyContents - File 数据类型, 正文内容
     *
     * @返回值 OAuth4cjResponse - OAuth4cjResponse 数据类型的别名, 执行后返回响应
     */
    func execute(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
            bodyContents: File): OAuth4cjResponse
}
```

###### 1.8.1.10 OkHttpHttpClient 配置类 OkHttpHttpClientConfig

```cangjie
public class OkHttpHttpClientConfig <: HttpClientConfig {
    
    /**
     * 根据参数创建一个 OkHttpClientConfig 实例。
     * 
     * @参数 clientBuilder - httpclient4cj.HttpClient 的生成器。
     */
    public init(clientBuilder: HttpClientBuilder)
    
    /**
     * 获取 httpclient4cj.HttpClient 的生成器。
     * 
     * @返回值 HttpClientBuilder - httpclient4cj.HttpClient 的生成器。
     */
    public func getClientBuilder(): HttpClientBuilder
    
    /**
     * 生成默认的 OkHttpHttpClientConfig 配置实例。
     *
     * @返回值 OkHttpHttpClientConfig - OkHttpHttpClientConfig 数据类型, 生成默认的 OkHttpHttpClient 配置类。
     */
    public func createDefaultConfig(): OkHttpHttpClientConfig
    
    /**
     * 生成默认的 OkHttpHttpClientConfig 并返回。
     *
     * @返回值 OkHttpHttpClientConfig - OkHttpHttpClientConfig 数据类型, 生成默认的 OkHttpHttpClient 配置类。
     */
    public static func defaultConfig(): OkHttpHttpClientConfig
}
```

###### 1.8.1.11 OkHttpProvider 类

```cangjie
/**
 * 基于 HttpClient 配置提供 HttpClient。
 */
public class OkHttpProvider <: HttpClientProvider {
    
    /**
     * 基于 HttpClient 配置创建 HttpClient。
     *
     * @参数 httpClientConfig - HttpClientConfig 数据类型, HttpClient 配置。
     *
     * @返回值 Option<HttpClient> 通过 HttpClientConfig 创建 Http 客户端；
     *                           如果 config 不是 OkHttpHttpClientConfig 类型，返回 None。
     */
    public func createClient(config: HttpClientConfig): Option<HttpClient>
}
```

##### 1.8.2 示例

```cangjie
from std import collection.*
from oauth4cj import oauth4cj.*

main() {
    let headers: HashMap<String, String> = HashMap<String, String>()
    headers.put("X-Header", "X-Value")
    headers.put("Content-Disposition", "Content-Disposition-Value")
    let mp: MultipartPayload = MultipartPayload("mixed", "simple boundary", headers)
    var str: String = "This is the preamble.  It is to be ignored, though it\n" +
                      "is a handy place for composition agents to include an\n" +
                      "explanatory note to non-MIME conformant readers."
    mp.setPreamble(str)
    str = "This is implicitly typed plain US-ASCII text.\n" + "It does NOT end with a linebreak."
    var arr: Array<UInt8> = str.toUtf8Array()
    mp.addBodyPart(ByteArrayBodyPartPayload(arr))
    str = "This is explicitly typed plain US-ASCII text.\n" + "It DOES end with a linebreak.\n"
    arr = str.toUtf8Array()
    let maps: HashMap<String, String> = HashMap<String, String>()
    maps.put(OAuthConstants.CONTENT_TYPE, "text/plain; charset=us-ascii")
    let bP: ByteArrayBodyPartPayload = ByteArrayBodyPartPayload(arr, maps)
    mp.addBodyPart(bP)
    mp.setEpilogue("This is the epilogue.  It is also to be ignored.")
    let sb: StringBuilder = StringBuilder()
    let header: HashMap<String, String> = mp.getHeaders()
    for((k, v) in header) {
        sb.append(k).append(": ").append(v).append("\r\n")
    }
    str = sb.toString()
    var result: String = "X-Header: X-Value\r\n" +
                         "Content-Disposition: Content-Disposition-Value\r\n" +
                         "Content-Type: multipart/mixed; boundary=\"simple boundary\"\r\n"

	if (str!=result) {
        return 1
    }
    println(str.equals(result))

    str = String.fromUtf8(MultipartUtils.getPayload(mp).readToEnd())
    result = "This is the preamble.  It is to be ignored, though it\n" +
             "is a handy place for composition agents to include an\n" +
             "explanatory note to non-MIME conformant readers." +
             "\r\n--simple boundary\r\n" +
             "\r\n" +
             "This is implicitly typed plain US-ASCII text.\n" +
             "It does NOT end with a linebreak." +
             "\r\n--simple boundary\r\n" +
             "Content-Type: text/plain; charset=us-ascii\r\n" +
             "\r\n" +
             "This is explicitly typed plain US-ASCII text.\n" +
             "It DOES end with a linebreak.\n" +
             "\r\n--simple boundary--" +
             "\r\nThis is the epilogue.  It is also to be ignored."
	if (str!=result) {
        return 2
    }
    println(str.equals(result))
    return 0
}
```

执行结果如下：
```cangjie
true
true
```

#### 1.9 异常信息类。

提供 OAuth4cj 用到的异常类。

##### 1.9.1 主要接口

###### 1.9.1.1 OAuth4cjException 类

```cangjie
public open class OAuth4cjException <: Exception {
    
    /**
     * 根据参数创建一个 OAuth4cjException 实例。
     */
    public init()
    
    /**
     * 根据参数创建一个 OAuth4cjException 实例。
     * 
     * @参数 string - String 数据类型, 异常提示信息。
     */
    public init(string: String)
    
    /**
     * 覆写toString方法 
     *
     * @return String 异常信息
     */
    public open func toString(): String 
}
```

###### 1.9.1.2 OAuth4cjParametersMissingException 类

```cangjie
public open class OAuth4cjParametersMissingException <: OAuth4cjException {
    
    /**
     * 根据参数创建一个 OAuth4cjParametersMissingException 实例。
     */
    public init()
    
    /**
     * 根据参数创建一个 OAuth4cjParametersMissingException 实例。
     * 
     * @参数 string - String 数据类型, 异常提示信息。
     */
    public init(string: String)
    
    /**
     * 覆写toString方法 
     *
     * @return String 异常信息
     */
    public open func toString(): String 
}
```

###### 1.9.1.3 OAuth4cjSignatureException 类

```cangjie
public open class OAuth4cjSignatureException <: OAuth4cjException {
    
    /**
     * 根据参数创建一个 OAuth4cjSignatureException 实例。
     */
    public init()
    
    /**
     * 根据参数创建一个 OAuth4cjSignatureException 实例。
     * 
     * @参数 string - String 数据类型, 异常提示信息。
     */
    public init(string: String)
    
    /**
     * 覆写toString方法 
     *
     * @return String 异常信息
     */
    public open func toString(): String
}
```

##### 1.9.2 示例

```cangjie
from oauth4cj import oauth4cj.*

main (){

    let ose: OAuth4cjSignatureException = OAuth4cjSignatureException()
    let ose2: OAuth4cjException = OAuth4cjSignatureException("ceshi-1")
    if(!ose.message.contains("")){
        return 1
    }
    if(!ose2.message.contains("Error while signing string.ceshi-1")){
        return 2
    }
    println(ose2.message.contains("Error while signing string.ceshi-1"))
    let ope: OAuth4cjParametersMissingException = OAuth4cjParametersMissingException()
    let ope2: OAuth4cjException = OAuth4cjParametersMissingException("ceshi-2")
    if(!ope.message.contains("")){
        return 3
    }
    if(!ope2.message.contains("ceshi-2")){
        return 4
    }
    println(ope2.message.contains("ceshi-2"))
    return 0
}
```

执行结果如下：
```cangjie
true
true
true
```

#### 2.0 提供用于通过 OAuth4cj 公共客户端实现代码交换的证明密钥。

##### 2.0.1 主要接口

###### 2.0.1.1 PKCECodeChallengeMethod 枚举。

```cangjie
public enum PKCECodeChallengeMethod <: ToString {
    | S256
    | PLAIN

    /**
     * 返回已处理的字符串，S256 和 PLAIN 处理逻辑不同。
     *
     * @参数 codeVerifier 待处理字符串
     * @返回值 String 处理后的字符串。
     */
    public func transform2CodeChallenge(codeVerifier: String): String

    /**
     * 将 PKCECodeChallengeMethod 名称转换为字符串。
     *
     * @返回值 String 转换后的字符串。
     */
    public func toString(): String
}
```

###### 2.0.1.2 PKCE 类
用于保存 code_challenge、code_challenge_method 和 code_verifier。

```cangjie
public class PKCE {
    /**
     * 创建一个 PKCE 实例。
     */
    public init()

    /**
     * 获取 codeChallenge 值。
     *
     * @返回值 String codeChallenge 值
     */
    public func getCodeChallenge(): String

    /**
     * 设置 codeChallenge 值。
     *
     * @参数 codeVerifier 设置 codeChallenge 值
     */
    public func setCodeChallenge(codeChallenge: String): Unit

    /**
     * 获取 codeChallengeMethod 值。
     *
     * @返回值 PKCECodeChallengeMethod codeChallengeMethod 值
     */
    public func getCodeChallengeMethod(): PKCECodeChallengeMethod

    /**
     * 设置 codeChallengeMethod 值。
     *
     * @参数 codeChallengeMethod 设置 codeChallengeMethod 值
     */
    public func setCodeChallengeMethod(codeChallengeMethod: PKCECodeChallengeMethod): Unit

    /**
     * 获取 codeVerifier 值。
     *
     * @返回值 String codeVerifier 值
     */
    public func getCodeVerifier(): String

    /**
     * 设置 codeVerifier 值。
     *
     * @参数 codeVerifier 设置 codeVerifier 值
     */
    public func setCodeVerifier(codeVerifier: String): Unit

    /**
     * 创建一个 HashMap<String, String> 实例，将 code_challenge 和 code_challenge_method 键值对放入其中。
     *
     * @返回值 HashMap<String, String> 包含 code_challenge 和 code_challenge_method 键值对
     */
    public func getAuthorizationUrlParams(): HashMap<String, String>
}
```

###### 2.0.1.3 PKCEService 类
PKCEService，用于实现 OAuth4cj 公共客户端进行代码交换的证明密钥。

```cangjie
public class PKCEService {

    /**
     * 根据参数创建一个 PKCEService 实例。
     *
     * @参数 numberOFOctets Int32类型数据 
     * @异常 OAuth4cjException 入参为负数时抛出
     */
    public init(numberOFOctets: Int32)

    /**
     * 创建PKCEService实例。将创建具有推荐参数（32个八位字节）的随机生成器。
     */
    public init()

    /**
     * 生成一个新的 PKCEService 实例。
     *
     * @返回值 PKCEService 生成的 PKCEService 实例。
     */
    public static func defaultInstance(): PKCEService

    /**
     * 生成一个新的 PKCE 实例。
     *
     * @返回值 PKCE 生成的 PKCE 实例。
     */
    public func generatePKCE(): PKCE

    /**
     * 根据参数生成一个新的 PKCE 实例。
     * @参数 randomBytes 用于生成PKCE实例的随机数组，经处理后赋值给 code_challenge, code_challenge_method 和 code_verifier。
     * @返回值 PKCE 生成的 PKCE 实例。
     */
    public func generatePKCE(randomBytes: Array<UInt8>): PKCE
}
```

##### 2.0.2 示例

```cangjie
from oauth4cj import oauth4cj.*

let RANDOM_BYTES: Array<UInt8> = Array<UInt8>([116, 24, 223, 180, 151, 153,
            224, 37, 79, 250, 96, 125, 216, 173, 187, 186, 22, 212, 37, 77,
            105, 214, 191, 240, 91, 88, 5, 88, 83, 132, 141, 121])
main (){
    let pkce: PKCE = PKCEService.defaultInstance().generatePKCE(RANDOM_BYTES)
    let str0: String = pkce.getCodeChallengeMethod().toString()
    let str1: String = pkce.getCodeVerifier()
    let str2: String = pkce.getCodeChallenge()
    if(str0=="S256" && str1=="dBjftJeZ4CVP-mB92K27uhbUJU1p1r_wW1gFWFOEjXk" && str2=="E9Melhoa2OwvFrEMTJguCHaoeK1t8URWbuGJSstw-cM"){
        println(str0)
        println(str1)
        println(str2)
        return 0
    }
    return 1
}
```

执行结果如下：

```shell
S256
dBjftJeZ4CVP-mB92K27uhbUJU1p1r_wW1gFWFOEjXk
E9Melhoa2OwvFrEMTJguCHaoeK1t8URWbuGJSstw-cM
```
