// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj

public var url="http://127.0.0.1:${port}/index"
@Test
public class TestOkHttpHttpClientB008{
    /***
        public func close(): Unit
        public func isClosed(): Bool
        测试场景: 默认值/首次关闭
    ***/
    public override func beforeAll(): Unit{
        serve()
        sleep(3*Duration.second)
        url="http://127.0.0.1:${port}/index"
    }
    //public init()
    @TestCase
    func testOkHttpHttpClientClose0101(): Unit {
         var okhttpHttpClient=OkHttpHttpClient()
         @Assert(okhttpHttpClient.isClosed(),false)
         okhttpHttpClient.close()
         @Assert(okhttpHttpClient.isClosed(),true)
    }
    //public init(config: OkHttpHttpClientConfig)
    @TestCase
    func testOkHttpHttpClientClose0102(): Unit {
         var okhttpHttpClientConfig=getOkHttpHttpClientConfig()
         var okhttpHttpClient=OkHttpHttpClient(okhttpHttpClientConfig)
         @Assert(okhttpHttpClient.isClosed(),false)
         okhttpHttpClient.close()
         @Assert(okhttpHttpClient.isClosed(),true)
    }
    //public init(client: httpclient4cj.HttpClient)
    @TestCase
    func testOkHttpHttpClientClose0103(): Unit {
         var re_okhttpClientBuilder=httpclient4cj.HttpClient.builder()
         var okhttpClient=httpclient4cj.HttpClient(re_okhttpClientBuilder)
         var okhttpHttpClient=OkHttpHttpClient(okhttpClient)
         @Assert(okhttpHttpClient.isClosed(),false)
         okhttpHttpClient.close()
         @Assert(okhttpHttpClient.isClosed(),true)
    }
    /***
        public func close(): Unit
        public func isClosed(): Bool
        测试场景: 重复关闭
    ***/
    //public init()
    @TestCase
    func testOkHttpHttpClientClose0201(): Unit {
         var okhttpHttpClient=OkHttpHttpClient()
         okhttpHttpClient.close()
         okhttpHttpClient.close()
         @Assert(okhttpHttpClient.isClosed(),true)
    }
    /***
        public func execute(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,bodyContents: Array<UInt8>): OAuth4cjResponse
        测试场景:发送正常请求
    ***/
    @TestCase
    func testOkHttpHttpClientExecute0101(): Unit {
         var okhttpHttpClient=OkHttpHttpClient()
         let userAgent="userAgent"
         let headers=HashMap<String, String>([("header01","header01c"),("header02","header02c")])
         let httpVerb=Verb.GET
         let completeUrl=url
         let bodyContents=Array<UInt8>([1,2,3,4,5])
         let re_oauth4cjResponse=okhttpHttpClient.execute(userAgent,headers,httpVerb,completeUrl,bodyContents)
         @Assert(re_oauth4cjResponse.getCode(),200)
    }
    /***
        public func execute(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,bodyContents: Array<UInt8>): OAuth4cjResponse
        测试场景:发送错误请求
    ***/
    @TestCase
    func testOkHttpHttpClientExecute0102(): Unit {
         var okhttpHttpClient=OkHttpHttpClient()
         let userAgent="userAgent"
         let headers=HashMap<String, String>([("header01","header01c"),("header02","header02c")])
         let httpVerb=Verb.GET
         let completeUrl="http://www.123.com"
         let bodyContents=Array<UInt8>([1,2,3,4,5])
         var re_flag=1
         try{
             okhttpHttpClient.execute(userAgent,headers,httpVerb,completeUrl,bodyContents)
         }catch(e:httpclient4cj.HttpException){
             if(e.toString().contains("HttpException: parse domain = www.123.com fail")){
                  re_flag=0
             }
         }
         @Assert(re_flag,0)
    }
    /***
        public func execute(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,bodyContents: MultipartPayload): OAuth4cjResponse
        测试场景:发送正常请求
    ***/
    @TestCase
    func testOkHttpHttpClientExecute0201(): Unit {
         var okhttpHttpClient=OkHttpHttpClient()
         let userAgent="userAgent"
         let headers=HashMap<String, String>([("header01","header01c"),("header02","header02c")])
         let httpVerb=Verb.GET
         let completeUrl=url
         let bodyContents=MultipartPayload()
         var flag=1
         try{
             okhttpHttpClient.execute(userAgent,headers,httpVerb,completeUrl,bodyContents)
         }catch(e:OAuth4cjException){
             if(e.toString().contains("OAuth4cjException") && e.toString().contains("OKHttpClient does not support Multipart payload for the moment")){
                 flag=0
             }
         }
         @Assert(flag,0)
    }
    /***
        public func execute(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,bodyContents: String): OAuth4cjResponse
        测试场景:发送错误请求
    ***/
    @TestCase
    func testOkHttpHttpClientExecute0302(): Unit {
         var okhttpHttpClient=OkHttpHttpClient()
         let userAgent="userAgent"
         let headers=HashMap<String, String>([("header01","header01c"),("header02","header02c")])
         let httpVerb=Verb.GET
         let completeUrl="http://www.123.com"
         let bodyContents="bodyContents"
         var re_flag=1
         try{
             okhttpHttpClient.execute(userAgent,headers,httpVerb,completeUrl,bodyContents)
         }catch(e:httpclient4cj.HttpException){
             if(e.toString().contains("HttpException: parse domain = www.123.com fail")){
                  re_flag=0
             }
         }
         @Assert(re_flag,0)
    }
    /***
        public func execute(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,bodyContents: File): OAuth4cjResponse
        测试场景:发送正常请求
    ***/
    @TestCase
    func testOkHttpHttpClientExecute0401(): Unit {
         var okhttpHttpClient=OkHttpHttpClient()
         let userAgent="userAgent"
         let headers=HashMap<String, String>([("header01","header01c"),("header02","header02c")])
         let httpVerb=Verb.GET
         let completeUrl=url
         let bodyContents=File("./test_OkHttpHttpClient_01.cj.out",OpenOption.Open(true,false))
         let re_oauth4cjResponse=okhttpHttpClient.execute(userAgent,headers,httpVerb,completeUrl,bodyContents)
         @Assert(re_oauth4cjResponse.getCode(),200)
    }
    /***
        public func execute(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,bodyContents: File): OAuth4cjResponse
        测试场景:发送错误请求
    ***/
    @TestCase
    func testOkHttpHttpClientExecute0402(): Unit {
         var okhttpHttpClient=OkHttpHttpClient()
         let userAgent="userAgent"
         let headers=HashMap<String, String>([("header01","header01c"),("header02","header02c")])
         let httpVerb=Verb.GET
         let completeUrl="http://www.123.com"
         let bodyContents=File("./test_OkHttpHttpClient_01.cj.out",OpenOption.Open(true,false))
         var re_flag=1
         try{
             okhttpHttpClient.execute(userAgent,headers,httpVerb,completeUrl,bodyContents)
         }catch(e:httpclient4cj.HttpException){
             if(e.toString().contains("HttpException: parse domain = www.123.com fail")){
                  re_flag=0
             }
         }
         @Assert(re_flag,0)
    }
    /***
        public func executeAsync(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,bodyContents: Array<UInt8>,
        callback: Option<OAuthAsyncRequestCallback>,converter: Option<ResponseConverter>): Future<Any>
        测试场景:发送正常请求
    ***/
    @TestCase
    func testOkHttpHttpClientExecuteAsync0101(): Unit {
         var okhttpHttpClient=OkHttpHttpClient()
         let userAgent="userAgent"
         let headers=HashMap<String, String>([("header01","header01c"),("header02","header02c")])
         let httpVerb=Verb.GET
         let completeUrl=url
         let bodyContents=Array<UInt8>([1,2,3,4,5])
         let subOAuthAsyncRequestCallback=SubOAuthAsyncRequestCallback()
         let callback=Option<OAuthAsyncRequestCallback>.Some(subOAuthAsyncRequestCallback)
         let subResponseConverter=SubResponseConverter()
         let converter=Option<ResponseConverter>.Some(subResponseConverter)
         try{
             okhttpHttpClient.executeAsync(userAgent,headers,httpVerb,completeUrl,bodyContents,callback,converter)
             @Assert(subOAuthAsyncRequestCallback.getFlagOnCompleted(),"pass")
             @Assert(subOAuthAsyncRequestCallback.getFlagOnThrowable(),"fail")
         }catch(e:Exception){
             @Assert(subOAuthAsyncRequestCallback.getFlagOnThrowable(),"pass")
             @Assert(subOAuthAsyncRequestCallback.getFlagOnCompleted(),"fail")
         }
    }
    /***
        public func executeAsync(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,bodyContents: Array<UInt8>,
        callback: Option<OAuthAsyncRequestCallback>,converter: Option<ResponseConverter>): Future<Any>
        测试场景:发送错误请求
    ***/
    @TestCase
    func testOkHttpHttpClientExecuteAsync0102(): Unit {
         var okhttpHttpClient=OkHttpHttpClient()
         let userAgent="userAgent"
         let headers=HashMap<String, String>([("header01","header01c"),("header02","header02c")])
         let httpVerb=Verb.GET
         let completeUrl="http://www.123.com"
         let bodyContents=Array<UInt8>([1,2,3,4,5])
         let subOAuthAsyncRequestCallback=SubOAuthAsyncRequestCallback()
         let callback=Option<OAuthAsyncRequestCallback>.Some(subOAuthAsyncRequestCallback)
         let subResponseConverter=SubResponseConverter()
         let converter=Option<ResponseConverter>.Some(subResponseConverter)
         let response_any=okhttpHttpClient.executeAsync(userAgent,headers,httpVerb,completeUrl,bodyContents,callback,converter).get()
         var reflag=1
         try{
             (response_any as oauth4cj.OAuth4cjResponse).getOrThrow()
         }catch(e:NoneValueException){
             reflag=0
         }
         @Assert(reflag,0)
         @Assert(subOAuthAsyncRequestCallback.getFlagOnCompleted(),"pass")
         @Assert(subOAuthAsyncRequestCallback.getFlagOnThrowable(),"pass")
    }
    /***
        public func executeAsync(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,bodyContents: MultipartPayload,
         callback: Option<OAuthAsyncRequestCallback>,converter: Option<ResponseConverter>): Future<Any>
        测试场景:发送正常请求
    ***/
    @TestCase
    func testOkHttpHttpClientExecuteAsync0201(): Unit {
         var okhttpHttpClient=OkHttpHttpClient()
         let userAgent="userAgent"
         let headers=HashMap<String, String>([("header01","header01c"),("header02","header02c")])
         let httpVerb=Verb.GET
         let completeUrl=url
         let bodyContents=MultipartPayload()
         let subOAuthAsyncRequestCallback=SubOAuthAsyncRequestCallback()
         let callback=Option<OAuthAsyncRequestCallback>.Some(subOAuthAsyncRequestCallback)
         let subResponseConverter=SubResponseConverter()
         let converter=Option<ResponseConverter>.Some(subResponseConverter)
         var flag=1
         try{
             okhttpHttpClient.executeAsync(userAgent,headers,httpVerb,completeUrl,bodyContents,callback,converter)
         }catch(e:OAuth4cjException){
             if(e.toString().contains("OAuth4cjException: OKHttpClient does not support Multipart payload for the moment")){
                 flag=0
             }
         }
         @Assert(flag,0)
    }
    /***
        public func executeAsync(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,bodyContents: String,
        callback: Option<OAuthAsyncRequestCallback>,converter: Option<ResponseConverter>): Future<Any>
        测试场景:发送正常请求
    ***/
    @TestCase
    func testOkHttpHttpClientExecuteAsync0301(): Unit {
         var okhttpHttpClient=OkHttpHttpClient()
         let userAgent="userAgent"
         let headers=HashMap<String, String>([("header01","header01c"),("header02","header02c")])
         let httpVerb=Verb.GET
         let completeUrl=url
         let bodyContents="bodyContents"
         let subOAuthAsyncRequestCallback=SubOAuthAsyncRequestCallback()
         let callback=Option<OAuthAsyncRequestCallback>.Some(subOAuthAsyncRequestCallback)
         let subResponseConverter=SubResponseConverter()
         let converter=Option<ResponseConverter>.Some(subResponseConverter)
         okhttpHttpClient.executeAsync(userAgent,headers,httpVerb,completeUrl,bodyContents,callback,converter)
         @Assert(subOAuthAsyncRequestCallback.getFlagOnCompleted(),"pass")
         @Assert(subOAuthAsyncRequestCallback.getFlagOnThrowable(),"pass")
    }
    /***
        public func executeAsync(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,bodyContents: String,
        callback: Option<OAuthAsyncRequestCallback>,converter: Option<ResponseConverter>): Future<Any>
        测试场景:发送错误请求
    ***/
    @TestCase
    func testOkHttpHttpClientExecuteAsync0302(): Unit {
         var okhttpHttpClient=OkHttpHttpClient()
         let userAgent="userAgent"
         let headers=HashMap<String, String>([("header01","header01c"),("header02","header02c")])
         let httpVerb=Verb.GET
         let completeUrl="http://www.123.com"
         let bodyContents="bodyContents"
         let subOAuthAsyncRequestCallback=SubOAuthAsyncRequestCallback()
         let callback=Option<OAuthAsyncRequestCallback>.Some(subOAuthAsyncRequestCallback)
         let subResponseConverter=SubResponseConverter()
         let converter=Option<ResponseConverter>.Some(subResponseConverter)

         let response_any=okhttpHttpClient.executeAsync(userAgent,headers,httpVerb,completeUrl,bodyContents,callback,converter).get()
         var reflag=1
         try{
             (response_any as oauth4cj.OAuth4cjResponse).getOrThrow()
         }catch(e:NoneValueException){
             reflag=0
         }
         @Assert(reflag,0)
         @Assert(subOAuthAsyncRequestCallback.getFlagOnCompleted(),"pass")
         @Assert(subOAuthAsyncRequestCallback.getFlagOnThrowable(),"pass")
    }
    /***
        public func executeAsync(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,bodyContents: File,
        callback: Option<OAuthAsyncRequestCallback>,converter: Option<ResponseConverter>): Future<Any>
        测试场景:发送正常请求
    ***/
    @TestCase
    func testOkHttpHttpClientExecuteAsync0401(): Unit {
         var okhttpHttpClient=OkHttpHttpClient()
         let userAgent="userAgent"
         let headers=HashMap<String, String>([("header01","header01c"),("header02","header02c")])
         let httpVerb=Verb.GET
         let completeUrl=url
         let bodyContents=File("./test_OkHttpHttpClient_01.cj.out",OpenOption.Open(true,false))
         let subOAuthAsyncRequestCallback=SubOAuthAsyncRequestCallback()
         let callback=Option<OAuthAsyncRequestCallback>.Some(subOAuthAsyncRequestCallback)
         let subResponseConverter=SubResponseConverter()
         let converter=Option<ResponseConverter>.Some(subResponseConverter)
         okhttpHttpClient.executeAsync(userAgent,headers,httpVerb,completeUrl,bodyContents,callback,converter)
         @Assert(subOAuthAsyncRequestCallback.getFlagOnCompleted(),"pass")
         @Assert(subOAuthAsyncRequestCallback.getFlagOnThrowable(),"pass")
    }
    /***
        public func executeAsync(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,bodyContents: File,
        callback: Option<OAuthAsyncRequestCallback>,converter: Option<ResponseConverter>): Future<Any>
        测试场景:发送错误请求
    ***/
    @TestCase
    func testOkHttpHttpClientExecuteAsync0402(): Unit {
         var okhttpHttpClient=OkHttpHttpClient()
         let userAgent="userAgent"
         let headers=HashMap<String, String>([("header01","header01c"),("header02","header02c")])
         let httpVerb=Verb.GET
         let completeUrl="http://www.123.com"
         let bodyContents=File("./test_OkHttpHttpClient_01.cj.out",OpenOption.Open(true,false))
         let subOAuthAsyncRequestCallback=SubOAuthAsyncRequestCallback()
         let callback=Option<OAuthAsyncRequestCallback>.Some(subOAuthAsyncRequestCallback)
         let subResponseConverter=SubResponseConverter()
         let converter=Option<ResponseConverter>.Some(subResponseConverter)
         let response_any=okhttpHttpClient.executeAsync(userAgent,headers,httpVerb,completeUrl,bodyContents,callback,converter).get()
         var reflag=1
         try{
             (response_any as oauth4cj.OAuth4cjResponse).getOrThrow()
             @Assert(subOAuthAsyncRequestCallback.getFlagOnCompleted(),"fail")
             @Assert(subOAuthAsyncRequestCallback.getFlagOnThrowable(),"pass")
         }catch(e:NoneValueException){
             reflag=0
             @Assert(subOAuthAsyncRequestCallback.getFlagOnThrowable(),"pass")
             @Assert(subOAuthAsyncRequestCallback.getFlagOnCompleted(),"pass")
         }
         @Assert(reflag,0)

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