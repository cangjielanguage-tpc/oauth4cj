// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj

@Test
public class TestOkHttpProviderB008{
    /***
        public func createClient(config: HttpClientConfig): Option<HttpClient>
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
    var okhttpClientBuilder=OkHttpClient.builder()
    var otherHttpClientConfig=OtherHttpClientConfig(okhttpClientBuilder)
    return otherHttpClientConfig
}

public class OtherHttpClientConfig <: HttpClientConfig {
    private var clientBuilder=OkHttpClient.builder()
    public init(clientBuilder:okhttp.OkHttpClientBuilder) {
        this.clientBuilder = clientBuilder
    }
    public func getClientBuilder(): OkHttpClientBuilder {
        return clientBuilder
    }
    public func createDefaultConfig():OtherHttpClientConfig {
        return defaultConfig()
    }
    public static func defaultConfig():OtherHttpClientConfig {
        return OtherHttpClientConfig(OkHttpClient.builder());
    }
}