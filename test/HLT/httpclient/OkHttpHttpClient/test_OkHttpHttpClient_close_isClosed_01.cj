// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj

@Test
public class TestOkHttpHttpClientB008{
    /***
        public func close(): Unit
        public func isClosed(): Bool
        测试场景: 默认值/首次关闭
    ***/
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
}