// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestServiceBuilderB004{
    /***
        public func setHttpClientConfig(httpClientConfig: ?HttpClientConfig): ServiceBuilder
        测试场景:验证字符串是Option<HttpClientConfig>.Some
    ***/
    @TestCase
    func testServiceBuildersetHttpClientConfig01(): Unit {
        var serviceBuilder01=ServiceBuilderOAuth10a("abc")
        var config=Option<HttpClientConfig>.Some(SubHttpClientConfig.defaultConfig())
        var flag=1
        try{
            serviceBuilder01.setHttpClientConfig(config)
        }catch(e:IllegalArgumentException){
            flag=0
        }
        @Assert(flag,1)

        var serviceBuilder02=ServiceBuilderOAuth20("abc")
        var flag02=1
        try{
            serviceBuilder02.setHttpClientConfig(config)
        }catch(e:IllegalArgumentException){
            flag02=0
        }
        @Assert(flag02,1)
    }
}
public class SubHttpClientConfig <:HttpClientConfig{
    public func createDefaultConfig():SubHttpClientConfig{
        return defaultConfig()
    }
    public static func defaultConfig():SubHttpClientConfig {
        return SubHttpClientConfig()
    }
}