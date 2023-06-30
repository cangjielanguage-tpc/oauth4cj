// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from std import collection.*
// from std import io.*
from okhttp import okhttp.*
// from std import time.*
from net import http.*
from std import socket.*
// from encoding import url.*

from oauth4cj import utils.*
from oauth4cj import oauth.*
from oauth4cj import model.*
from oauth4cj import httpclient.*
from oauth4cj import builder.*
from oauth4cj import extractors.*
from oauth4cj import exceptions.*

// RFC5849文档中的示例

/** 
 *
 * Jane（资源所有者）最近上传了一些私人度假照片（受保护的资源）到她的照片共享网站'photos.example.net'（服务器）
 * 她想用'printer.example.com'网站（客户端）打印其中一张照片
 * Jane使用她的用户名登录和密码登录到'photos.example.net', 但不想'printer.example.com'知道它的用户名和密码
 * 而为了打印printer.example.com'网站需要访问照片, 'printer.example.com' 已经事先取得了一组'photos.example.net'的客户端资格(client credentials)
 *      客户端识别号码(Client Identifier):dpf43f3p2l4k3l03
 *      客户端共享密文(Client Shared-Secret):kd94hf93k423kf4
 * 注: 申请client credentials时会要求填写回调地址
 *
 * 'printer.example.com' 网站也设置好了它的程序以便利用列举在 'photos.example.net' 的API文档里的协议终端接口，这些终端使用"HMAC-SHA1"签名方法: 
 *      临时资格请求：https://photos.example.net/initiate 
 *      资源所有者授权 URI: https://photos.example.net/authorize
 *      Token请求URI:https://photos.example.net/token
 *
 *
 *
 *
 * 1. 在'printer.example.com'能请求Jane授权它访问照片之前，它必须同'photos.example.net'建立一组临时资格以用来识别代理请求
 *    发送请求到服务器端:
 *      POST /initiate HTTP/1.1
 *      Host: photos.example.net
 *      Authorization: OAuth realm="Photos",oauth_consumer_key="dpf43f3p2l4k3l03",oauth_signature_method="HMAC-SHA1",
 *          oauth_timestamp="137131200",oauth_nonce="wIjqoS",oauth_callback="http%3A%2F%2Fprinter.example.com%2Fready",
 *          oauth_signature="74KNZJeDHnMBp0EMJ9ZHt%2FXKycU%3D"
 *
 * 2. 服务器端验证这个请求并在HTTP应答的正文里面回复一组临时凭据:
 *      HTTP/1.1 200 OK
 *      Content-Type: application/x-www-form-urlencoded
 *      oauth_token=hh5s93j4hdidpola&oauth_token_secret=hdhd0244k9j7ao03&oauth_callback_confirmed=true 
 *
 * 3. 客户端转送Jane的user-agent到服务器的资源所有者授权端口以获得对于访问私有照片的Jane的批准: 
 *      https://photos.example.net/authorize?oauth_token=hh5s93j4hdidpola
 *
 * 4. 服务器请求Jane用她的用户名和密码登录，如果登录成功，服务器再要求她批准授权 'printer.example.com',访问她私有的照片
 *    Jane 批准这个请求然后她的user-agent就被转送到客服端在以前的请求里提供的callback URI: 
 *      http://printer.example.com/ready?oauth_token=hh5s93j4hdidpola&oauth_verifier=hfdp7dh39dks988
 *
 * 5. 这个callback请求通知客户端Jane完成了授权处理。然后客户端用它的临时资格来要求另一组token资格
 *      POST /token HTTP/1.1
 *      Host: photos.example.net
 *      Authorization: OAuth realm="Photos",oauth_consumer_key="dpf43f3p2l4k3l03",oauth_token="hh5s93j4hdidpola",oauth_signature_method="HMAC-SHA1",
 *          oauth_timestamp="137131201",oauth_nonce="walatlh",oauth_verifier="hfdp7dh39dks9884",oauth_signature="gKgrFCywp7rO0OXSjdot%2FIHF7IU%3D"
 *
 * 6. 服务器验证这个请求并在HTTP应答的正文里面回复一组token资格：
 *      HTTP/1.1 200 OK
 *      Content-Type: application/x-www-form-urlencoded
 *      oauth_token=nnch734d00sl2jdk&oauth_token_secret=pfkkdhi9sl3r4s00 
 *
 * 7. 有了这组token资格，客户端做好了访问私有照片的准备：
 *      GET /photos?file=vacation.jpg&size=original HTTP/1.1
 *      Host: photos.example.net
 *      Authorization: OAuth realm="Photos",oauth_consumer_key="dpf43f3p2l4k3l03",oauth_token="nnch734d00sl2jdk",oauth_signature_method="HMAC-SHA1",
 *          oauth_timestamp="137131202",oauth_nonce="chapoH",oauth_signature="MdpQcU8iPSUjWoN%2FUDMsK2sui9I%3D" 
 *
 * 8. 'photos.example.net'（服务器）验证这个请求并回复被请求访问的照片.在Jane的授权的存活期间, 
 *    'printer.example.com'能够用同一个token资格继续访问Jane的私有照片, 或者直到Jane让访问无效
 * 
 */

