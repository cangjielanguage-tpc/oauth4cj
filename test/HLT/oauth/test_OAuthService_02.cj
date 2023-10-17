// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj

public var url="http://127.0.0.1:${port}/index"
@Test
public class TestOAuthServiceB008{
    /***
        public open func close(): Unit
        测试场景:关闭/重复关闭
    ***/
    public override func beforeAll(): Unit{
        serve()
        sleep(3*Duration.second)
        url="http://127.0.0.1:${port}/index"
    }
    /***
        public func execute(request: OAuth4cjRequest, callback: Option<OAuthAsyncRequestCallback>,converter: Option<ResponseConverter>): Future<Any>
        测试场景:converter为Option<ResponseConverter>.None
    ***/
    @TestCase
    func testOAuthServiceExecute0301(): Unit {
         let oauth10aService=OAuthServiceTest.getOAuth10aService()
         var oauth4cjRequest=OAuth4cjRequest(Verb.GET,url)
         var sub01=SubOAuthAsyncRequestCallback()
         var callback=Option<OAuthAsyncRequestCallback>.Some(sub01)
         var converter=Option<ResponseConverter>.None
         oauth10aService.execute(oauth4cjRequest,callback,converter)
         @Assert(sub01.getFlagOnCompleted(),"pass")
         @Assert(sub01.getFlagOnThrowable(),"fail")
    }
    /***
        public func execute(request: OAuth4cjRequest, callback: Option<OAuthAsyncRequestCallback>,converter: Option<ResponseConverter>): Future<Any>
        测试场景:converter非Option<ResponseConverter>.None
    ***/
    @TestCase
    func testOAuthServiceExecute0302(): Unit {
         let oauth10aService=OAuthServiceTest.getOAuth10aService()
         var oauth4cjRequest=OAuth4cjRequest(Verb.GET,url)
         var sub01=SubOAuthAsyncRequestCallback()
         var callback=Option<OAuthAsyncRequestCallback>.Some(sub01)
         let subResponseConverter=SubResponseConverter()
         var converter=Option<ResponseConverter>.Some(subResponseConverter)
         oauth10aService.execute(oauth4cjRequest,callback,converter)
         @Assert(subResponseConverter.getflag(),5)
    }
    /***
        public func executeAsync(request: OAuth4cjRequest): Future<Any>
        测试场景: 执行请求成功
    ***/
    @TestCase
    func testOAuthServiceExecuteAsync01(): Unit {
         let oauth10aService=OAuthServiceTest.getOAuth10aService()
         var oauth4cjRequest=OAuth4cjRequest(Verb.GET,url)
         let response_any=oauth10aService.executeAsync(oauth4cjRequest).get()
         let response= (response_any as oauth4cj.OAuth4cjResponse ).getOrThrow()
         @Assert(response.getCode(),200)
    }
    /***
        public func executeAsync(request: OAuth4cjRequest): Future<Any>
        测试场景: 执行请求失败
    ***/
    @TestCase
    func testOAuthServiceExecuteAsync02(): Unit {
         let oauth10aService=OAuthServiceTest.getOAuth10aService()
         var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.123.com")
         let response_any=oauth10aService.executeAsync(oauth4cjRequest).get()
         var reflag=1
         try{
             (response_any as oauth4cj.OAuth4cjResponse ).getOrThrow()
         }catch(e:NoneValueException){
             reflag=0
         }
         @Assert(reflag,0)
    }
    /***
        public open func getApiKey(): String
        测试场景:与构造器传入一致即可,验证不同的子类实现
    ***/

    var serviceType=""
    @TestCase
    func testOAuthServiceGetApiKey01(): Unit {
        var oauth10aService=OAuthServiceTest.getOAuth10aService()
        serviceType="OAuth10aService"
        var re_apiKey=oauth10aService.getApiKey()
        @Assert(re_apiKey,serviceType+OAuthServiceTest.apiKey)
    }

    @TestCase
    func testOAuthServiceGetApiKey02(): Unit {
         var oauth20Service=OAuthServiceTest.getOAuth20Service()
         serviceType="OAuth20Service"
         var re_apiKey=oauth20Service.getApiKey()
         @Assert(re_apiKey,serviceType+OAuthServiceTest.apiKey)
    }
    /***
        public open func getApiSecret(): String
        测试场景:与构造器传入一致即可,验证不同的子类实现
    ***/
    @TestCase
    func testOAuthServiceGetApiSecret01(): Unit {
         var oauth10aService=OAuthServiceTest.getOAuth10aService()
         serviceType="OAuth10aService"
         var re_apiSecret=oauth10aService.getApiSecret()
         @Assert(re_apiSecret,serviceType+OAuthServiceTest.apiSecret)
    }
    @TestCase
    func testOAuthServiceGetApiSecret02(): Unit {
         var oauth20Service=OAuthServiceTest.getOAuth20Service()
         serviceType="OAuth20Service"
         var re_apiSecret=oauth20Service.getApiSecret()
         @Assert(re_apiSecret,serviceType+OAuthServiceTest.apiSecret)
    }
    /***
        public open func getCallback(): Option<String>
        测试场景:与构造器传入一致即可,验证不同的子类实现
    ***/

    @TestCase
    func testOAuthServiceTGetCallback01(): Unit {
         var oauth10aService=OAuthServiceTest.getOAuth10aService()
         serviceType="OAuth10aService"
         var re_callback=oauth10aService.getCallback()
         @Assert(re_callback,serviceType+OAuthServiceTest.callback)
    }
    @TestCase
    func testOAuthServiceTGetCallback02(): Unit {
         var oauth20Service=OAuthServiceTest.getOAuth20Service()
         serviceType="OAuth20Service"
         var re_callback=oauth20Service.getCallback()
         @Assert(re_callback,serviceType+OAuthServiceTest.callback)
    }
    /***
        public open func isClosed(): Bool
        测试场景:默认false
    ***/
    @TestCase
    func testOAuthServiceTIsClosed01(): Unit {
         var oauth10aService=OAuthServiceTest.getOAuth10aService()
         var re_isClosed=oauth10aService.isClosed()
         @Assert(re_isClosed,false)
    }
    @TestCase
    func testOAuthServiceTIsClosed02(): Unit {
         var oauth20Service=OAuthServiceTest.getOAuth20Service()
         var re_isClosed=oauth20Service.isClosed()
         @Assert(re_isClosed,false)
    }
}
func serve(): Unit {
    let serverSocket = TcpServerSocket(bindAt: 0)
    let server = ServerBuilder.new().listener(serverSocket).build()
    server.distributor.register("/index",
        {
        httpContext =>
        let resp = "Hello from /red".toUtf8Array()
        httpContext.responseBuilder.body(resp)
        return
    })
    spawn {server.serve()}
    sleep(Duration.second)
    port=serverSocket.localAddress.port
}
