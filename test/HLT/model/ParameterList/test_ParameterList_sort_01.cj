// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from std import collection.*
from oauth4cj import model.*

@Test
public class TestParameterListB001{
    //空列表，经过改变后，也随之变化
    @TestCase
    func testSort01(): Unit {
        var pl01=ParameterList()//空表
        var map01=HashMap<String,String>()
        var pl02=ParameterList(map01)//空表
        var s01_pl01=pl01.sort()
        var s01_pl02=pl01.sort()
        @Assert(s01_pl01.getParams().size,0)
        @Assert(s01_pl01.getParams().size,0)
        pl01.add("key03","value04")
        pl02.add("key03","value04")
        var s02_pl01=pl01.sort()
        var s02_pl02=pl01.sort()
        @Assert(s02_pl01.getParams().size,1)
        @Assert(s02_pl01.getParams().size,1)
        pl01.add("key03","value03")
        pl02.add("key03","value03")
        pl01.add("key04","value03")
        pl02.add("key04","value03")
        pl01.add("key03","value03")
        pl02.add("key03","value03")
        var exp=ArrayList<Parameter>([Parameter("key03","value03"),Parameter("key03","value03"),Parameter("key03","value04"),Parameter("key04","value03")])
        var s03_pl01=pl01.sort().getParams()
        var s03_pl02=pl02.sort().getParams()
        var flag=1
        for (index in 0..s03_pl01.size){
            flag=1
            if(s03_pl01[index]==exp[index] && s03_pl02[index]==exp[index]){
                flag=0
            }
            @Assert(flag,0)
        }

    }
}