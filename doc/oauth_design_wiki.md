
### 授权码模式  
+ 背景：支持授权码模式
+ 功能：通过客户端的后台服务器，与服务提供商的认证服务进行互动;通过授权服务器作为中介来获取，授权认证的过程也是资源所有者直接通过授权服务器进行身份认证。        
+ 限制：只支持UTF-8字符编码        
+ 测试样例：
```cangjie
```

#### 提供 base64 编码功能
+ 功能：支持使用 Base64 编码方案将指定的字节数组编码为字符串
+ 限制：只支持UTF-8字符编码
+ 是否可单独转测：是    
+ 测试样例：
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

#### extractors：提供从OAuth的请求/响应中，解析base字符串，生成指定签名请求，获取响应中令牌。
+ 功能：
1. 从OAuthRequest中提取url编码的基字符串；
2. 生成OAuth“Authorization”Http标头，以作为签名包含在请求中；
3. 从Http Response的内容中提取具体类型的令牌。
+ 限制：只支持UTF-8字符编码
+ 是否可单独转测：否
+ 测试样例：
```cangjie
```

#### HttpClient：提供同步和异步调用接口。
+ 功能：
1. 提供同步和异步调用接口；
2. 正则比较，并从字符串中获取指定信息；
3. 提供 MultipartPayload 数据类型创建，请求字段补充，数据存储，读取并封装成特定类型。
+ 限制：只支持UTF-8字符编码
+ 是否可单独转测：否
+ 测试样例：
```cangjie
```

#### model：提供OAuth的请求/响应/令牌对象。
+ 功能：
1. 提供 OAuth HttpRequest的表示形式，OAuthRequest；
2. 提供 OAuth 请求或访问令牌 Token；
3. 提供 OAuth 的 HTTP响应表示形式，Response。
+ 限制：只支持UTF-8字符编码
+ 是否可单独转测：否
+ 测试样例：
```cangjie
```

#### oauth：Builder模式的实现，提供 OAuth 和OAuthService 的接口。
+ 功能：
1. Builder模式的实现，提供 OAuth 和 OAuthService 的接口；
2. 实现：HttpClient创建，添加回调url，配置api名称/密钥，HttpClient 同步/异步接口调用，获取访问/请求 Token 等。
+ 限制：只支持UTF-8字符编码
+ 是否可单独转测：否
+ 测试样例：
```cangjie
```

#### services：提供对基字符串使用算法进行签名，返回OAuth签名，提供Unix时间戳生成器。
+ 功能：
1. 对基字符串进行签名，返回OAuth签名；
2. 提供Unix时间戳生成器。
+ 限制：只支持UTF-8字符编码
+ 是否可单独转测：否
+ 测试样例：
```cangjie
```

#### utils：提供 URL 编解码功能和处理Streams的工具。
+ 功能：
1. OAuthEncoder 提供 URL 编解码功能；
2. 提供处理Streams的工具：以UTF-8编码字符串的形式返回流内容；从gzip流返回字符串内容。
+ 限制：只支持UTF-8字符编码
+ 是否可单独转测：是
+ 测试样例：
1. OAuthEncoder 提供 URL 编解码功能
```cangjie
from oauth4cj import utils.*
main (){
    let plain: String = "!*'();:@&=+$,/?#[]"
    let encoded: String = "%21%2A%27%28%29%3B%3A%40%26%3D%2B%24%2C%2F%3F%23%5B%5D"

    let str2: String = OAuthEncoder.encode(plain)
    let str3: String = OAuthEncoder.decode(encoded)
    println("str2 == encoded: ${str2 == encoded}")
    println("str3 == plain: ${str3 == plain}")
    if (!str2.equals(encoded)) {
        println(1)
        return 1
    }
    if (!str3.equals(plain)) {
        println(2)
        return 2
    }
    return 0
}
```

2. 提供处理Streams的工具
```cangjie
from oauth4cj import utils.*
from compress import zlib.*
from std import io.*

main (){
    let str: String = "Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789Hello World! 0123456789"

    var arr: Array<Byte> = str.toUtf8Array()
    let bas: ByteArrayStream = ByteArrayStream(526)
    var compressOutputStream: CompressOutputStream = CompressOutputStream(bas, wrap: GzipFormat, bufLen: 10000)
    compressOutputStream.write(arr)
    compressOutputStream.flush()
    compressOutputStream.close()
    println(bas.length)
    let decoded: String = StreamUtils.getGzipStreamContents(bas)
    let res: Array<Byte> = decoded.toUtf8Array()
    println("res == arr: ${res == arr}")
    if (res != arr) {
        println(1)
        return 1
    }
    return 0
}
```

#### builder：Builder模式的实现，具有创建OAuthService的流畅接口，OAuth协议1.0a/2.0版的默认实现。
+ 功能：
1. Builder模式的实现，具有创建OAuthService的流畅接口；
2. OAuth协议1.0a/2.0版的默认实现。该类旨在通过API的具体实现进行扩展，提供端点和端点http请求类型。
+ 限制：只支持UTF-8字符编码
+ 是否可单独转测：是
+ 测试样例：
```cangjie
```

### 简化模式
+ 背景：支持简化模式
+ 功能：用于在浏览器中使用脚本语言如JS实现的客户端中，特点:直接在浏览器中向认证服务器申请令牌，跳过了“授权码临时凭证”这个步骤。其所有的步骤都在浏览器中完成，令牌对访问者是可见的，且客户端不需要认证。
+ 限制：只支持UTF-8字符编码
+ 测试样例：
```cangjie
```

### 密码模式
+ 背景：支持密码模式
+ 功能：用户需要向客户端提供自己的用户名和密码，客户端使用这些信息向“服务提供商”索要授权。
+ 限制：只支持UTF-8字符编码
+ 测试样例：
```cangjie
```

### 客户端模式
+ 背景：支持客户端模式
+ 功能：客户端以自己的名义，而不是以用户的名义，向“服务提供方”进行认证.即在这种模式下，用户并不需要对客户端授权，用户直接向客户端注册，客户端以自己的名义要求“服务提供商”提供服务。
+ 限制：只支持UTF-8字符编码
+ 测试样例：
```cangjie
```

#### pkce：用于通过OAuth公共客户端实现代码交换的证明密钥
+ 功能：用于通过OAuth公共客户端实现代码交换的证明密钥。
+ 限制：只支持UTF-8字符编码
+ 是否可单独转测：否
+ 测试样例：
```cangjie
```

### 提供常用网站的授权api封装
+ 背景：提供常用网站百度/GitHub的授权api封装模板给用户做参考
+ 功能：封装常用网站百度/GitHub的授权地址、生成AccessToken的接口地址等。需要根据实际网站的要求做修改。
+ 限制：只支持UTF-8字符编码
+ 测试样例：
```cangjie
```

#### 封装GitHub的授权api
+ 功能：封装GitHub的授权地址、生成AccessToken的接口地址。
+ 限制：只支持UTF-8字符编码
+ 是否可单独转测：是
+ 测试样例：
```cangjie
```


