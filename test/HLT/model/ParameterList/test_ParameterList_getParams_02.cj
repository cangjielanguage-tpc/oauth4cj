// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from encoding import base64.*
from std import collection.*
from oauth4cj import model.*
from oauth4cj import utils.*

@Test
public class TestParameterListV002{
    //非空列表,经过改变后，也随之变化
    @TestCase
    func testGetParams02(): Unit {
        var map02=HashMap<String,String>([("key01","value01"),("key02","value02")])
        var pl03=ParameterList(map02)//非空表
        @Assert(pl03.size(),2)
        pl03.add("key03","value03")
        @Assert(pl03.size(),3)
        @Assert(pl03.getParams().size,3)
    }
}