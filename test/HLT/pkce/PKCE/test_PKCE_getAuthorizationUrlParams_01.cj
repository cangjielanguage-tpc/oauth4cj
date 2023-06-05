// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from std import collection.*
from oauth4cj import pkce.*

@Test
public class TestPKCEB002{
    /***
        未设置:code_challenge和code_challenge_method均未设置
    ***/
    @TestCase
    func testPKCEgetAuthorizationUrlParams01(): Unit {
        var pkce=PKCE()
        var exp_re=HashMap<String, String>([("code_challenge",""),("code_challenge_method","S256")])
        @Assert(pkce.getAuthorizationUrlParams(),exp_re)
    }
}