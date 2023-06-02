// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import builder.*

@Test
public class TestServiceBuilderB004{
    /***
        public func setResponseType(responseType: String): ServiceBuilderOAuth20
        测试场景:验证字符串是否为空-否
    ***/
    @TestCase
    func testServiceBuildersetResponseType02(): Unit {
        var serviceBuilder01=ServiceBuilder("abc")
        var subDefaultApi20=SubDefaultApi20()
        var str="andfsopfks"
        serviceBuilder01.setResponseType(str)
        let OAuth20Service=serviceBuilder01.build(subDefaultApi20)
        @Assert(OAuth20Service.getResponseType(),str)
    }
}