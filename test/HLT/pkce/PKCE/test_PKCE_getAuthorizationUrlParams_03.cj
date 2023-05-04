// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from encoding import base64.*
from std import collection.*

from oauth4cj import pkce.*

@Test
public class TestPKCEV002{
    /***
        未设置:仅code_challenge_method未设置
    ***/
    @TestCase
    func testPKCEgetAuthorizationUrlParams03(): Unit {
        var pkce=PKCE()
        pkce.setCodeChallengeMethod(PKCECodeChallengeMethod.PLAIN)
        var exp_re=HashMap<String, String>([("code_challenge",""),("code_challenge_method","PLAIN")])
        @Assert(pkce.getAuthorizationUrlParams(),exp_re)
    }
}