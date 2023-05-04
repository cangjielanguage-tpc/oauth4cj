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
    /***
        字符串角度验证
    ***/
    @TestCase
    func testOAuth4cjRequestgetUrl01(): Unit {
        for (str in strValues){
            var oauth4cjRequest=OAuth4cjRequest(Verb.GET,str)
            @Assert(oauth4cjRequest.getUrl(),str)
        }
    }
}