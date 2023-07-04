<div align="center">
<h1>oauth4cj</h1>
</div>

<p align="center">
<img alt="" src="https://img.shields.io/badge/release-v0.0.1-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/build-pass-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjc-v0.38.2-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjcov-91.2%25-brightgreen" style="display: inline-block;" />
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

### 支持以下协议和附加功能
- RFC 5849 OAuth 1.0协议，[示例](./test/LLT/RFC/RFC5849/test_oauth10a_service_01.cj) 
- RFC 6749 OAuth 2.0授权框架，授权代码授权授予，[示例](./test/LLT/RFC/RFC6749/github_example_authorization.cj)     
- RFC 6749 OAuth 2.0授权框架，资源所有者密码凭据授权授予，[示例](./test/LLT/RFC/RFC6749/gitee_example_password.cj)     
- RFC 6749 OAuth 2.0授权框架，客户端凭据授权授予，[示例](./test/LLT/RFC/RFC6749/huawei_example_client.cj)     
- RFC 6749 OAuth 2.0授权框架，刷新访问令牌，[示例](./test/LLT/RFC/RFC6749/gitee_example_refresh_access_token.cj)     
- RFC 6750 OAuth 2.0授权框架：承载令牌使用，[示例](./test/LLT/RFC/RFC6750/gitee_example_bearer_token_usage.cj)     
- RFC 7009 OAuth 2.0令牌吊销，[示例](./test/LLT/RFC/RFC7009/weibo_example_revocation.cj)     
- RFC 7636 OAuth公共客户端（PKCE）代码交换的证明密钥，[示例](./test/LLT/RFC/RFC7636/huawei_example_pkce.cj)     
- RFC 8628 OAuth 2.0设备授权授予，[示例](./test/LLT/RFC/RFC8628/huawei_example_device.cj)     

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
├── doc  
├── src
│   ├── builder                     --- Builder 模式的实现，使用一个流畅的接口创建 OAuthService
│   ├── exceptions                  --- OAuth4cj 默认异常，参数缺失异常，签名异常
│   ├── extractors                  --- 从字符串中提取具体令牌
│   ├── httpclient                  --- 提供异步和同步执行 api
│   ├── model                       --- 提供 OAuth 的请求/响应/令牌对象
│   ├── oauth                       --- Builder 模式的实现，提供 OAuth 协议的默认实现及 OAuthService 的接口及实现
│   ├── oauth2                      --- 客户端身份验证，请求签名
│   ├── pkce                        --- 用于通过 OAuth 公共客户端实现代码交换的证明密钥
│   ├── revoke                      --- 撤销请求枚举类型, OAuth2 撤销令牌响应转换器
│   ├── services                    --- 提供对基字符串使用算法进行签名，返回OAuth签名;提供Unix时间戳生成器
│   ├── util                        --- OAuth2.0 作用域生成器,访问令牌请求参数
│   └── utils                       --- 提供 URL 编解码功能和处理 Streams 的工具类
└── test
│   ├── HLT                         --- 测试用例
│   └── LLT                         --- 自测用例
├── CHANGELOG.md  
├── gitee_gate.cfg  
├── LICENSE.txt  
├── module.json  
├── README.md  
├── README.OpenSource  
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

#### 准备授权服务器环境

##### 授权服务器-gitee

```shell
https://gitee.com/api/v5/oauth_doc#/list-item-3
注册gitee账号，打开链接，按照《OAuth说明文档》中【创建应用流程】步骤操作，创建应用，生成 client_id 和 client_secret。
```

##### 授权服务器-华为

```shell
https://developer.huawei.com/consumer/cn/doc/development/HMSCore-Guides/open-platform-oauth-0000001053629189
打开链接，按照《基于OAuth 2.0开放鉴权》中步骤操作，注册为开发者，创建应用，创建凭证，申请授权，生成 client_id 和 client_secret。
```

