// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj

@Test
public class TestOkHttpHttpClientConfigB008{
    /***
        public init(clientBuilder: OkHttpClientBuilder)
        public func createDefaultConfig(): OkHttpHttpClientConfig
        测试场景: 生成的OkHttpHttpClientConfig与默认OkHttpHttpClientConfig属性一致
    ***/

    @TestCase
    func testOkHttpHttpClientConfigGetClientBuilder01(): Unit {
         var okhttpHttpClientConfig=getOkHttpHttpClientConfig()
         var re_okhttpHttpClientConfig=okhttpHttpClientConfig.createDefaultConfig()
         var re_okhttpClientBuilder=re_okhttpHttpClientConfig.getClientBuilder()
         var re_okhttpClient=OkHttpClient(re_okhttpClientBuilder)
         var re_tlsClientConfig=re_okhttpClient.getTlsConfig().getOrThrow()
         let re_caFile=re_tlsClientConfig.certificateChainFile
         let re_verifyMode=re_tlsClientConfig.verifyMode

         var exp_okhttpClientBuilder=OkHttpClient.builder()
         var exp_okhttpClient=OkHttpClient(exp_okhttpClientBuilder)
         var exp_tlsClientConfig=exp_okhttpClient.getTlsConfig().getOrThrow()
         let exp_caFile=exp_tlsClientConfig.certificateChainFile
         let exp_verifyMode=exp_tlsClientConfig.verifyMode

         @Assert(re_caFile,exp_caFile)
         @Assert(assertTlsClientVerifyMode(re_verifyMode,exp_verifyMode),true)
    }
}