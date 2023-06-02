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
    //空的parameterList,返回空字符串
    @TestCase
    func testAsOauthBaseString01(): Unit {
        var pl01=ParameterList()//空表
        var map01=HashMap<String,String>()
        var pl02=ParameterList(map01)//空表
        @Assert(pl01.asOauthBaseString(),"")
        @Assert(pl02.asOauthBaseString(),"")
    }
}