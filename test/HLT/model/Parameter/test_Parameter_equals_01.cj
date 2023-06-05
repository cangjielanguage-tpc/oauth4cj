// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import model.*

@Test
public class TestParameterB001{
    //相等
    @TestCase
    func testEquals01(): Unit {
        var p01=Parameter("key01","value01")
        var p02=Parameter("key01","value01")
        var p03=Parameter("","")
        var p04=Parameter("","")
        @Assert(p01==p02,true)
        @Assert(p03==p04,true)
    }
}