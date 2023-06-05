// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import httpclient.*
from oauth4cj import builder.*

@Test
public class TestServiceBuilderB004{
    /***
        public func setHttpClient(httpClient: ?HttpClient): ServiceBuilder
        测试场景:验证字符串是Option<HttpClient>.None
    ***/
    @TestCase
    func testServiceBuildersetHttpClient01(): Unit {
        var serviceBuilder01=ServiceBuilder("abc")
        var httpclient=Option<HttpClient>.None
        serviceBuilder01.setHttpClient(httpclient)
        //结果暂时验证不了，待OAuthService类交付
    }
}