##### 授权服务器-腾讯

```shell
https://wikinew.open.qq.com/index.html#/iwiki/876832074
打开链接，按照《OAuth2.0开发文档》中步骤操作，注册为开发者，申请 client_id 和 client_secret，添加应用。
```

##### 授权服务器-GitHub

```shell
https://docs.github.com/zh/apps/oauth-apps/building-oauth-apps/creating-an-oauth-app
注册GitHub账号，打开链接，按照《创建 OAuth 应用》中步骤操作，创建应用，生成 client_id 和 client_secret。
```

##### 授权服务器-微博

```shell
https://open.weibo.com/wiki/%E6%96%B0%E6%89%8B%E6%8C%87%E5%8D%97
打开链接，参考文档中操作流程，注册为开发者，创建应用，生成 App Key(client_id) 和 App Secret(client_secret)。
```

#### 授权码模式授权

功能示例描述:
通过客户端的后台服务器，与服务提供商的认证服务进行互动;通过授权服务器作为中介来获取，授权认证的过程也是资源所有者直接通过授权服务器进行身份认证。

示例代码如下（gitee为例）：

```cangjie
from std import random.*
from std import collection.*

from oauth4cj import utils.*
from oauth4cj import oauth.*
from oauth4cj import model.*
from oauth4cj import httpclient.*
from oauth4cj import builder.*
from oauth4cj import extractors.*
from oauth4cj import exceptions.*
from oauth4cj import oauth2.clientauthentication.*
from oauth4cj import oauth2.bearersignature.*

main() {
    //将这些替换为在【授权服务器-gitee】中生成的 client_id 和 client_secret
    let clientId: String = "your client id"
    let clientSecret: String = "your client secret"

    //替换成自己需要的权限范围
    //此授权范围是在【授权服务器-gitee】成功创建的应用中对应的权限描述，多个权限用空格隔开
    let SCOP: String = "user_info emails"

    let NETWORK_NAME: String = "Gitee"
    
    //替换成自己需要请求的，受保护的资源的链接
    //授权成功拿到访问令牌后，准备请求的受保护的资源的链接
    let PROTECTED_RESOURCE_URL: String = "https://gitee.com/api/v5/emails"

    let m: Random = Random()
    m.setSeed(3)
    let c: UInt32 = m.nextUInt32()

    let secretState: String = "secret" + c.toString()
    let service: OAuth20Service = ServiceBuilderOAuth20(clientId).
            setApiSecret(clientSecret).
            setDefaultScope(SCOP).
            //设置回调url{redirect_uri}，用于后面获取授权码code
            setCallback("${redirect_uri}").
            build(GiteeApi.instance())

    //=== Gitee的OAuth工作流 ===

    //1. 获取授权 URL
    
    //1.1 对授权连接中的配置，进行设置
    let additionalParams: HashMap<String, String> = HashMap<String, String>()
    //通过设置 access_type=offline 以获取刷新令牌
    additionalParams.put("access_type", "offline")
    //强制reget刷新令牌（如果不是第一次询问用户）
    additionalParams.put("prompt", "consent")
 
    //1.2 生成可以获取授权码的链接
    //授权认证服务器通过回调地址{redirect_uri}将【用户授权码】code 传递给【应用服务器】或者直接在 Webview 中跳转到携带用户授权码的回调地址上，
    //Webview(网页) 直接获取 code 即可。（{redirect_uri}?code=abc&state=xyz)
    let authorizationUrl: String = AuthorizationUrlBuilder(service).
            setState(secretState).
            setAdditionalParams(additionalParams).
            build()
    println("授权URL: " + authorizationUrl)
    
    //1.3 替换成上一步生成的一次性授权码
    let code: String = "your code"

    //2.获取访问令牌！
    var accessToken: OAuth2AccessToken = service.getAccessToken(code)
    println("(访问令牌-原始响应如下：" + accessToken.getRawResponse() + "')")

    //3.刷新访问令牌...
    accessToken = service.refreshAccessToken(accessToken.getRefreshToken())
    println("(刷新令牌-原始响应如下：" + accessToken.getRawResponse() + "')")

    //4.请求一个受保护的资源！
    let requestUrl: String = PROTECTED_RESOURCE_URL
    let request: OAuth4cjRequest = OAuth4cjRequest(Verb.GET, requestUrl)
    
    //4.1 请求签名
    service.signRequest(accessToken, request)

    //4.2 调用同步请求执行
    let response: Response = service.execute(request)
    println(response.getCode())
    println(response.getBody())
}

/*
 * 准备 OAuth 协议 1.0a 版或者 2.0 版的默认实现：
 * 根据实际需求继承 DefaultApi10a 或者 DefaultApi20，实现抽象方法，覆盖不同的提取器或服务。
 */
public class GiteeApi <: DefaultApi20 {

    protected init() { }

    public static func instance(): GiteeApi {
        return GiteeApi()
    }

    //返回请求类型
    public func getAccessTokenVerb(): Verb {
        return Verb.POST
    }

    //返回接收访问令牌请求的 URL
    public func getAccessTokenEndpoint(): String {
        return "https://gitee.com/oauth/token"
    }

    //返回授权链接
    protected func getAuthorizationBaseUrl(): String {
        return "https://gitee.com/oauth/authorize"
    }

    //指定访问令牌提取器并返回: 用于 OAuth 2.0 的 TokenExtractor 的 JSON 实现
    public func getAccessTokenExtractor(): TokenExtractor<OAuth2AccessToken> {
        return OAuth2AccessTokenJsonExtractor.instance()
    }

    //客户端身份验证: 在请求主体中写入 "client_id" 和 "client_secret" 及其对应的键值对信息
    public func getClientAuthentication(): ClientAuthentication {
        return RequestBodyAuthenticationScheme.instance()
    }

    //承载签名URI查询参数: 请求签名时,添加查询参数 "access_token" 及其对应的键值对信息
    public func getBearerSignature(): BearerSignature {
        return BearerSignatureURIQueryParameter.instance()
    }
}
```