var port: UInt16 = 0

main() { 
    spawn {
        serve()
    }
    sleep(1000*1000*1000)

    // 模拟'printer.example.com'（客户端）在'photos.example.net'（服务器）中注册的凭证
    let clientId: String = "dpf43f3p2l4k3l03"
    let clientSecret: String = "kd94hf93k423kf4"

    let callbackUrl: String = "http://127.0.0.1:${port}/token"

    // 模拟photos.example.net（服务器）网站提供的oauth接入地址封装的api
    let PROTECTED_RESOURCE_URL: String = "http://127.0.0.1:${port}/ready"

    let myInterceptor = MyInterceptor()
    let client: OkHttpClient = OkHttpClient.builder().addInterceptor(myInterceptor).build()
    myInterceptor.setClient(client)
    let myClient: OkHttpHttpClient = OkHttpHttpClient(client)

    // 构建oauth请求服务, 传入'printer.example.com' 已经事先取得的'photos.example.net'的客户端资格
    // 和'photos.example.net'（服务器）网站提供的oauth接入地址封装的api（class MyApi）
    let service: OAuth10aService = ServiceBuilderOAuth10a(clientId).
            setApiSecret(clientSecret).
            setHttpClient(Some(myClient)).
            build(MyApi.instance())

    // 1. 'printer.example.com'向'photos.example.net'请求未授权的临时requestToken
    let requestToken: OAuth1RequestToken = service.getRequestToken()
    // 2. 验证服务端返回的参数
    if (!requestToken.getToken().equals("hh5s93j4hdidpola")) {
        println("1")
        return 1
    }

    // 3. 'printer.example.com'向'photos.example.net'请求资源所有者授权
    // 将PhotosApi中的资源所有者授权URI拼接上刚才请求的未授权的临时requestToken
    let authorizationUrl: String = service.getAuthorizationUrl(requestToken)
    let oauthVerifier: String = "123456"
    // 4. 验证授权后的返回值
    /**
     * 3-4是在'photos.example.net'（服务器）网址中用户去手动完成的
     *
     * 'printer.example.com'客户端跳转到该地址, 此时进入到'photos.example.net'网址中
     * 'photos.example.net'（服务器）请求Jane用她的用户名和密码登录
     * 登录成功或者已经登录, 服务器再要求她批准授权 'printer.example.com'
     * Jane 批准这个请求后, 'photos.example.net'（服务器）跳转到客服端在以前的请求里提供的callback URI
     */ 

    // 5. 'printer.example.com'向'photos.example.net'请求正式的accessToken
    let accessToken: OAuth1AccessToken = service.getAccessToken(requestToken, oauthVerifier)
    // 6. 验证服务端返回的参数
    if (!accessToken.getToken().equals("nnch734d00sl2jdk")) {
        println("2")
        return 1
    }

    // 7. 'printer.example.com'向'photos.example.net'请求照片（受保护的资源）
    let request: OAuth4cjRequest = OAuth4cjRequest(Verb.GET, PROTECTED_RESOURCE_URL)
    // 给请求添加正式的accessToken
    service.signRequest(accessToken, request)

    try {
        let response: model.Response = service.execute(request)
        // 8. 验证返回的资源是否正确
        if (response.getCode() != 200) {
            println("3")
            return 1
        }
        let bodyString = ##"{"photo1":"aaaaaa","photo2":"bbbbbbb"}"##
        if (!response.getBody().equals(bodyString)) {
            println(response.getBody())
            return 1
        }
    } catch (e: Exception) {
        println("5")
        println(e)
        return 1
    }

    return 0
}

