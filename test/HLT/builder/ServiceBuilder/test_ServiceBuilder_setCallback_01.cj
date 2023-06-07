// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import builder.*
@Test
public class TestServiceBuilderB004{
    /***
        public func setCallback(callback: String): ServiceBuilder
        测试场景:无设置逻辑,设置成功即可
    ***/
    @TestCase
    func testServiceBuilderSetCallback01(): Unit {
        var serviceBuilder01 = ServiceBuilderOAuth10a("abc")
        var subDefaultApi10a=SubDefaultApi10a()
        serviceBuilder01.setCallback("str")
        let oauth10aService=serviceBuilder01.build(subDefaultApi10a)
        @Assert(oauth10aService.getCallback(),"str")

        var serviceBuilder02=ServiceBuilderOAuth20("abc")
        var subDefaultApi20=SubDefaultApi20()
        subDefaultApi20.setCallback("str")
        let oAuth20Service=subDefaultApi20.build(subDefaultApi20)
        @Assert(oAuth20Service.getCallback(),"str")
    }
}