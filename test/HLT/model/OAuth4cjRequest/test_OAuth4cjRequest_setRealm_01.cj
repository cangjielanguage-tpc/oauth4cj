// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from encoding import base64.*
from std import collection.*
from oauth4cj import model.*
from oauth4cj import utils.*
from std import io.*
@Test
public class TestOAuth4cjRequestV001{
    @TestCase
    func testOAuth4cjRequestsetRealm01(): Unit {
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        for (str in strValues){
            oauth4cjRequest.setRealm(str)
            @Assert(oauth4cjRequest.getRealm(),str)
        }
    }
}