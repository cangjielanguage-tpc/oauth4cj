// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import builder.*
from std import collection.*
@Test
public class TestScopeBuilderB004{
    /***
        public func withScope(scope: String): ScopeBuilder
        public func build(): String
        测试场景:加入已存在字符串scope
    ***/
    @TestCase
    func testScopeBuilderWithScope0102(): Unit {
        let str="scope01"
        var scopeBuilder01=ScopeBuilder()
        scopeBuilder01.withScope(str)
        scopeBuilder01.withScope(str)
        @Assert(scopeBuilder01.build(),str)

        var scopeBuilder02=ScopeBuilder("scope01")
        scopeBuilder02.withScope(str)
        @Assert(scopeBuilder02.build(),str)

        var scopeBuilder03=ScopeBuilder(Array<String>(["scope01"]))
        scopeBuilder03.withScope(str)
        @Assert(scopeBuilder03.build(),str)

        var scopeBuilder04=ScopeBuilder(ArrayList<String>(["scope01"]))
        scopeBuilder04.withScope(str)
        @Assert(scopeBuilder04.build(),str)
    }
}