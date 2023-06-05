// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import builder.*

@Test
public class TestDefaultApi10aB004{
    /***
        public func isEmptyOAuthTokenParamIsRequired(): Bool
        测试场景:不复写,返回false
    ***/
    @TestCase
    func testDefaultApi10aIsEmptyOAuthTokenParamIsRequired01(): Unit {
        var subDefaultApi10a=SubDefaultApi10a()
        let isEmptyOAuthTokenParamIsRequired=subDefaultApi10a.isEmptyOAuthTokenParamIsRequired()
        @Assert(isEmptyOAuthTokenParamIsRequired,false)
    }
}
