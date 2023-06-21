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

// 完整流程通过的示例
var port: UInt16 = 0

main() { 
    spawn {
        serve()
    }
    sleep(1000*1000*1000)

    let appKey: String = "123456789"
    let appSecret: String = "123456789"

    let callbackUrl: String = "http://127.0.0.1:${port}/1234"
    let PROTECTED_RESOURCE_URL: String = "http://127.0.0.1:${port}/1234"

    let myInterceptor = MyInterceptor()
    let client: OkHttpClient = OkHttpClient.builder().addInterceptor(myInterceptor).build()
    myInterceptor.setClient(client)

    let myClient: OkHttpHttpClient = OkHttpHttpClient(client)
    let service: OAuth10aService = ServiceBuilderOAuth10a(appKey).
            setApiSecret(appSecret).
            setHttpClient(Some(myClient)).
            build(MyApi.instance())

    // 请求未授权的临时requestToken
    let requestToken: OAuth1RequestToken = service.getRequestToken()
    if (!requestToken.getToken().equals("request_token_0")) {
        println("1")
        return 1
    }

    // 请求对未授权的临时requestToken进行授权
    // 这一步是由被请求授权的网站进行的，跳转到创建项目/应用时填写的callback地址
    // 跳转中，会自动附加授权后的oauth_token、oauth_vericode等参数，这里只能自己模拟
    let authorizationUrl: String = service.getAuthorizationUrl(requestToken)
    let oauthVerifier: String = "123456"

    // 请求accessToken
    let accessToken: OAuth1AccessToken = service.getAccessToken(requestToken, oauthVerifier)
    if (!accessToken.getToken().equals("access_token")) {
        println("2")
        return 1
    }

    let request: OAuth4cjRequest = OAuth4cjRequest(Verb.GET, PROTECTED_RESOURCE_URL)
    service.signRequest(accessToken, request)

    try {
        let response: model.Response = service.execute(request)
        if (response.getCode() != 200) {
            println("3")
            return 1
        }
        let bodyString = ##"{"key1":"value1","key2":"value2"}"##
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
    hd.handle("/1234", { rws: http.ResponseWriteStream, req: http.Request =>
        sleep(1000*1000*1000)
        // 模拟服务器返回的json信息
        var returnJson: String = "error"

        // 获取请求中的头信息
        let header = req.header
        println("")
        println("-----server message------")
        println(header.getKeysToString())
        println("")
        println("-----header message------")
        println(header.get("Authorization").getOrThrow())

        // 请求头信息的Authorization相关信息，从第5位置开始截取
        // Authorization信息是"OAuth "开头，后面是键值对信息
        let authorizationSub = header.get("Authorization").getOrThrow().substring(6)

        // 使用“,”进行分割
        let splitArray: Array<String> = authorizationSub.split(",")
        // println("")
        // println("******splitArray******")
        // println(splitArray)

        // 循环分割之后的数组，赋值成HashMap键值对，方便之后查找
        let splitMap: HashMap<String, String> = HashMap<String, String>()
        for (item in splitArray) {
            let itemArray: Array<String> = item.split("=")
            // println("")
            // println("******itemArray******")
            // println(itemArray)
            if (itemArray.size == 2) {
                splitMap.put(itemArray[0].trim(), itemArray[1].trim())
            }
        }
        // println("")
        // println("******HashMap******")
        // println(splitMap)

        // 查找是否包含oauth_consumer_key、oauth_token、oauth_vericode
        var isGetRequestToken = splitMap.contains("oauth_consumer_key")
        var isGetAccressToken = splitMap.contains("oauth_token")

        // 都包含，表示进行到请求访问权限的access_token，之后可以使用access_token调用受保护资源
        if (isGetRequestToken && isGetAccressToken) {
            returnJson = ##"{"oauth_token":"access_token","oauth_token_secret":"access_token_secret"}"##
 
        } else if (isGetRequestToken) { // 表示第一步获取未授权的临时request_token
            returnJson = ##"{"oauth_token":"request_token_0","oauth_token_secret":"request_token_secret_0"}"##

        } else {
            // 错误，至少应该包含第一个关键字
            returnJson = "error"
        }

        // 查找是oauth_token是否为access_token，如果是说明是资源请求
        if (isGetAccressToken) {
            let token: String = splitMap.get("oauth_token").getOrThrow()
            // 这里比较带有双引号是因为没用用json解析，直接截取字段放在map中，所以带有双引号
            if (token.equals("\"access_token\"")) {
                // public init(code: Int32, message: String, headers: HashMap<String, String>, body: String)
                returnJson = ##"{"key1":"value1","key2":"value2"}"##
            }
        }

        println("")
        println("******returnJson******")
        println(returnJson)
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
        return "http://127.0.0.1:${port}/1234"
    }

    public func getAccessTokenEndpoint(): String {
        return "http://127.0.0.1:${port}/1234"
    }

    protected func getAuthorizationBaseUrl(): String {
        return "http://127.0.0.1:${port}/1234"
    }

    public func getRequestTokenExtractor(): TokenExtractor<OAuth1RequestToken> {
        return OAuth1RequestTokenJSONExtractor.instance()
    }

    public func getAccessTokenExtractor(): TokenExtractor<OAuth1AccessToken> {
        return OAuth1AccessTokenJSONExtractor.instance()
    }
}