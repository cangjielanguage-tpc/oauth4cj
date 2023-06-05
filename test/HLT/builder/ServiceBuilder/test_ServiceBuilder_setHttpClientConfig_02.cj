// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import builder.*
from oauth4cj import httpclient.*

@Test
public class TestServiceBuilderB004{
    /***
        public func setHttpClientConfig(httpClientConfig: ?HttpClientConfig): ServiceBuilder
        测试场景:验证字符串是Option<HttpClientConfig>.Some
    ***/
    @TestCase
    func testServiceBuildersetHttpClientConfig01(): Unit {
        var serviceBuilder01=ServiceBuilder("abc")
        var config=Option<HttpClientConfig>.Some(SubHttpClientConfig.defaultConfig())
        var flag=1
        try{
            serviceBuilder01.setHttpClientConfig(config)
        }catch(e:IllegalArgumentException){
            flag=0
        }
        @Assert(flag,1)
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