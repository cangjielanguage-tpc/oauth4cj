// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import pkce.*

@Test
public class TestPKCEServiceB002{
    @TestCase
    func testPKCEServicedefaultInstance01(): Unit {
        var pkceService=PKCEService.defaultInstance()
        var pkce01=pkceService.generatePKCE()
        @Assert(pkce01 is PKCE,true)
    }
}