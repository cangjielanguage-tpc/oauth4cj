// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from encoding import base64.*
from std import collection.*
from oauth4cj import model.*
from oauth4cj import utils.*

@Test
public class TestParameterV001{
    //单次设置
    @TestCase
    func testasUrlEncodedPair01(): Unit {
        var oa01=OAuth2Authorization()
        @Assert(oa01.getState(),"")
    }
}