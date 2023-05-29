// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from encoding import base64.*
from std import collection.*

from oauth4cj import pkce.*

@Test
public class TestPKCECodeChallengeMethodV002{
    @TestCase
    func testPKCECodeChallengeMethodToString01(): Unit {
        @Assert(PKCECodeChallengeMethod.S256.toString(),"S256")
        @Assert(PKCECodeChallengeMethod.PLAIN.toString(),"PLAIN")
    }
}