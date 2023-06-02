// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import builder.*
@Test
public class TestServiceBuilderB004{
    /***
        public func setDefaultScope(defaultScope: String): ServiceBuilderOAuth20
        测试场景:验证字符串是否为空-否
    ***/
    @TestCase
    func testServiceBuildersetDefaultScope0102(): Unit {
        var serviceBuilder01=ServiceBuilder("abc")
        var subDefaultApi10a=SubDefaultApi10a()
        var re=serviceBuilder01.setDefaultScope("str")
        @Assert(re is ServiceBuilderOAuth20,true)
    }
}