执行结果如下：

```shell
授权URL: https://gitee.com/oauth/authorize?access_type=offline&prompt=consent&response_type=code&client_id=${code&client_id}&redirect_uri=${redirect_uri}&scope=profile&state=secret2356345771
(访问令牌-原始响应如下：{"access_token":"...","token_type":"bearer","expires_in":86400,"refresh_token":"...","scope":"user_info emails","created_at":1686821665}')
(刷新令牌-原始响应如下：{"access_token":"...","token_type":"bearer","expires_in":86400,"refresh_token":"...","scope":"user_info emails","created_at":1686821665}')
200
[{"email":"...","state":"confirmed","scope":["...","..."]}]
```

####  密码模式授权

功能示例描述:
用户需要向客户端提供自己的用户名和密码，客户端使用这些信息向“服务提供商”索要授权。

示例代码如下（gitee为例）：

```cangjie
from std import collection.*

from oauth4cj import utils.*
from oauth4cj import oauth.*
from oauth4cj import model.*
from oauth4cj import httpclient.*
from oauth4cj import builder.*
from oauth4cj import extractors.*
from oauth4cj import exceptions.*
from oauth4cj import oauth2.clientauthentication.*
from oauth4cj import oauth2.bearersignature.*

main() {

    var test_01 = testPassword_01()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    return test_01
}

public func testPassword_01(): Int32 {
    //将"your_username"和"your_password"替换成实际的 gitee 账户名和密码
    let USER_NAME: String = "your_username"
    let PASSWORD: String = "your_password"
    
    //将这些替换为在【授权服务器-gitee】中生成的 client_id 和 client_secret
    let clientId: String = "your client id"
    let clientSecret: String = "your client secret"

    //替换成自己需要的权限范围
    //此授权范围是在【授权服务器-gitee】成功创建的应用中对应的权限描述，多个权限用空格隔开
    let SCOP: String = "user_info emails"

    let NETWORK_NAME: String = "Gitee"
    
    //替换成自己需要请求的，受保护的资源的链接
    //授权成功拿到访问令牌后，准备请求的受保护的资源的链接
    let PROTECTED_RESOURCE_URL: String = "https://gitee.com/api/v5/emails"

    let service: OAuth20Service = ServiceBuilderOAuth20(clientId).
            setApiSecret(clientSecret).
            setDefaultScope(SCOP).
            setCallback("${redirect_uri}").
            build(GiteeApi.instance())

    //=== Gitee的OAuth工作流 ===

    //1. 调用密码模式，获取访问令牌！
    let accessToken: OAuth2AccessToken = service.getAccessTokenPasswordGrant(USER_NAME, PASSWORD)
    println("(原始响应如下：" + accessToken.getRawResponse() + "')")

    //2. 请求一个受保护的资源！
    let requestUrl: String = PROTECTED_RESOURCE_URL
    let request: OAuth4cjRequest = OAuth4cjRequest(Verb.GET, requestUrl)
    
    //2.1 请求签名
    service.signRequest(accessToken, request)

    //2.2 调用同步请求执行
    let response: Response = service.execute(request)
    println(response.getCode())
    println(response.getBody())

    return 0
}

/*
 * 准备 OAuth 协议 1.0a 版或者 2.0 版的默认实现：
 * 根据实际需求继承 DefaultApi10a 或者 DefaultApi20，实现抽象方法，覆盖不同的提取器或服务。
 */
public class GiteeApi <: DefaultApi20 {

    protected init() { }

    public static func instance(): GiteeApi {
        return GiteeApi()
    }

    //返回请求类型
    public func getAccessTokenVerb(): Verb {
        return Verb.POST
    }

    //返回接收访问令牌请求的 URL
    public func getAccessTokenEndpoint(): String {
        return "https://gitee.com/oauth/token"
    }

    //返回授权链接
    protected func getAuthorizationBaseUrl(): String {
        return "https://gitee.com/oauth/authorize"
    }

    //指定访问令牌提取器并返回: 用于 OAuth 2.0 的 TokenExtractor 的 JSON 实现
    public func getAccessTokenExtractor(): TokenExtractor<OAuth2AccessToken> {
        return OAuth2AccessTokenJsonExtractor.instance()
    }

    //客户端身份验证: 在请求主体中写入 "client_id" 和 "client_secret" 及其对应的键值对信息
    public func getClientAuthentication(): ClientAuthentication {
        return RequestBodyAuthenticationScheme.instance()
    }

    //承载签名URI查询参数: 请求签名时,添加查询参数 "access_token" 及其对应的键值对信息
    public func getBearerSignature(): BearerSignature {
        return BearerSignatureURIQueryParameter.instance()
    }
}
```

