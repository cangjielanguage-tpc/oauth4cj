<div align="center">
<h1>oauth4cj</h1>
</div>

<p align="center">
<img alt="" src="https://img.shields.io/badge/release-v0.0.1-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/build-pass-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjc-v0.38.2-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjcov-90.9%25-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/project-open-brightgreen" style="display: inline-block;" />
</p>

## 介绍

OAuth4cj 支持协议 OAuth1.0 和 OAuth2.0，允许第三方程序通过访问令牌访问受保护的资源，而无需暴露用户的凭据。支持授权码模式，简化模式，密码模式，客户端模式四种模式。

代码参考:
1. https://github.com/scribejava/scribejava 版本8.3.3


### 特性

- 💡 授权码模式授权

- 🚀 简化模式授权

- 💪 密码模式授权

- 🛠️ 客户端模式授权

- 🌍 提供常用网站授权api封装


## 软件架构

### 架构图
OAuth2 授权登录流程
<p align="center">
<img src="./doc/assets/authorization_process.png" width="80%" >
</p>

OAuth 定义了四种角色：

    资源拥有者 (Resource Owner)
    客户端 (Client)
    资源服务器 (Resource Server)
    授权服务器 (Authorization Server)

流程：

    1.用户点击客户端提供的授权请求
    2.客户端请求服务的授权页面呈现给用户，用户点击确认授权后服务端返回授权许可凭证给客户端
    3.客户端通过步骤二接收到的授权许可凭证及在服务端注册的应用信息请求服务端
    4.如果步骤三验证通过服务端则返回 access token 给客户端
    5.客户端通过第四步获取的 access token 请求服务端获取资源
    6.如果服务端校验 access token 成功，则返回指定资源给客户端

### 源码目录

```shell
.
├── README.md
├── doc  
├── src
|   ├── buffer
|   ├── builder
|   ├── exceptions
|   ├── extractors
|   ├── httpclient
|   ├── model
|   ├── oauth
|   ├── oauth2
|   ├── pkce
|   ├── revoke
│   └── utils  
└── test
    ├── HLT
    └── LLT
```

- `doc`  文档目录，存放API接口等文档
- `src`  源码目录
- `test` 测试用例目录

### 接口说明

主要类和函数接口说明详见 [feature_api](./doc/feature_api.md)

## 使用说明

### 编译构建

描述具体的编译过程：

```shell
git clone https://gitee.com/HW-PLLab/oauth4cj.git    ---> 拉取代码
git clone https://gitee.com/HW-PLLab/testJekins.git  ---> 拉取编译脚本
cd oauth4cj                                          ---> 进入到oauth4cj目录下
cp -r ../testJekins/src/ci_test .                    ---> 将ci_test复制到oauth4cj的根目录
python3 ci_test/main.py build                        ---> 编译
```

### 功能示例
#### 提供 base64 编码功能示例

功能示例描述:
提供 base64 编码功能

示例代码如下：

```cangjie
from oauth4cj import utils.*
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

####  提供 URL 编解码功能示例

功能示例描述:
以UTF-8编码字符串的形式返回流内容

示例代码如下：

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

#### 提供OAuth的请求/响应/令牌对象功能示例

功能示例描述:
提供 OAuth 的 HTTP响应表示形式，Response

示例代码如下：
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

#### 支持客户端模式

功能示例描述:
提供用于通过 OAuth4cj 公共客户端实现代码交换的证明密钥

示例代码如下：
```cangjie
from oauth4cj import pkce.*

let RANDOM_BYTES: Array<UInt8> = Array<UInt8>([116, 24, 223, 180, 151, 153,
            224, 37, 79, 250, 96, 125, 216, 173, 187, 186, 22, 212, 37, 77,
            105, 214, 191, 240, 91, 88, 5, 88, 83, 132, 141, 121])

main (){
    let pkce: PKCE = PKCEService.defaultInstance().generatePKCE(RANDOM_BYTES)

    let str0: String = pkce.getCodeChallengeMethod().toString()
    let str1: String = pkce.getCodeVerifier()
    let str2: String = pkce.getCodeChallenge()

    println(str0)
    println(str1)
    println(str2)
    return 0
}
```

执行结果如下：

```shell
S256
dBjftJeZ4CVP-mB92K27uhbUJU1p1r_wW1gFWFOEjXk
E9Melhoa2OwvFrEMTJguCHaoeK1t8URWbuGJSstw-cM
```

#### 提供从 OAuth4cj 的请求/响应中，解析 base 字符串，生成指定签名请求，获取响应中令牌

功能示例描述:
1. 从OAuthRequest中提取url编码的基字符串；
2. 生成OAuth“Authorization”Http标头，以作为签名包含在请求中；
3. 从Http Response的内容中提取具体类型的令牌。

示例代码如下：
```cangjie
from oauth4cj import extractors.*
from oauth4cj import model.*

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

    println("baseString.equals(expected) = ${baseString.equals(expected)}")
    if (!baseString.equals(expected)) {
        println(1)
        return 1
    }
    return 0
}

