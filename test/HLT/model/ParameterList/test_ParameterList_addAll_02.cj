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
    //非空列表新增,other为空或者非空
    @TestCase
    func testAddAll02(): Unit {
        var other01=ParameterList()//空表
        var map01=HashMap<String,String>()
        var other02=ParameterList(map01)//空表
        var map02=HashMap<String,String>([("key01","value01"),("key02","value02"),("key03","")])
        var other03=ParameterList(map02)//非空表

        var pl01=ParameterList(map02)
        var pl02=ParameterList(map02)
        var pl03=ParameterList(map02)
        var baseSize=pl01.size()
        pl01.addAll(other01)
        pl02.addAll(other02)
        pl03.addAll(other03)
        @Assert(pl01.size(),baseSize+other01.size())
        @Assert(pl02.size(),baseSize+other02.size())
        @Assert(pl03.size(),baseSize+other03.size())
    }
}