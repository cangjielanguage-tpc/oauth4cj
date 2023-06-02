// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import builder.*

@Test
public class TestServiceBuilderB004{
    /***
        public func setApiSecret(apiKey: String): ServiceBuilder
        测试场景:验证字符串是否为空-否
    ***/
    @TestCase
    func testServiceBuildersetApiSecret01(): Unit {
        var serviceBuilder01=ServiceBuilder("abc")
        var subDefaultApi10a=SubDefaultApi10a()
        serviceBuilder01.setApiSecret("str")
        let oAuth10aService=serviceBuilder01.build(subDefaultApi10a)
        @Assert(oAuth10aService.getApiSecret(),"str")
    }
}