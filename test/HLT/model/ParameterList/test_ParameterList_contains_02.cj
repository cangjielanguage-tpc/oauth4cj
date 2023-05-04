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
    //不包含,  返回false
    @TestCase
    func testContains02(): Unit {
        var map02=HashMap<String,String>([("key01","value01"),("key02","value02")])
        var pl01=ParameterList(map02)//非空表
        @Assert(pl01.contains(Parameter("","")),false)
        @Assert(pl01.contains(Parameter("key04","")),false)
        @Assert(pl01.contains(Parameter("key01","value01")),true)
        @Assert(pl01.contains(Parameter("key02","value01")),false)
    }
}