// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from encoding import base64.*
from std import collection.*

from oauth4cj import pkce.*

@Test
public class TestPKCECodeChallengeMethodV002{
    /***
        调用源PKCECodeChallengeMethod.PLAIN
    ***/
    @TestCase
    func testPKCECodeChallengeMethodTransform2CodeChallenge02(): Unit {
        var codeChallengeMethod_PLAIN=PKCECodeChallengeMethod.PLAIN
        var re=""
        var exp_re=""
        for (str in strValues){
            re=codeChallengeMethod_PLAIN.transform2CodeChallenge(str)
            @Assert(re,str)
        }
    }
}