func serve(){
    let hd = http.Route()
    // 模拟接收'printer.example.com'向'photos.example.net'请求未授权的临时requestToken
    hd.handle("/initiate", { rws: http.ResponseWriteStream, req: http.Request =>
        sleep(1000*1000*10)
        println("receive printer.example.com request: get requestToken")
        // 模拟服务器返回的json信息
        var returnJson: String = ""
        // 获取请求中的头信息
        let header = req.header
        // 请求头信息的Authorization相关信息，从第5位置开始截取
        // Authorization信息是"OAuth "开头，后面是键值对信息
        let authorizationSub = header.get("Authorization").getOrThrow().substring(6)

        // 使用“,”进行分割
        let splitArray: Array<String> = authorizationSub.split(",")

        // 循环分割之后的数组，赋值成HashMap键值对，方便之后查找
        let splitMap: HashMap<String, String> = HashMap<String, String>()
        for (item in splitArray) {
            let itemArray: Array<String> = item.split("=")
            if (itemArray.size == 2) {
                splitMap.put(itemArray[0].trim(), itemArray[1].trim())
            }
        }

        // 验证传入的 oauth_consumer_key
        var oauthConsumerKey = splitMap.get("oauth_consumer_key")
        // oauth_consumer_key值和'photos.example.net'分配给'printer.example.com'的Client Identifier一致, 返回token
        match(oauthConsumerKey) {
            case Some(key) => 
                if (key.equals("\"dpf43f3p2l4k3l03\"")) {
                    returnJson = ##"{"oauth_token":"hh5s93j4hdidpola","oauth_token_secret":"hdhd0244k9j7ao03", "oauth_callback_confirmed":"true"}"##
                } else {
                    returnJson = ##"{"error":"clientId verification failed"}"##
                }
            case None =>
                returnJson = ##"{"error":"clientId verification failed"}"##
        }

        let resp = returnJson.toUtf8Array()
        rws.write(resp)
        return
    })

    // 模拟接收'printer.example.com'向'photos.example.net'请求正式的 accessToken
    hd.handle("/token", { rws: http.ResponseWriteStream, req: http.Request =>
        sleep(1000*1000*10)
        println("receive printer.example.com request: get accessToken")
        // 模拟服务器返回的json信息
        var returnJson: String = "error"
        // 获取请求中的头信息
        let header = req.header
        // 请求头信息的Authorization相关信息，从第5位置开始截取
        // Authorization信息是"OAuth "开头，后面是键值对信息
        let authorizationSub = header.get("Authorization").getOrThrow().substring(6)

        // 使用“,”进行分割
        let splitArray: Array<String> = authorizationSub.split(",")

        // 循环分割之后的数组，赋值成HashMap键值对，方便之后查找
        let splitMap: HashMap<String, String> = HashMap<String, String>()
        for (item in splitArray) {
            let itemArray: Array<String> = item.split("=")
            if (itemArray.size == 2) {
                splitMap.put(itemArray[0].trim(), itemArray[1].trim())
            }
        }

        var oauthConsumerKeyRight = false
        var oauthTokenRight = false

        // 验证传入的 oauth_consumer_key
        var oauthConsumerKey = splitMap.get("oauth_consumer_key")
        // oauth_consumer_key值和'photos.example.net'分配给'printer.example.com'的Client Identifier一致
        match(oauthConsumerKey) {
            case Some(key) => 
                if (key.equals("\"dpf43f3p2l4k3l03\"")) {
                    oauthConsumerKeyRight = true
                } else {
                    oauthConsumerKeyRight = false
                }
            case None =>
                oauthConsumerKeyRight = false
        }
        // 验证传入的oauth_token
        var oauthToken = splitMap.get("oauth_token")
        // oauth_token值和未授权的临时requestToken一致
        match(oauthToken) {
            case Some(token) => 
                if (token.equals("\"hh5s93j4hdidpola\"")) {
                    oauthTokenRight = true
                } else {
                    oauthTokenRight = false
                }
            case None =>
                oauthTokenRight = false
        }

        // 两个都验证通过返回正式的 accessToken
        if (oauthConsumerKeyRight && oauthTokenRight) {
            returnJson = ##"{"oauth_token":"nnch734d00sl2jdk","oauth_token_secret":"pfkkdhi9sl3r4s00"}"##
        } else {
            returnJson = ##"{"error":"clientId or requestToken verification failed"}"##
        }

        let resp = returnJson.toUtf8Array()
        rws.write(resp)
        return
    })

    // 模拟接收'printer.example.com'向'photos.example.net'请求照片（受保护资源）
    hd.handle("/ready", { rws: http.ResponseWriteStream, req: http.Request =>
        sleep(1000*1000*10)
        println("receive printer.example.com request: get photo")
        // 模拟服务器返回的json信息
        var returnJson: String = "error"
        // 获取请求中的头信息
        let header = req.header
        // 请求头信息的Authorization相关信息，从第5位置开始截取
        // Authorization信息是"OAuth "开头，后面是键值对信息
        let authorizationSub = header.get("Authorization").getOrThrow().substring(6)

        // 使用“,”进行分割
        let splitArray: Array<String> = authorizationSub.split(",")

        // 循环分割之后的数组，赋值成HashMap键值对，方便之后查找
        let splitMap: HashMap<String, String> = HashMap<String, String>()
        for (item in splitArray) {
            let itemArray: Array<String> = item.split("=")
            if (itemArray.size == 2) {
                splitMap.put(itemArray[0].trim(), itemArray[1].trim())
            }
        }

        var oauthConsumerKeyRight = false
        var oauthTokenRight = false

        // 验证传入的 oauth_consumer_key
        var oauthConsumerKey = splitMap.get("oauth_consumer_key")
        // oauth_consumer_key值和'photos.example.net'分配给'printer.example.com'的Client Identifier一致
        match(oauthConsumerKey) {
            case Some(key) => 
                if (key.equals("\"dpf43f3p2l4k3l03\"")) {
                    oauthConsumerKeyRight = true
                } else {
                    oauthConsumerKeyRight = false
                }
            case None =>
                oauthConsumerKeyRight = false
        }
        // 验证传入的oauth_token
        var oauthToken = splitMap.get("oauth_token")
        // oauth_token值和正式的accessToken一致
        match(oauthToken) {
            case Some(token) => 
                if (token.equals("\"nnch734d00sl2jdk\"")) {
                    oauthTokenRight = true
                } else {
                    oauthTokenRight = false
                }
            case None =>
                oauthTokenRight = false
        }

        // 两个都验证通过返回受保护资源
        if (oauthConsumerKeyRight && oauthTokenRight) {
            returnJson = ##"{"photo1":"aaaaaa","photo2":"bbbbbbb"}"##
        } else {
            returnJson = ##"{"error":"clientId or accessToken verification failed"}"##
        }

        let resp = returnJson.toUtf8Array()
        rws.write(resp)
        return
    })

    let server = http.Server(hd)
    let socket = socket.SocketServer(SocketNet.TCP, "0.0.0.0", port)
    port = socket.port
    server.serve(socket)
}

