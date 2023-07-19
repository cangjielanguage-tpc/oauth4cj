// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj

@Test
public class TestOkHttpProviderB008{
    /***
        public func createClient(config: HttpClientConfig): Option<OAuth4cjHttpClient>
        测试场景: config不是OkHttpHttpClientConfig,返回Option<OkHttpHttpClient>.None
    ***/

    @TestCase
    func testOkHttpProviderCreateClient02(): Unit {
         var okhttpProvider=OkHttpProvider()
         var otherHttpClientConfig=getOtherHttpClientConfig()
         var exp_flag=1
         try{
            okhttpProvider.createClient(otherHttpClientConfig).getOrThrow()
         }catch(e:NoneValueException){
            exp_flag=0
         }
         @Assert(exp_flag,0)
    }
}

public func getOtherHttpClientConfig():OtherHttpClientConfig{
    var okhttpClientBuilder=httpclient4cj.HttpClient.builder()
    var otherHttpClientConfig=OtherHttpClientConfig(okhttpClientBuilder)
    return otherHttpClientConfig
}

public class OtherHttpClientConfig <: HttpClientConfig {
    private var clientBuilder=httpclient4cj.HttpClient.builder()
    public init(clientBuilder:httpclient4cj.HttpClientBuilder) {
        this.clientBuilder = clientBuilder
    }
    public func getClientBuilder(): HttpClientBuilder {
        return clientBuilder
    }
    public func createDefaultConfig():OtherHttpClientConfig {
        return defaultConfig()
    }
    public static func defaultConfig():OtherHttpClientConfig {
        return OtherHttpClientConfig(httpclient4cj.HttpClient.builder());
    }
}