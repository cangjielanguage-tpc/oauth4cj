// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import builder.*

@Test
public class TestScopeBuilderB004{
    /***
        public func build(): String
        测试场景:构造器默认-空参
    ***/
    @TestCase
    func testScopeBuilderBuild01(): Unit {
        var scopeBuilder01=ScopeBuilder()
        var flag=1
        try{
            scopeBuilder01.build()
        }catch(e:IndexOutOfBoundsException){
            flag=0
        }
        @Assert(flag,0)
    }
}