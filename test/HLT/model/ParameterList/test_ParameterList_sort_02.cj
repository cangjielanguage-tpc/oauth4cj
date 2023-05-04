// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from encoding import base64.*
from std import collection.*
from oauth4cj import model.*
from oauth4cj import utils.*

@Test
public class TestParameterListV002{
    //非空列表,经过改变后，也随之变化
    @TestCase
    func testSort02(): Unit {
        var map01=HashMap<String,String>([("key01","value01"),("key02","value02")])
        var pl01=ParameterList(map01)//非空表
        pl01.add("key03","value03")
        pl01.add("","value03")
        pl01.add("key03","")
        pl01.add("key04","")
        var exp=ArrayList<Parameter>([Parameter("","value03"),Parameter("key01","value01"),Parameter("key02","value02"),Parameter("key03",""),Parameter("key03","value03"),Parameter("key04","")])
        var s_pl01=pl01.sort().getParams()
        var flag=1
        for (index in 0..s_pl01.size){
            flag=1
            if(s_pl01[index]==exp[index]){
                flag=0
            }
            @Assert(flag,0)
        }
    }
}