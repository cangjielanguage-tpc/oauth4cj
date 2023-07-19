// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj

@Test
public class TestOkHttpHttpClientConfigB008{
    /***
        public init(clientBuilder: HttpClientBuilder)
        public func getClientBuilder(): HttpClientBuilder
        测试场景: 验证生成的OkHttpClientBuilder与构造OkHttpHttpClientConfig时的OkHttpClientBuilder属性一致
    ***/

    @TestCase
    func testOkHttpHttpClientConfigGetClientBuilder01(): Unit {
         var okhttpHttpClientConfig=getOkHttpHttpClientConfig()
         var re_okhttpClientBuilder=okhttpHttpClientConfig.getClientBuilder()
         var exp_okhttpClientBuilder=httpclient4cj.HttpClient.builder()
         var re_okhttpClient=httpclient4cj.HttpClient(re_okhttpClientBuilder)
         var exp_okhttpClient=httpclient4cj.HttpClient(exp_okhttpClientBuilder)

         var re_tlsClientConfig=re_okhttpClient.getTlsConfig().getOrThrow()
         var exp_tlsClientConfig=exp_okhttpClient.getTlsConfig().getOrThrow()

         let re_caFile=re_tlsClientConfig.certificateChainFile
         let exp_caFile=exp_tlsClientConfig.certificateChainFile
         @Assert(re_caFile,exp_caFile)
         let re_verifyMode=re_tlsClientConfig.verifyMode
         let exp_verifyMode=exp_tlsClientConfig.verifyMode         
         @Assert(assertTlsClientVerifyMode(re_verifyMode,exp_verifyMode),true)
    }
}