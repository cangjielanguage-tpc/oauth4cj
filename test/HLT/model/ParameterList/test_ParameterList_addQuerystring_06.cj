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
    //queryString非空，连续新增
    @TestCase
    func testAddQuerystring06(): Unit {
        var map02=HashMap<String,String>([("key01","value01"),("key02","value02")])
        //=左侧无值
        var pl01=ParameterList(map02)//非空表
        var queryString01="=a&bc&c=1"
        var queryString02="a&bd=c"
        var queryString03="b=c"
        pl01.addQuerystring(queryString01)
        pl01.addQuerystring(queryString02)
        pl01.addQuerystring(queryString03)
        @Assert(pl01.size(),map02.size+3+2+1)
        @Assert(pl01.contains(Parameter("","a")),true)
        @Assert(pl01.contains(Parameter("bc","")),true)
        @Assert(pl01.contains(Parameter("c","1")),true)
        @Assert(pl01.contains(Parameter("a","")),true)
        @Assert(pl01.contains(Parameter("bd","c")),true)
        @Assert(pl01.contains(Parameter("b","c")),true)
    }
}