// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from encoding import base64.*
from std import collection.*
from oauth4cj import model.*
from oauth4cj import utils.*

@Test
public class TestParameterListV001{
    //字符串角度
    @TestCase
    func testAdd04(): Unit {
        var map02=HashMap<String,String>([("key01","value01"),("key02","value02")])
        var pl03=ParameterList(map02)
        var sizeBefore=pl03.size()
        @Assert(sizeBefore,2)
        for (i in strValues){
            pl03.add(i,i)
        }
        @Assert(pl03.size(),sizeBefore+strValues.size)
    }
}