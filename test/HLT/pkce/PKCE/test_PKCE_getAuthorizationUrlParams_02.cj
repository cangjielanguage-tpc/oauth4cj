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
        未设置:仅code_challenge未设置
    ***/
    @TestCase
    func testPKCEgetAuthorizationUrlParams02(): Unit {
        var pkce=PKCE()
        pkce.setCodeChallenge("codeChallenge")
        var exp_re=HashMap<String, String>([("code_challenge","codeChallenge"),("code_challenge_method","S256")])
        @Assert(pkce.getAuthorizationUrlParams(),exp_re)
    }
}