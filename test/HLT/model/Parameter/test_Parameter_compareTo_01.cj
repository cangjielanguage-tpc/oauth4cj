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
    //相等
    @TestCase
    func testCompareTo01(): Unit {
        var p01=Parameter("key01","value01")
        var p02=Parameter("key01","value01")
        var p03=Parameter("","")
        var p04=Parameter("","")
        @Assert(p01.compareTo(p02),Ordering.EQ)
        @Assert(p03.compareTo(p04),Ordering.EQ)
    }
}