// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from std import collection.*
from oauth4cj import model.*

@Test
public class TestParameterListB001{
    //asFormUrlEncodedString()结果不为空，url包含'?','?'在尾部,中间,首部,返回url+&+asFormUrlEncodedString()
    @TestCase
    func testAppendTo03(): Unit {
        var map02=HashMap<String,String>([("key01","value01"),("key02","value02"),("key03","")])
        var pl03=ParameterList(map02)//非空表
        var url01="&www.baidu.com?"
        var url02="www.baidu.c?om&"
        var url03="?ww&w.baidu.com"
        @Assert(pl03.appendTo(url01),url01+"&"+pl03.asFormUrlEncodedString())
        @Assert(pl03.appendTo(url02),url02+"&"+pl03.asFormUrlEncodedString())
        @Assert(pl03.appendTo(url03),url03+"&"+pl03.asFormUrlEncodedString())
    }
}