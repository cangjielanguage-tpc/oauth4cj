// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from encoding import base64.*
from std import collection.*
from oauth4cj import model.*
from oauth4cj import utils.*

@Test
public class TestParameterListV001{
    //包含，返回true
    @TestCase
    func testContains01(): Unit {
        var map02=HashMap<String,String>([("key01","value01"),("key02","value02"),("key01","value03")])
        //=左侧无值
        var pl01=ParameterList(map02)//非空表
        pl01.add("key03","")
        pl01.add("","value03")
        @Assert(pl01.size(),map02.size+2)
        @Assert(pl01.contains(Parameter("key01","value01")),false)
        @Assert(pl01.contains(Parameter("key01","value03")),true)
        @Assert(pl01.contains(Parameter("key03","")),true)
        @Assert(pl01.contains(Parameter("","value03")),true)
    }
}