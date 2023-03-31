
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
public open class Base64Utils {
    
    /**
     * 使用 Base64 编码方案将指定的字节数组编码为字符串。
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
