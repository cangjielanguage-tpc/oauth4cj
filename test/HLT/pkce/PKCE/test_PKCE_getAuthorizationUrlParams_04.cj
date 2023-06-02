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
        设置:code_challenge和code_challenge_method均设置
    ***/
    @TestCase
    func testPKCEgetAuthorizationUrlParams04(): Unit {
        var pkce=PKCE()
        pkce.setCodeChallenge("codeChallenge")
        pkce.setCodeChallengeMethod(PKCECodeChallengeMethod.PLAIN)
        var exp_re=HashMap<String, String>([("code_challenge","codeChallenge"),("code_challenge_method","PLAIN")])
        @Assert(pkce.getAuthorizationUrlParams(),exp_re)
    }
}