执行结果如下：

```cangjie
(原始响应如下：{"access_token":"...","token_type":"bearer","expires_in":86400,"refresh_token":"...","scope":"user_info emails","created_at":1686821354}')
200
[{"email":"...","state":"confirmed","scope":["...","..."]}]
```

#### 客户端模式授权

功能示例描述:
客户端以自己的名义，而不是以用户的名义，向“服务提供方”进行认证.
即在这种模式下，用户并不需要对客户端授权，用户直接向客户端注册，客户端以自己的名义要求“服务提供商”提供服务。

示例代码如下（华为示例）：

```cangjie
from std import collection.*

from oauth4cj import utils.*
from oauth4cj import oauth.*
from oauth4cj import model.*
from oauth4cj import httpclient.*
from oauth4cj import builder.*
from oauth4cj import extractors.*
from oauth4cj import exceptions.*
from oauth4cj import oauth2.clientauthentication.*
from oauth4cj import oauth2.bearersignature.*

main() {
    //将这些替换为在【授权服务器-华为】中生成的 client_id 和 client_secret
    let clientId: String = "your client id"
    let clientSecret: String = "your client secret"

    //替换成自己需要的权限范围
    //此授权范围是在【授权服务器-华为】申请的授权，多个权限用空格隔开
    let SCOP: String = "openid profile email"

    //替换成自己需要请求的，受保护的资源的链接
    //授权成功拿到访问令牌后，准备请求的受保护的资源的链接
    let PROTECTED_RESOURCE_URL: String = "https://account.cloud.huawei.com/rest.php?nsp_svc=GOpen.User.getInfo"

    let service: OAuth20Service = ServiceBuilderOAuth20(clientId).
            setApiSecret(clientSecret).
            setDefaultScope(SCOP).
            //设置回调url{redirect_uri}，用于后面获取授权码code
            setCallback("${redirect_uri}").
            build(HuaweiApi.instance())

    //=== 华为的OAuth工作流 ===

    //1. 调用客户端模式，获取访问令牌！
    let accessToken: OAuth2AccessToken = service.getAccessTokenClientCredentialsGrant()
    println("(原始响应如下：" + accessToken.getRawResponse() + "')")

    //2. 请求一个受保护的资源！
    let requestUrl: String = PROTECTED_RESOURCE_URL
    let request: OAuth4cjRequest = OAuth4cjRequest(Verb.POST, requestUrl)

    //2.1 请求签名
    service.signRequest(accessToken, request)

    //2.2 调用同步请求执行
    let response: Response = service.execute(request)
    println(response.getCode())
    println(response.getBody())
}

/*
 * 准备 OAuth 协议 1.0a 版或者 2.0 版的默认实现：
 * 根据实际需求继承 DefaultApi10a 或者 DefaultApi20，实现抽象方法，覆盖不同的提取器或服务。
 */
public class HuaweiApi <: DefaultApi20 {

    protected init() { }

    public static func instance(): HuaweiApi {
        return HuaweiApi()
    }

    //返回请求类型
    public func getAccessTokenVerb(): Verb {
        return Verb.POST
    }

    //返回接收访问令牌请求的 URL
    public func getAccessTokenEndpoint(): String {
        return "https://oauth-login.cloud.huawei.com/oauth2/v3/token"
    }

    //返回授权链接
    protected func getAuthorizationBaseUrl(): String {
        return "https://oauth-login.cloud.huawei.com/oauth2/v3/authorize"
    }

    //指定访问令牌提取器并返回: 用于 OAuth 2.0 的 TokenExtractor 的 JSON 实现
    public func getAccessTokenExtractor(): TokenExtractor<OAuth2AccessToken> {
        return OAuth2AccessTokenJsonExtractor.instance()
    }

    //客户端身份验证: 在请求主体中写入 "client_id" 和 "client_secret" 及其对应的键值对信息
    public func getClientAuthentication(): ClientAuthentication {
        return RequestBodyAuthenticationScheme.instance()
    }

    //承载签名URI查询参数: 请求签名时,添加查询参数 "access_token" 及其对应的键值对信息
    public func getBearerSignature(): BearerSignature {
        return BearerSignatureURIQueryParameter.instance()
    }

    //返回指定的, RFC 8628 OAuth 2.0 设备授权授予链接
    public func getDeviceAuthorizationEndpoint(): String {
        return "https://oauth-login.cloud.huawei.com/oauth2/v3/device/code"
    }
}

//返回华为[设备授权授予]授权链接
func getDeviceBaseUrl(userCode: String): String {
    return "https://oauth-login1.cloud.huawei.com/oauth2/v3/device?user_code=${userCode}&lang=zh-cn"
}
```

