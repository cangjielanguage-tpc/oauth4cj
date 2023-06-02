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
    //空列表新增
    @TestCase
    func testAdd01(): Unit {
        var pl01=ParameterList()//空表
        var map01=HashMap<String,String>()
        var pl02=ParameterList(map01)//空表
        @Assert(pl01.size(),0)
        @Assert(pl02.size(),0)
        pl01.add("key03","value03")
        pl02.add("key03","value03")
        @Assert(pl01.size(),1)
        @Assert(pl02.size(),1)
    }
}