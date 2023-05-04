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
    //asFormUrlEncodedString()结果为空，url不包含'?'和 '&'返回入参url
    @TestCase
    func testAppendTo01(): Unit {
        var pl01=ParameterList()//空表
        var map01=HashMap<String,String>()
        var pl02=ParameterList(map01)//空表
        var url="www.baidu.com"
        @Assert(pl01.appendTo(url),url)
        @Assert(pl02.appendTo(url),url)
    }
}