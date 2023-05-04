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
        多次设置，设置值为常见字符串类型
    ***/
    @TestCase
    func testPKCEsetCodeChallenge02(): Unit {
        var pkce=PKCE()
        for(str in strValues){
            pkce.setCodeChallenge(str)
            @Assert(pkce.getCodeChallenge(),str)
        }
    }
}