// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from encoding import base64.*
from std import collection.*

from oauth4cj import pkce.*

@Test
public class TestPKCEV002{
        /***
            单次设置
        ***/
    @TestCase
    func testPKCEsetCodeChallengeMethod01(): Unit {
        var pkce=PKCE()
        pkce.setCodeChallengeMethod(PKCECodeChallengeMethod.PLAIN)
        @Assert(pkce.getCodeChallengeMethod().toString(),PKCECodeChallengeMethod.PLAIN.toString())
        pkce=PKCE()
        pkce.setCodeChallengeMethod(PKCECodeChallengeMethod.S256)
        @Assert(pkce.getCodeChallengeMethod().toString(),PKCECodeChallengeMethod.S256.toString())
    }
}