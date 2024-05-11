// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from std import collection.*
// from std import io.*
from httpclient4cj import httpclient4cj.*
from std import sync.*
from std import time.*
from net import http.*
from std import socket.*
from std import unicode.*
// from encoding import url.*

var port: UInt16 = 0

main() { 
    serve()

    sleep(1000*1000*1000 * Duration.nanosecond)

    let myInterceptor = MyInterceptor()

    let client: HttpClient = HttpClient.builder()
        //.addNetworkInterceptor(MyInterceptor())
        .addInterceptor(myInterceptor)
        .build()

    myInterceptor.setClient(client)

    let url = "http://127.0.0.1:${port}/initiate"
    let mediaType: Option<MediaType> = MediaType.parse("application/x-www-form-urlencoded")
    let body = RealRequestBody.create(mediaType, Array<Byte>())
    let str =  ##"OAuth oauth_callback="oob", oauth_timestamp="1715340194", oauth_nonce="569602493", oauth_consumer_key="dpf43f3p2l4k3l03", oauth_signature_method="HMAC-SHA1", oauth_version="1.0", oauth_signature="miO3OQxDeMg43yS3MrDC7EO3vMw%3D""##

    let request = Request.builder()
        .url(url)
        .method("POST", body: body)
        .header("Authorization", str)
        .header("User-Agent", "")
        .build()
    let response: Response = client.newCall(request).execute()
    println(response.getBody().getOrThrow().getString())

    return 0
}


func serve(){
    let serverSocket = TcpServerSocket(bindAt: 0)
    let server = ServerBuilder().listener(serverSocket).build()

    // 模拟接收'printer.example.com'向'photos.example.net'请求未授权的临时requestToken
    server.distributor.register("/initiate", { httpContext =>
        println("initiate-----------------------------------------------0")
        sleep(1000*1000*10 * Duration.nanosecond)

        println("receive printer.example.com request: get requestToken")
        // 模拟服务器返回的json信息
        var returnJson: String = ""
        // 获取请求中的头信息
        let header = httpContext.request.headers

        var str: String = header.getFirst("Authorization") ?? ""
        let authorizationSub = str[6..str.size]

        println("-------------authorizationSub = ${authorizationSub}")

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
                if (key == "\"dpf43f3p2l4k3l03\"") {
                    returnJson = ##"{"oauth_token":"hh5s93j4hdidpola","oauth_token_secret":"hdhd0244k9j7ao03", "oauth_callback_confirmed":"true"}"##
                } else {
                    returnJson = ##"{"error":"clientId verification failed"}"##
                }
            case None =>
                returnJson = ##"{"error":"clientId verification failed"}"##
        }

        let resp = returnJson.toArray()
        httpContext.responseBuilder.body(resp)
        return
    })

    spawn{ 
        server.serve() 
    }
    sleep(Duration.second)
    port = serverSocket.localAddress.port
}

class MyInterceptor <: Interceptor {
    var client: Option<httpclient4cj.HttpClient> = Option<httpclient4cj.HttpClient>.None
    public func setClient(client: httpclient4cj.HttpClient) {
        this.client = client
    }

    public func intercept(chain: Chain): httpclient4cj.Response {
        println("-----intercept----------------------intercept---0")
        let dispatcher = client.getOrThrow().getDispatcher()
        dispatcher.runningCalls()
        //let run = dispatcher.runningCalls()
        // println(run.size)

        let request: httpclient4cj.Request = chain.getRequest()
        let requestBuilder: httpclient4cj.RequestBuilder  = request.newBuilder()
        //let header: Header = request.getHeaders()
        var response: httpclient4cj.Response =  chain.proceed(requestBuilder.build())
        let responseBuilder: httpclient4cj.ResponseBuilder = response.newBuilder().request(request)
        println("")
        println("-----interceptor message------")
        
        return responseBuilder.build()
    }
}
