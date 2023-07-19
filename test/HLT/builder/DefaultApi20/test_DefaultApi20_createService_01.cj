// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj

@Test
public class TestDefaultApi20B004{
    /***
        public func createService(apiKey: String, apiSecret: String, callback: String, defaultScope: String,responseType: String, debugStream: ?OutputStream, userAgent: String, httpClientConfig: ?HttpClientConfig,httpClient: ?OAuth4cjHttpClient):OAuth20Service
        测试场景:callback ,scope,state均是Option<String>.None
    ***/
    @TestCase
    func testDefaultApi20CreateService01(): Unit {
        var subDefaultApi20=SubDefaultApi20()
        let str_common="cangjie"
        let debugStream=Option<OutputStream>.None
        let httpClientConfig=Option<HttpClientConfig>.None
        let httpClient=Option<OAuth4cjHttpClient>.None
        let httpClientProvider=Option<HttpClientProvider>.None
        let oAuth20Service=subDefaultApi20.createService(str_common,str_common,str_common,str_common,str_common,debugStream,str_common,httpClientConfig,httpClient,httpClientProvider)
        @Assert(oAuth20Service is OAuth20Service,true)
    }
}
