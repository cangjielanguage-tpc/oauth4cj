## 0.0.1

1. 提供 URL 编解码功能和处理Streams的工具：
- OAuthEncoder 提供字符串特定格式编解码功能（当前仅支持UTF-8）
- StreamUtils 提供以 UTF-8 编码字符串的形式返回流内容的功能和从 gzip 流返回字符串内容的功能

2. 提供 OAuth4cj 的请求/响应/令牌对象：
- 提供 OAuth4cj HttpRequest的表示形式，OAuth4cjRequest
- 提供 OAuth4cj 请求或访问令牌 Token
- 提供 OAuth4cj 的 HTTP响应表示形式，Response

3. 提供 base64 编码功能
- 支持使用 Base64 编码方案将指定的字节数组编码为字符串

4. 提供用于通过 OAuth4cj 公共客户端实现代码交换的证明密钥
- 提供用于通过 OAuth4cj 公共客户端实现代码交换的证明密钥

5. 提供对基字符串使用算法进行签名，返回 OAuth4cj 签名，提供 unix 时间戳生成器
- 对基字符串进行签名，返回 OAuth4cj 签名
- 提供 unix 时间戳生成器

6. 提供从 OAuth4cj 的请求/响应中，解析 base 字符串，生成指定签名请求，获取响应中令牌
- 从 OAuth4cjRequest 中提取 url 编码的基字符串
- 生成 OAuth4cj “Authorization” Http 标头，以作为签名包含在请求中
- 从 Http Response 的内容中提取具体类型的令牌

7. Builder模式实现，提供创建OAuthService的流畅接口、OAuth协议1.0a/2.0版的默认实现
- Builder模式实现，提供创建OAuthService的流畅接口
- 提供OAuth协议1.0a/2.0版的默认实现

8. Builder模式的实现，提供 OAuth 和 OAuthService 的接口
- 提供 oauth2 签名、客户端验证和撤销请求相关接口