class MyInterceptor <: Interceptor {
    var client: Option<OkHttpClient> = Option<OkHttpClient>.None
    public func setClient(client: OkHttpClient) {
        this.client = client
    }

    public func intercept(chain: Chain): okhttp.Response {
        let dispatcher = client.getOrThrow().getDispatcher()
        let run = dispatcher.runningCalls()
        // println(run.size)

        let request: okhttp.Request = chain.getRequest()
        let requestBuilder: okhttp.RequestBuilder  = request.newBuilder()
        let header: Header = request.getHeaders()
        var response: okhttp.Response =  chain.proceed(requestBuilder.build())
        let responseBuilder: okhttp.ResponseBuilder = response.newBuilder().request(request)
        println("")
        println("-----interceptor message------")
        
        return responseBuilder.build()
    }
}


public class MyApi <: DefaultApi10a {

    protected init() {}

    public static func instance(): MyApi {
        return MyApi()
    }

    public func getRequestTokenEndpoint(): String {
        // 模拟临时资格请求：https://photos.example.net/initiate
        return "http://127.0.0.1:${port}/initiate"
    }

    public func getAccessTokenEndpoint(): String {
        // 模拟Token请求URI:https://photos.example.net/token
        return "http://127.0.0.1:${port}/token"
    }

    protected func getAuthorizationBaseUrl(): String {
        // 模拟资源所有者授权 URI:https://photos.example.net/authorize
        return "http://127.0.0.1:${port}/token"
    }

    public func getRequestTokenExtractor(): TokenExtractor<OAuth1RequestToken> {
        return OAuth1RequestTokenJSONExtractor.instance()
    }

    public func getAccessTokenExtractor(): TokenExtractor<OAuth1AccessToken> {
        return OAuth1AccessTokenJSONExtractor.instance()
    }
}