### 三方库设计说明

#### 1 需求场景分析

OAuth4cj 支持协议 OAuth1.0a 和 OAuth2.0，允许第三方程序通过访问令牌访问受保护的资源，而无需暴露用户的凭据。支持授权码模式，简化模式，密码模式，客户端模式四种模式。

#### 2 三方库对外提供的特性

（1）支持授权码模式
+ 提供 base64 编码功能
+ 提供从 OAuth 的请求/响应中，解析 base 字符串，生成指定签名请求，获取响应中令牌
+ 提供同步和异步调用接口
+ 提供 OAuth 的请求/响应/令牌对象
+ 提供 Builder 模式实现的 OAuth 和 OAuthService 的接口
+ 提供对基字符串使用算法进行签名，返回 OAuth 签名，提供 Unix 时间戳生成器
+ 提供 URL 编解码功能和处理 Streams 的工具
+ 提供 Builder 模式实现的，具有创建 OAuthService 的流畅接口，OAuth协议1.0a/2.0版的默认实现

（2）支持简化模式

（3）支持密码模式

（4）支持客户端模式
+ 提供用于通过 OAuth 公共客户端实现代码交换的证明密钥

（5）提供常用网站的授权api封装
+ 提供 GitHub 的授权 api /百度的授权 api 的封装

#### 3 License分析

MIT License

|  Permissions   | Limitations  |
|  ----  | ----  |
| Commercial use | Liability |
| Modification  |  Warranty  |
| Distribution  |   |
| Private use   |   |

#### 4 依赖分析 

cangjie 标准库依赖

```cangjie
from std import sync.*
from std import regex.*
from std import time.*
from std import fs.*
from std import unicode.*
from std import io.*
from std import collection.*
from std import convert.*
from encoding import url.*
from encoding import base64.*
from compress import zlib.*  
```

#### 5 特性设计文档

##### 5.1 支持授权码模式:提供 base64 编码功能

###### 5.1.1 特性介绍

    支持使用 Base64 编码方案将指定的字节数组编码为字符串

###### 5.1.2 实现方案

💡 base64_utils.cj base64编码工具类

| 成员函数 | 入参 | 返回值 | 作用描述 |
| --- | --- |  --- | --- |
| encode | bytes: Array<UInt8> |  String   | 使用 Base64 编码方案将指定的字节数组编码为字符串 |

##### 5.2 支持授权码模式:提供 URL 编解码功能和处理 Streams 的工具

###### 5.2.1 特性介绍

    以UTF-8编码字符串的形式返回流内容，从gzip流返回字符串内容

###### 5.2.2 实现方案

💡 url_encoder.cj URL编解码类（当前只支持UTF-8）

| 成员函数 | 入参 | 返回值 | 作用描述 |
| --- | --- |  --- | --- |
| encode | s: String, enc: String |  String   | 使用特定的编码方案将字符串转换为application/x-www-form-urlencoded格式 |
| encode | s: String |  String   | 使用特定的编码方案将字符串转换为application/x-www-form-urlencoded格式,该方法使用提供的字符集来获取不安全字符的字节 |
| decode | s: String, enc: String |  String   | 使用特定的编码方案解码application/x-www-form-urlencoded字符串 |
| decode | s: String |  String   | 使用特定的字符集解码application/x-www-form-urlencoded字符串 |

💡 oauth_encoder.cj OAuth编解码工具类（当前只支持UTF-8）

| 成员函数 | 入参 | 返回值 | 作用描述 |
| --- | --- |  --- | --- |
| encode | s: String |  String   | 使用特定的编码方案将字符串转换为application/x-www-form-urlencoded格式 |
| decode | s: String |  String   | 使用特定的字符集解码application/x-www-form-urlencoded字符串 |

💡 stream_utils.cj Stream流工具类（当前只支持UTF-8）

| 成员函数 | 入参 | 返回值 | 作用描述 |
| --- | --- |  --- | --- |
| getStreamContents | ins: InputStream, isGzipStream!: Bool = false |  String   | 以UTF-8编码的字符串形式返回流内容 |
| getGzipStreamContents | ins: InputStream |  String   | 从要解压缩的InputStream流中读取并解压缩数据，并将其转换为字符串格式 |

