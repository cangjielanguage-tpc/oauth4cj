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
    //asFormUrlEncodedString()结果不为空，url不包含'?',返回url+？+asFormUrlEncodedString()
    @TestCase
    func testAppendTo04(): Unit {
        var map02=HashMap<String,String>([("key01","value01"),("key02","value02"),("key03","")])
        var pl03=ParameterList(map02)//非空表
        var url="www.baidu.com"
        @Assert(pl03.appendTo(url),url+"?"+pl03.asFormUrlEncodedString())
    }
}