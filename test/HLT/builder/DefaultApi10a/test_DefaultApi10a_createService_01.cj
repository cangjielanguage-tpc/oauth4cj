// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj

@Test
public class TestDefaultApi10aB004{
    /***
        public func createService(apiKey:String, apiSecret: String, callback: String, scope: String,debugStream: Option<OutputStream>, userAgent: String, httpClientConfig: Option<HttpClientConfig>,httpClient: Option<OAuth4cjHttpClient>): OAuth10aService
        测试场景:callback ,scope,state均是Option<String>.None
    ***/
    @TestCase
    func testDefaultApi10aCreateService01(): Unit {
        var subDefaultApi10a=SubDefaultApi10a()
        let str_common="cangjie"
        let debugStream=Option<OutputStream>.None
        let httpClientConfig=Option<HttpClientConfig>.None
        let httpClient=Option<OAuth4cjHttpClient>.None
        let httpClientProvider=Option<HttpClientProvider>.None
        let oAuth10aService=subDefaultApi10a.createService(str_common,str_common,str_common,str_common,debugStream,str_common,httpClientConfig,httpClient,httpClientProvider)
        @Assert(oAuth10aService is OAuth10aService,true)
    }
}