💡 preconditions.cj 判空工具

| 成员函数 | 入参 | 返回值 | 作用描述 |
| --- | --- |  --- | --- |
| checkEmptyString | str: String, errorMsg:String |  Unit  | 检测字符串是否为空 |
| hasNext | s: String |  Bool  | 检测字符串是否为空，再判断字符串中的字符是否是Unicode空白字符 |


##### 5.3 支持授权码模式:提供OAuth的请求/响应/令牌对象

###### 5.3.1 特性介绍

    提供 OAuth HttpRequest的表示形式，OAuthRequest
    提供 OAuth 请求或访问令牌 Token
    提供 OAuth 的 HTTP响应表示形式，Response

###### 5.3.2 实现方案

💡 token.cj OAuth令牌

| 成员函数 | 入参 | 返回值 | 作用描述 |
| --- | --- |  --- | --- |
| init | --- | --- | 构造方法 |
| init | rawResponse:String | --- | 构造方法 |
| getRawResponse | --- |  String   | 获取原始响应信息 |
| getParameter | parameter:String | String | 获取指定参数对应的值 |

💡 oauth1_token.cj OAuth1令牌基类

| 成员函数 | 入参 | 返回值 | 作用描述 |
| --- | --- |  --- | --- |
| init | --- | --- | 构造方法 |
| init | token:String, tokenSecret:String, rawResponse:String | --- | 构造方法 |
| getToken | --- | String | 获取令牌标识符 |
| getTokenSecret | --- | String | 获取令牌密钥 |
| isEmpty | --- | Bool | 判断OAuth1Token是否为空 |

💡 oauth1_access_token.cj OAuth1访问令牌

| 成员函数 | 入参 | 返回值 | 作用描述 |
| --- | --- |  --- | --- |
| init | token:String, tokenSecret:String | --- | 构造方法 |
| init | token:String, tokenSecret:String, rawResponse:String | --- | 构造方法 |
| getToken | --- | String | 获取令牌标识符 |
| getTokenSecret | --- | String | 获取令牌密钥 |
| equals | object:Object | Bool | 比较方法 |

💡 oauth1_request_token.cj OAuth1请求令牌

| 成员函数 | 入参 | 返回值 | 作用描述 |
| --- | --- |  --- | --- |
| init | token:String, tokenSecret:String | --- | 构造方法 |
| init | token:String, tokenSecret:String, rawResponse:String | --- | 构造方法 |
| init | token:String, tokenSecret:String, oauthCallbackConfirmed:Bool, rawResponse:String | --- | 构造方法 |
| getToken | --- | String | 获取令牌标识符 |
| getTokenSecret | --- | String | 获取令牌密钥 |
| isOauthCallbackConfirmed | --- | Bool | 是否已确认oauth回调 |
| equals | object:Object | Bool | 比较方法 |

💡 oauth2_access_token.cj OAuth2访问令牌

| 成员函数 | 入参 | 返回值 | 作用描述 |
| --- | --- |  --- | --- |
| init | accessToken:String | --- | 构造方法 |
| init | accessToken:String, rawResponse:String | --- | 构造方法 |
| init | accessToken:String, tokenType:String, expiresIn:Int32, refreshToken:String, scope:String, rawResponse:String | --- | 构造方法 |
| getAccessToken | --- | String | 获取访问令牌 |
| getTokenType | --- | String | 获取令牌类型 |
| getExpiresIn | --- | Int32 | 获取访问令牌的有效时间 |
| getRefreshToken | --- | String | 获取刷新令牌 |
| getScope | --- | String | 获取访问范围 |
| equals | object:Object | Bool | 比较方法 |

💡 device_authorization.cj 设备授权

