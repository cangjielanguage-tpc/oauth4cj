// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj

import std.collection.*
import httpclient4cj.*
import std.sync.*
import std.unicode.*
import std.time.*
import net.http.*
import std.socket.*
public import oauth4cj.*

var port: UInt16 = 0

@Test
public class TestRFC5849{
    @TestCase
    func testRFC584901(): Unit {
        spawn {
            serve()
        }
        sleep(3 * Duration.second)
        let clientId: String = "dpf43f3p2l4k3l03"
        let clientSecret: String = "kd94hf93k423kf4"
        let PROTECTED_RESOURCE_URL: String = "http://127.0.0.1:${port}/ready"
        let myInterceptor = MyInterceptor()
        let client: Httpclient4cjHttpClient = Httpclient4cjHttpClient.builder().addInterceptor(myInterceptor).build()
        myInterceptor.setClient(client)
        let myClient: OkHttpHttpClient = OkHttpHttpClient(client)
        let service: OAuth10aService = ServiceBuilderOAuth10a(clientId).
                setApiSecret(clientSecret).
                setHttpClient(Some(myClient)).
                build(MyApi.instance())
        let requestToken: OAuth1RequestToken = service.getRequestToken()
        @Assert(requestToken.getToken(),"hh5s93j4hdidpola")
        let oauthVerifier: String = "123456"
        let accessToken: OAuth1AccessToken = service.getAccessToken(requestToken, oauthVerifier)
        @Assert(accessToken.getToken(),"nnch734d00sl2jdk")
        let request: OAuth4cjRequest = OAuth4cjRequest(Verb.GET, PROTECTED_RESOURCE_URL)
        service.signRequest(accessToken, request)
        let response: OAuth4cjResponse = service.execute(request)
        @Assert(response.getCode(),200)
        let bodyString = ##"{"photo1":"aaaaaa","photo2":"bbbbbbb"}"##
        @Assert(response.getBody(),bodyString)
    }
}

func serve(){
    let serverSocket = TcpServerSocket(bindAt: 0)
    let server = ServerBuilder().listener(serverSocket).build()

    // 模拟接收'printer.example.com'向'photos.example.net'请求未授权的临时requestToken
    server.distributor.register("/initiate", { httpContext =>
        sleep(1000*1000*10 * Duration.nanosecond)
        println("receive printer.example.com request: get requestToken")
        // 模拟服务器返回的json信息
        var returnJson: String = ""
        // 获取请求中的头信息
        let header = httpContext.request.headers
        // 请求头信息的Authorization相关信息，从第5位置开始截取
        // Authorization信息是"OAuth "开头，后面是键值对信息
        //let authorizationSub = header.get("Authorization").getOrThrow()[0].substring(6)
        var str: String = header.getFirst("Authorization") ?? ""
        let authorizationSub = str[6..str.size]
        // [OAuth oauth_callback="oob", oauth_timestamp="1692197160", oauth_nonce="546459459", oauth_consumer_key="dpf43f3p2l4k3l03",
        // oauth_signature_method="HMAC-SHA1", oauth_version="1.0", oauth_signature="6c2NvCIbb5bYkRlG%2Bx3MUJo%2FBPs%3D"]

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

    // 模拟接收'printer.example.com'向'photos.example.net'请求正式的 accessToken
    server.distributor.register("/token", { httpContext =>
        sleep(1000*1000*10 * Duration.nanosecond)
        println("receive printer.example.com request: get accessToken")
        // 模拟服务器返回的json信息
        var returnJson: String = "error"
        // 获取请求中的头信息
        let header = httpContext.request.headers
        // 请求头信息的Authorization相关信息，从第5位置开始截取
        // Authorization信息是"OAuth "开头，后面是键值对信息
        //let authorizationSub = header.get("Authorization").getOrThrow()[0].substring(6)
        var str: String = header.getFirst("Authorization") ?? ""
        let authorizationSub = str[6..str.size]

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
                if (key == "\"dpf43f3p2l4k3l03\"") {
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
                if (token == "\"hh5s93j4hdidpola\"") {
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

        let resp = returnJson.toArray()
        httpContext.responseBuilder.body(resp)
        return
    })

    // 模拟接收'printer.example.com'向'photos.example.net'请求照片（受保护资源）
    server.distributor.register("/ready", { httpContext =>
        sleep(1000*1000*10 * Duration.nanosecond)
        println("receive printer.example.com request: get photo")
        // 模拟服务器返回的json信息
        var returnJson: String = "error"
        // 获取请求中的头信息
        let header = httpContext.request.headers
        // 请求头信息的Authorization相关信息，从第5位置开始截取
        // Authorization信息是"OAuth "开头，后面是键值对信息
        var str: String = header.getFirst("Authorization") ?? ""
        let authorizationSub = str[6..str.size]

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
                if (key == "\"dpf43f3p2l4k3l03\"") {
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
                if (token == "\"nnch734d00sl2jdk\"") {
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
    var client: Option<Httpclient4cjHttpClient> = Option<Httpclient4cjHttpClient>.None
    public func setClient(client: Httpclient4cjHttpClient) {
        this.client = client
    }

    public func intercept(chain: Chain): Httpclient4cjResponse {
        let dispatcher = client.getOrThrow().getDispatcher()
        dispatcher.runningCalls()
        //let run = dispatcher.runningCalls()
        // println(run.size)

        let request: Httpclient4cjRequest = chain.getRequest()
        let requestBuilder: Httpclient4cjRequestBuilder  = request.newBuilder()
        //let header: Header = request.getHeaders()
        var response: Httpclient4cjResponse =  chain.proceed(requestBuilder.build())
        let responseBuilder: Httpclient4cjResponseBuilder = response.newBuilder().request(request)
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