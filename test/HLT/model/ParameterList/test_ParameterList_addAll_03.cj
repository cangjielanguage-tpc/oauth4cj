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
    //多次新增达到1000次
    @TestCase
    func testAddAll03(): Unit {
        var map02=HashMap<String,String>([("key01","value01"),("key02","value02"),("key03","")])
        var other03=ParameterList(map02)//非空表
        var pl03=ParameterList(map02)
        var baseSize=pl03.size()
        for (i in 0..1000){
            pl03.addAll(other03)
        }
        @Assert(pl03.size(),baseSize+other03.size()*1000)
    }
}