| 成员函数 | 入参 | 返回值 | 作用描述 |
| --- | --- |  --- | --- |
| init | deviceCode:String, userCode:String, verificationUri:String, expiresInSeconds:Int64 | --- | 构造方法 |
| setVerificationUriComplete | verificationUriComplete:String | Unit | 设置完整的验证URI |
| setIntervalSeconds | intervalSeconds:Int32 | Unit | 设置客户端在向令牌端点发出轮询请求之间应等待的最短时间  |
| getDeviceCode | --- | String | 获取设备验证码 |
| getUserCode | --- | String | 获取最终用户验证码 |
| getVerificationUri | --- | String | 获取授权服务器上的最终用户验证URI |
| getVerificationUriComplete | --- | String | 获取完整的验证URI |
| getExpiresInSeconds | --- | Int64 | 获取验证码有效时间 |
| getIntervalSeconds | --- | Int32 | 获取客户端在向令牌端点发出轮询请求之间应等待的最短时间 |
| toString | --- | String | 当前的参数值转为字符串 |

💡 oduth2_authorization.cj OAuth2授权

| 成员函数 | 入参 | 返回值 | 作用描述 |
| --- | --- |  --- | --- |
| init | --- | --- | 构造方法 |
| getCode | --- | String | 获取授权服务器生成的授权代码 |
| setCode | code:String | Uint | 设置授权服务器生成的授权代码 |
| getState | --- | String | 获取状态码 |
| setState | state:String | Uint | 设置状态码 |

💡 response.cj 响应

| 成员函数 | 入参 | 返回值 | 作用描述 |
| --- | --- |  --- | --- |
| init | code:Int32, message:String, headers:HashMap<String, String>, body:String | --- | 构造方法 |
| init | code:Int32, message:String, headers:HashMap<String, String>, stream:InputStream, closeables:ArrayList<Closeable> | --- | 构造方法 |
| isSuccessful | --- | Bool | 是否响应成功 |
| getBody | --- | String | 以字符串形式返回响应体，关闭返回该响应体的流 |
| getStream | --- | InputStream | 获取HttpUrlConnection的流，可以是inputStream或者errorInputStream |
| getCode | --- | Int32 | 获取HTTP状态码 |
| getMessage | --- | String | 获取HTTP状态消息 |
| getHeaders | --- | HashMap<String, String> | 获取HTTP响应头 |
| getHeader | name:String | String | 获取指定HTTP响应头参数值 |
| toString | --- | String | 返回字符串形式的响应信息 |
| close | --- | Unit | 关闭此流并释放与之关联的任何系统资源 |

💡 response.cj  可以关闭的数据源接口
| 成员函数 | 入参 | 返回值 | 作用描述 |
| --- | --- |  --- | --- |
| close | --- | Unit | 关闭功能接口 |

💡 oauth4cj_response_exception.cj 响应异常类

| 成员函数 | 入参 | 返回值 | 作用描述 |
| --- | --- |  --- | --- |
| init | rawResponse: Response | --- | 构造函数 |
| getResponse | --- |  Response | 获取响应对象 |
| equals | obj: OAuthResponseException | Bool | 确定两个OAuthResponseException对象是否相等 |

💡 oauth4cj_request.cj 请求

