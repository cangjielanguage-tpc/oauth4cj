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
    //字符串角度
    @TestCase
    func testGetValue01(): Unit {
        var p01=Parameter("key01","value01")
        for (i in strValues){
            p01=Parameter(i,i)
            @Assert(p01.getValue(),i)
        }
    }
}