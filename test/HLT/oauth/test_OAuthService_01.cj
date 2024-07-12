// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
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

    @TestCase
    func testOAuthServiceTClosed01(): Unit {
         var oauth10aService=OAuthServiceTest.getOAuth10aService()
         var re_isClosed=oauth10aService.isClosed()
         try{
             oauth10aService.close()
             re_isClosed=oauth10aService.isClosed()
             @Assert(re_isClosed,true)
         }catch(e:Exception){
             println(e.toString())
             @Assert(re_isClosed,false)
         }
    }
    @TestCase
    func testOAuthServiceTClosed02(): Unit {
         var oauth20Service=OAuthServiceTest.getOAuth20Service()
         var re_isClosed=oauth20Service.isClosed()
         try{
             oauth20Service.close()
             re_isClosed=oauth20Service.isClosed()
             @Assert(re_isClosed,true)
         }catch(e:Exception){
             println(e.toString())
             @Assert(re_isClosed,false)
         }
    }
    @TestCase
    func testOAuthServiceTClosed03(): Unit {
         var oauth20Service=OAuthServiceTest.getOAuth20Service()
         var re_isClosed=oauth20Service.isClosed()
         try{
             oauth20Service.close()
             oauth20Service.close()
             re_isClosed=oauth20Service.isClosed()
             @Assert(re_isClosed,true)
         }catch(e:Exception){
             println(e.toString())
             @Assert(re_isClosed,false)
         }
    }
    /***
        public func execute(request: OAuth4cjRequest): Response
        测试场景: 执行请求成功
    ***/
    @TestCase
    func testOAuthServiceExecute0101(): Unit {
         let oauth10aService=OAuthServiceTest.getOAuth10aService()
         var oauth4cjRequest=OAuth4cjRequest(Verb.GET,url)
         let response=oauth10aService.execute(oauth4cjRequest)
         @Assert(response.getCode(),200)
    }
    /***
        public func execute(request: OAuth4cjRequest): Response
        测试场景: 执行请求失败
    ***/
    @Skip
    @TestCase
    func testOAuthServiceExecute0102(): Unit {
         let oauth10aService=OAuthServiceTest.getOAuth10aService()
         var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.123.com")
         var re_flag=1
         try{
             let response=oauth10aService.execute(oauth4cjRequest)
             @Assert(response.getCode(),200)
         }catch(e:Exception){
             println(e.toString())
             if(e.toString().contains("parse domain = www.123.com fail")){
                re_flag=0
             }
         }
         @Assert(re_flag,0)
    }
    /***
        public func execute(request: OAuth4cjRequest, callback: Option<OAuthAsyncRequestCallback>): Future<Any>
        测试场景:callback为Option<OAuthAsyncRequestCallback>.None,不回调
    ***/
    @TestCase
    func testOAuthServiceExecute01(): Unit {
         let oauth10aService=OAuthServiceTest.getOAuth10aService()
         var oauth4cjRequest=OAuth4cjRequest(Verb.GET,url)
         var callback=Option<OAuthAsyncRequestCallback>.None
         let fut_response=oauth10aService.execute(oauth4cjRequest,callback)
         let response_any=fut_response.get()
         let response=(response_any as oauth4cj.OAuth4cjResponse ).getOrThrow()
         @Assert(response.getCode(),200)
    }
    /***
        public func execute(request: OAuth4cjRequest, callback: Option<OAuthAsyncRequestCallback>): Future<Any>
        测试场景:callback非Option<OAuthAsyncRequestCallback>.None,回调
    ***/
    @TestCase
    func testOAuthServiceExecute0202(): Unit {
         let oauth10aService=OAuthServiceTest.getOAuth10aService()
         var oauth4cjRequest=OAuth4cjRequest(Verb.GET,url)
         var sub01=SubOAuthAsyncRequestCallback()
         var callback=Option<OAuthAsyncRequestCallback>.Some(sub01)
         oauth10aService.execute(oauth4cjRequest,callback)
         @Assert(sub01.getFlagOnCompleted(),"pass")
         @Assert(sub01.getFlagOnThrowable(),"fail")
    }
    /***
        public func execute(request: OAuth4cjRequest, callback: Option<OAuthAsyncRequestCallback>): Future<Any>
        测试场景:请求响应失败
    ***/
    @TestCase
    func testOAuthServiceExecute0203(): Unit {
         let oauth10aService=OAuthServiceTest.getOAuth10aService()
         var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.123.com")
         var sub01=SubOAuthAsyncRequestCallback()
         var callback=Option<OAuthAsyncRequestCallback>.Some(sub01)
         oauth10aService.execute(oauth4cjRequest,callback)
         @Assert(sub01.getFlagOnCompleted(),"pass")
         @Assert(sub01.getFlagOnThrowable(),"pass")
    }
}
func serve(): Unit {
    let serverSocket = TcpServerSocket(bindAt: 0)
    let server = ServerBuilder().listener(serverSocket).build()
    server.distributor.register("/index",
        {
        httpContext =>
        let resp = "Hello from /red".toArray()
        httpContext.responseBuilder.body(resp)
        return
    })
    spawn {server.serve()}
    sleep(Duration.second)
    port=serverSocket.localAddress.port
}
