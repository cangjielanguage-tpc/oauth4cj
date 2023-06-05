// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import builder.*

@Test
public class TestDefaultApi10aB004{
    /***
        public func getRequestTokenEndpoint(): String
        测试场景:返回子类实现
    ***/
    @TestCase
    func testDefaultApi10aGetRequestTokenEndpoint01(): Unit {
        var subDefaultApi10a=SubDefaultApi10a()
        let requestTokenEndpoint=subDefaultApi10a.getRequestTokenEndpoint()
        @Assert(requestTokenEndpoint,"requestTokenEndpoint_DefaultApi10a")
    }
}
