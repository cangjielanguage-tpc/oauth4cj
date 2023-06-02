// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import model.*

@Test
public class TestParameterB001{
    //字符串角度
    @TestCase
    func testGetKey01(): Unit {
        var p01=Parameter("key01","value01")
        for (i in strValues){
            p01=Parameter(i,i)
            @Assert(p01.getKey(),i)
        }
    }
}