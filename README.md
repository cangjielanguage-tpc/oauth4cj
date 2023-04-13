<div align="center">
<h1>oauth4cj</h1>
</div>

<p align="center">
<img alt="" src="https://img.shields.io/badge/release-v0.0.1-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/build-pass-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjc-v0.38.2-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjcov-92.2%25-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/project-open-brightgreen" style="display: inline-block;" />
</p>

## 介绍

OAuth4cj 支持协议 OAuth1.0a 和 OAuth2.0，允许第三方程序通过访问令牌访问受保护的资源，而无需暴露用户的凭据。支持授权码模式，简化模式，密码模式，客户端模式四种模式。

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
|   ├── exceptions
|   ├── httpclient
|   ├── model
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

## 开源协议
The MIT License

## 参与贡献

欢迎给我们提交PR，欢迎给我们提交Issue，欢迎参与任何形式的贡献。