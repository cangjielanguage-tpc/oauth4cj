// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from std import collection.*
from oauth4cj import model.*

@Test
public class TestParameterListB001{
    //queryString非空，含&(首位，中间，尾部),不含=
    @TestCase
    func testAddQuerystring02(): Unit {
        var map02=HashMap<String,String>([("key01","value01"),("key02","value02")])
        //含&--首位
        var pl01=ParameterList(map02)
        var queryString01="&abc"
        pl01.addQuerystring(queryString01)
        @Assert(pl01.size(),map02.size+2)
        @Assert(pl01.contains(Parameter("abc","")),true)
        @Assert(pl01.contains(Parameter("","")),true)
        //含&--中间
        var pl02=ParameterList(map02)//非空表
        var queryString02="a&bc"
        pl02.addQuerystring(queryString02)
        @Assert(pl02.size(),map02.size+2)
        @Assert(pl02.contains(Parameter("a","")),true)
        @Assert(pl02.contains(Parameter("bc","")),true)
        //含&--尾部
        var pl03=ParameterList(map02)//非空表
        var queryString03="abc&"
        pl03.addQuerystring(queryString03)
        @Assert(pl03.size(),map02.size+1)
        @Assert(pl03.contains(Parameter("abc","")),true)
        @Assert(pl03.contains(Parameter("","")),false)
    }
}