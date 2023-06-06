// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import util.*
@Test
public class TestServiceBuilderB004{
    /***
        public func setDefaultScope(scopeBuilder: ScopeBuilder): ServiceBuilderOAuth20
        测试场景:验证字符串是否为空-否
    ***/
    @TestCase
    func testServiceBuildersetDefaultScope0202(): Unit {
        var scopeBuilder=ScopeBuilder("abc")
        var serviceBuilder=ServiceBuilderOAuth20("abc")
        var re=serviceBuilder.setDefaultScope(scopeBuilder)
        @Assert(re is ServiceBuilderOAuth20,true)
    }
}