main() {
    var test_01 = testBaseStringExtractor_01()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    return test_01
}
```

执行结果如下：

```shell
baseString.equals(expected) = true
```

#### 提供对基字符串使用算法进行签名，返回 OAuth4cj 签名，提供 unix 时间戳生成器

功能示例描述:
提供对基字符串使用算法进行签名，返回OAuth签名，提供Unix时间戳生成器。

示例代码如下：
```cangjie
from oauth4cj import services.*
from oauth4cj import utils.*

public func testHMACSha1SignatureService_01(): Int32 {
    let hmac: HMACSha1SignatureService = HMACSha1SignatureService()
    let str: String = hmac.getSignatureMethod()
    let result: String = "HMAC-SHA1"
	println("str = ${str}")

    if (!str.equals(result)) {
        println(1)
        return 1
    }
    return 0
}

public func testHMACSha1SignatureService_02(): Int32 {
    let hmac: HMACSha1SignatureService = HMACSha1SignatureService()
    let apiSecret: String = "api secret"
    let tokenSecret: String = "token secret"
    let baseString: String = "base string"
    
    let signature: String = "uGymw2KHOTWI699YEaoi5xyLT50="
    
    let str: String = hmac.getSignature(baseString, apiSecret, tokenSecret)
    println("str = ${str}")
    if (!str.equals(signature)) {
        println(2)
        return 2
    }
    return 0
}

main() {
    var test_01 = testHMACSha1SignatureService_01()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    test_01 = testHMACSha1SignatureService_02()
    if (test_01 != 0){
        println(test_01)
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

#### Builder模式的实现，具有创建OAuthService的流畅接口，OAuth协议1.0a/2.0版的默认实现

功能示例描述:
1.Builder模式的实现，具有创建OAuthService的流畅接口
2.OAuth协议1.0a/2.0版的默认实现, 通过API的具体实现进行扩展，提供端点和端点http请求类型

示例代码如下：
```cangjie
from std import collection.*
from oauth4cj import builder.*

main() {
    var scopeString: ArrayList<String> = ArrayList<String>()
    scopeString.append("scope_1")
    scopeString.append("scope_2")
    scopeString.append("scope_3")
    var scopeString_add: String = "scope_4"
    var scope: String = ScopeBuilder(scopeString).withScopes(scopeString_add).build()
    var montageString: String = "scope_1 scope_2 scope_3 scope_4"
    if (montageString.equals(scope)) {
        println("scope = ${scope}")
        return 0
    } else {
        return -1
    }
}
```

执行结果如下：
```cangjie
scope = scope_1 scope_2 scope_3 scope_4
```

#### Builder模式的实现，提供 OAuth 和 OAuthService 的接口

功能示例描述:
提供HttpClient创建，添加回调url，配置api名称/密钥，HttpClient 同步/异步接口调用，获取访问/请求 Token 等

示例代码如下：
```cangjie
from std import collection.*
from std import time.*
from oauth4cj import oauth.*
from oauth4cj import model.*
from oauth4cj import extractors.*
from oauth4cj import services.*

main() {
    var apiA: A = A()
    var tokenEAccess: TokenExtractor<OAuth2AccessToken> = apiA.getAccessTokenExtractor()
    let responseBody: String = ##"{"access_token":"oauth2_token"}"##
    let response: Response = Response(200, "", HashMap<String, String>(), responseBody)
    let oauth2AccessToken: OAuth2AccessToken = tokenEAccess.extract(response)
    if (!oauth2AccessToken.getAccessToken().equals("oauth2_token")) {
        println("error! oauth2AccessToken = ${oauth2AccessToken.getAccessToken()}")
        return -1
    }
    println("oauth2AccessToken = ${oauth2AccessToken.getAccessToken()}")
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

## 开源协议
The MIT License

## 参与贡献

欢迎给我们提交PR，欢迎给我们提交Issue，欢迎参与任何形式的贡献。