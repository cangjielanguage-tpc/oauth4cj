// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import builder.*

@Test
public class TestServiceBuilderB004{
    /***
        public func build(api: DefaultApi10a): OAuth10aService
        测试场景:验证返回确认是OAuth10aService
    ***/
    @TestCase
    func testServiceBuilderBuild0101(): Unit {
        var serviceBuilder=ServiceBuilderOAuth10a("abc")
        var subDefaultApi10a=SubDefaultApi10a()
        let oauth10aService=serviceBuilder.build(subDefaultApi10a)
       // @Assert(oauth10aService.getVersion(),"1.0")
        @Assert(oauth10aService is OAuth10aService,true)
    }
}