// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from encoding import base64.*
from std import collection.*

from oauth4cj import pkce.*

@Test
public class TestPKCEServiceV002{
    /***
        入参数组长度10000
    ***/
    @TestCase
    func testPKCEServicegeneratePKCEByArray02(): Unit {
        var pkceService01=PKCEService.defaultInstance()
        var pkceService02=PKCEService()
        var pkceService03=PKCEService(32)

        var arr1=getStringByLength(10000).toUtf8Array()
        var pkce01=pkceService01.generatePKCE(arr1)
        var pkce02=pkceService02.generatePKCE(arr1)
        var pkce03=pkceService03.generatePKCE(arr1)
        @Assert(pkce01.getCodeChallenge(),pkce02.getCodeChallenge())
        @Assert(pkce01.getCodeChallenge(),pkce03.getCodeChallenge())
    }
}