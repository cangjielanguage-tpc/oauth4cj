// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import builder.*
@Test
public class TestServiceBuilderB004{
    /***
        public func setUserAgent(userAgent: String): ServiceBuilder
        测试场景:字符串角度,只能验证正常调用，暂时无法验证结果，需要流程通过后从功能角度验证
    ***/
    @TestCase
    func testServiceBuilderSetApiKey01(): Unit {
        var serviceBuilder01=ServiceBuilder("abc")
        serviceBuilder01.setUserAgent("")
    }
}