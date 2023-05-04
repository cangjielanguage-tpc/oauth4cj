// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from encoding import base64.*
from std import collection.*
from oauth4cj import model.*
from oauth4cj import utils.*

@Test
public class TestParameterV001{
    //不等
    @TestCase
    func testCompareTo02(): Unit {
        var p01=Parameter("key01","value01")
        var p02=Parameter("key01","value02")
        var p03=Parameter("key02","value02")
        var p04=Parameter("key02","")

        @Assert(p01.compareTo(p02),Ordering.LT)
        @Assert(p02.compareTo(p01),Ordering.GT)
        @Assert(p02.compareTo(p03),Ordering.LT)
        @Assert(p03.compareTo(p02),Ordering.GT)
        @Assert(p01.compareTo(p03),Ordering.LT)
        @Assert(p03.compareTo(p01),Ordering.GT)

        @Assert(p04.compareTo(p03),Ordering.LT)
        @Assert(p03.compareTo(p04),Ordering.GT)

    }
}