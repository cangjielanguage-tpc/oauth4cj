// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj

@Test
public class TestOkHttpProviderB008{
    /***
        public func createClient(config: HttpClientConfig): Option<OAuth4cjHttpClient>
        测试场景: config是OkHttpHttpClientConfig,返回Option<OkHttpHttpClient>
    ***/

    @TestCase
    func testOkHttpProviderCreateClient01(): Unit {
         var okhttpProvider=OkHttpProvider()
         var okhttpHttpClientConfig=getOkHttpHttpClientConfig()
         var newHttpClient=okhttpProvider.createClient(okhttpHttpClientConfig).getOrThrow()
         @Assert(newHttpClient is OkHttpHttpClient,true)
    }
}