执行结果如下：

```cangjie
(原始响应如下: {"access_token":"...","token_type":"Bearer","expires_in":3600}')
200
{"displayName":"18*******50","openID":"......","displayNameFlag":1}
```

#### 简化模式授权

功能示例描述:
用于在浏览器中使用脚本语言如JS实现的客户端中，特点:直接在浏览器中向认证服务器申请令牌，跳过了“授权码临时凭证”这个步骤。
其所有的步骤都在浏览器中完成，令牌对访问者是可见的，且客户端不需要认证。

示例代码如下（腾讯为例）：

```cangjie
from std import collection.*

from oauth4cj import utils.*
from oauth4cj import oauth.*
from oauth4cj import model.*
from oauth4cj import httpclient.*
from oauth4cj import builder.*
from oauth4cj import extractors.*
from oauth4cj import exceptions.*
from oauth4cj import oauth2.clientauthentication.*
from oauth4cj import oauth2.bearersignature.*

main() {
    //将这些替换为在【授权服务器-腾讯】中生成的 client_id 和 client_secret
    let clientId: String = "your client id"
    let clientSecret: String = "your client secret"

    //替换成自己需要的权限范围
    //此授权范围是在【授权服务器-腾讯】添加的应用的授权，多个权限请用逗号隔开
    let SCOP: String = "get_user_info"

    let service: OAuth20Service = ServiceBuilderOAuth20(clientId).
            setApiSecret(clientSecret).
            setDefaultScope(SCOP).
            //设置回调url{redirect_uri}，用于后面获取access_token
            setCallback("${redirect_uri}").
            build(TengxunApi.instance())

    //=== 腾讯的OAuth工作流 ===

    //调用简化模式，获取访问令牌！
    let authorizationUrl: String = AuthorizationUrlBuilder(service).
            setState(secretState).
            build()
    println("授权URL: " + authorizationUrl)
}


/*
 * 准备 OAuth 协议 1.0a 版或者 2.0 版的默认实现：
 * 根据实际需求继承 DefaultApi10a 或者 DefaultApi20，实现抽象方法，覆盖不同的提取器或服务。
 */
public class TengxunApi <: DefaultApi20 {

    protected init() { }

    public static func instance(): TengxunApi {
        return TengxunApi()
    }

    //返回请求类型
    public func getAccessTokenVerb(): Verb {
        return Verb.GET
    }

    //返回接收访问令牌请求的 URL--PC网站
    public func getAccessTokenEndpoint(): String {
        return "https://graph.qq.com/oauth2.0/token"
    }

    //返回授权链接--PC网站
    protected func getAuthorizationBaseUrl(): String {
        return "https://graph.qq.com/oauth2.0/authorize"
    }

    //指定访问令牌提取器并返回: 用于 OAuth 2.0 的 TokenExtractor 的 JSON 实现
    public func getAccessTokenExtractor(): TokenExtractor<OAuth2AccessToken> {
        return OAuth2AccessTokenJsonExtractor.instance()
    }

    //客户端身份验证: 在请求主体中写入 "client_id" 和 "client_secret" 及其对应的键值对信息
    public func getClientAuthentication(): ClientAuthentication {
        return RequestBodyAuthenticationScheme.instance()
    }

    //承载签名URI查询参数: 请求签名时,添加查询参数 "access_token" 及其对应的键值对信息
    public func getBearerSignature(): BearerSignature {
        return BearerSignatureURIQueryParameter.instance()
    }
}
```

执行结果如下：

```shell
授权URL: https://graph.qq.com/oauth2.0/authorize?response_type=code&client_id=${client_id}&redirect_uri=${redirect_uri}&scope=get_user_info&state=secret630343
```

调用该 URL 链接，PC网站展示结果如下：

```shell
${redirect_uri}?#access_token=...&expires_in=7776000&state=secret630343
```

## 开源协议
The MIT License

## 参与贡献

欢迎给我们提交PR，欢迎给我们提交Issue，欢迎参与任何形式的贡献。
