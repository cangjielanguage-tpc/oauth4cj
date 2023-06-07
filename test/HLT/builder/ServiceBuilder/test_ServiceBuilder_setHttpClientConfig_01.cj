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
        测试场景:验证字符串是Option<HttpClientConfig>.None
    ***/
    @TestCase
    func testServiceBuildersetHttpClientConfig01(): Unit {
        var serviceBuilder01=ServiceBuilderOAuth10a("abc")
        var config=Option<HttpClientConfig>.None
        var flag=1
        try{
            serviceBuilder01.setHttpClientConfig(config)
        }catch(e:IllegalArgumentException){
            if(e.toString().contains("httpClientConfig can't be null")){
                flag=0
            }
        }
        @Assert(flag,0)

        var serviceBuilder02=ServiceBuilderOAuth20("abc")
        var flag02=1
        try{
            serviceBuilder02.setHttpClientConfig(config)
        }catch(e:IllegalArgumentException){
            if(e.toString().contains("httpClientConfig can't be null")){
                flag02=0
            }
        }
        @Assert(flag02,0)
    }
}