| 成员函数 | 入参 | 返回值 | 作用描述 |
| --- | --- |  --- | --- |
| init | verb: Verb, url: String | --- | 构造函数 |
| addOAuthParameter | key: String, value: String | Unit | 添加OAuth参数 |
| getOauthParameters | --- | HashMap<String, String> | 获取OAuth参数集合 |
| setRealm | realm: String | Unit | 设置范围 |
| getRealm | --- | String | 获取范围 |
| getCompleteUrl | --- | String | 返回完整的url字符串 |
| addHeader | key: String, value: String | Unit | 向请求中添加HTTP报头 |
| addBodyParameter | key: String, value: String | Unit | 添加请求体参数(POST/PUT请求) |
| addQuerystringParameter | key: String, value: String | Unit | 添加查询参数 |
| addParameter | key: String, value: String | Unit | 添加参数 |
| getMultipartPayload | --- | MultipartPayload | 获取MultipartPayload对象 |
| setMultipartPayload | multipartPayload: MultipartPayload | Unit | 设置MultipartPayload对象 |
| initMultipartPayload | --- | Unit | 初始化MultipartPayload对象 |
| initMultipartPayload | boundary: String | Unit | 初始化MultipartPayload对象 |
| initMultipartPayload | subtype: String, boundary: String | Unit | 初始化MultipartPayload对象 |
| initMultipartPayload | headers: HashMap<String, String> | Unit | 初始化MultipartPayload对象 |
| initMultipartPayload | boundary: String, headers: HashMap<String, String> | Unit | 初始化MultipartPayload对象 |
| initMultipartPayload | subtype: String, boundary: String, headers: HashMap<String, String> | Unit | 初始化MultipartPayload对象 |
| setBodyPartPayloadInMultipartPayload | bodyPartPayload: BodyPartPayload | Unit | 设置BodyPartPayload对象 |
| addBodyPartPayloadInMultipartPayload | bodyPartPayload: BodyPartPayload | Unit | 添加BodyPartPayload对象 |
| setPayload | payload: String | Unit | 设置请求数据 |
| setPayload | payload: Array<UInt8> | Unit | 设置请求数据 |
| setPayload | payload: File | Unit | 设置请求数据 |
| getQueryStringParams | --- | ParameterList | 获取带有查询字符串参数的参数列表 |
| getBodyParams | --- | ParameterList | 获取请求体参数 |
| getUrl | --- | String | 获取HTTP请求的URL |
| getSanitizedUrl | --- | String | 获取不包含端口和查询字符串部分的URL |
| getStringPayload | --- | String | 获取请求体 |
| getByteArrayPayload | --- | Array<UInt8> | 获取请求体 |
| getFilePayload | --- | Option<File> | 获取请求体 |
| toString | --- | String | 获取OAuth4cjRequest对象的字符串表示形式 |
| getVerb | --- | Verb | 获取HTTP操作类型 |
| getHeaders | --- | HashMap<String, String> | 获取请求头 |
| getCharset | --- | String | 获取字符集 |
| setCharset | charsetName: String | Unit | 设置请求体的字符集,当前仅支持UTF-8 |
| convert | response: Response | Any | 继承此方法的实现应该关闭提供的响应,防止响应不包括在Any<T>的返回对象中 |

💡 parameter.cj 参数类

| 成员函数 | 入参 | 返回值 | 作用描述 |
| --- | --- |  --- | --- |
| init | key: String, value: String | --- | 构造函数 |
| asUrlEncodedPair | --- | String | 根据OAuthEncoder对Parameter对象中的信息进行编码，并将其拼接成字符串 |
| getKey | --- | String | 获取键 |
| getValue | --- | String | 获取值 |
| hashCode | --- | Int64 | 获取哈希码 |
| == | that: Parameter | Bool | 重载运算符'=='，返回两个Parameter实例的比较结果 |
| compareTo | parameter: Parameter | Ordering | 两个Parameter比较大小 |

💡 parameter_list.cj 提供对中国及美国的电话号码进行验证功能

| 成员函数 | 入参 | 返回值 | 作用描述 |
| --- | --- |  --- | --- |
| init | --- | --- | 构造函数 |
| add | key: String, value: String | Unit | 添加键值对 |
| appendTo | url: String | String | 处理url并返回一个新字符串 |
| asOauthBaseString | --- | String | 处理ParameterList对象中的信息并根据OAuthEncoder对其进行编码 |
| asFormUrlEncodedString | --- | String | 处理ParameterList对象中的信息并将其拼接成字符串 |
| addAll | other: ParameterList | Unit | 将另一个ParameterList添加到这个ParameterList对象中 |
| addQuerystring | queryString: String | Unit | 处理queryString并添加到这个ParameterList对象中 |
| contains | param: Parameter | Bool | 确定当前ParameterList对象是否包含指定的参数对象 |
| size | --- | Int64 | 获取当前ParameterList对象的长度 |
| getParams | --- | ArrayList<Parameter> | 获取Parameter对象集合 |
| sort | --- | ParameterList | 返回排序后的新ParameterList对象 |

💡 verb.cj 提供对中国及美国的电话号码进行验证功能

| 成员函数 | 入参 | 返回值 | 作用描述 |
| --- | --- |  --- | --- |
| isRequiresBody | --- | Bool | 是否需要请求体 |
| isPermitBody | --- | Bool | 是否需要许可证 |
| toString | --- | String | 转换成字符串形式 |
