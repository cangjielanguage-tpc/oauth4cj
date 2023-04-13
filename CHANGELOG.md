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