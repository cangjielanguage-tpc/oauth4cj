
## 要实现的SR
### 授权码模式：
通过客户端的后台服务器，与服务提供商的认证服务进行互动;通过授权服务器作为中介来获取，授权认证的过程也是资源所有者直接通过授权服务器进行身份认证。
### 简化模式：
用于在浏览器中使用脚本语言如JS实现的客户端中，特点:直接在浏览器中向认证服务器申请令牌，跳过了“授权码临时凭证”这个步骤。其所有的步骤都在浏览器中完成，令牌对访问者是可见的，且客户端不需要认证。
### 密码模式：
用户需要向客户端提供自己的用户名和密码，客户端使用这些信息向“服务提供商”索要授权。
### 客户端模式：
客户端以自己的名义，而不是以用户的名义，向“服务提供方”进行认证.即在这种模式下，用户并不需要对客户端授权，用户直接向客户端注册，客户端以自己的名义要求“服务提供商”提供服务。
### 提供常用网站的授权api封装：
封装常用网站百度/github的授权地址、生成AccessToken的接口地址等，需要根据实际网站的要求做修改。

#### 1 提供 base64 编码功能--base64

#### 2 extractors
从OAuthRequest中提取url编码的基字符串 --BaseStringExtractor
生成OAuth“Authorization”Http标头，以作为签名包含在请求中。  --HeaderExtractor
从Http Response的内容中提取具体类型的令牌  --TokenExtractor

#### 3 HttpClient
HttpClient 提供同步和异步调用接口。--调用 okhttp 或者 标注库 http？
正则比较，并从字符串中获取指定信息。
提供 MultipartPayload 数据类型创建，请求字段补充，数据存储，读取并封装成特定类型。

#### 4 model
提供 OAuth HttpRequest的表示形式，OAuthRequest。
提供 OAuth1 和 OAuth2 请求或访问令牌 Token；
提供 OAuth 的 HTTP响应表示形式，Response：此响应可能包含HttpUrlConnection的非空正文流。如果是这样，这个机构必须关闭，以避免资源泄漏。使用getBody（）或close（）关闭主体。

#### 5 oauth
Builder模式的实现，具有创建OAuthService的流畅接口.
提供 OAuth（1和2）OAuthService 的接口，
实现：HttpClient创建，添加回调url，配置api名称/密钥，HttpClient 同步/异步接口调用，获取访问/请求 Token 等。

#### 6 pkce
用于通过OAuth公共客户端实现代码交换的证明密钥。

#### 7 services
对基字符串使用算法进行签名，返回OAuth签名--SignatureService
Unix时间戳生成器。此类对于测试中的存根非常有用--TimestampService

#### 8 utils
OAuthEncoder 提供 URL 编解码功能；
处理Streams的工具：1. 以UTF-8编码字符串的形式返回流内容； 2. 从gzip流返回字符串内容。

#### 9 builder
1.Builder模式的实现，具有创建OAuthService的流畅接口；

2.OAuth协议1.0a/2.0版的默认实现。
该类旨在通过API的具体实现进行扩展，提供端点和端点http请求类型。
如果您的Api正确地遵循1.0a/2.0协议，您只需要扩展这个类并为端点定义getter。
如果你的Api做了一些不同~~的事情，你可以重写不同的提取器或服务，以便对流程进行微调。请阅读接口的javadocs以了解要做什么。


