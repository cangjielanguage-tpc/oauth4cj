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
    //queryString非空，不含&,含=(=前后是否有值，多个等号)
    @TestCase
    func testAddQuerystring05(): Unit {
        var map02=HashMap<String,String>([("key01","value01"),("key02","value02")])
        //=左侧无值
        var pl01=ParameterList(map02)//非空表
        var queryString01="=abc"
        pl01.addQuerystring(queryString01)
        @Assert(pl01.size(),map02.size+1)
        @Assert(pl01.contains(Parameter("","abc")),true)

        //=左右侧均有值
        var pl02=ParameterList(map02)//非空表
        var queryString02="ab=c"
        pl02.addQuerystring(queryString02)
        @Assert(pl02.size(),map02.size+1)
        @Assert(pl02.contains(Parameter("ab","c")),true)
        //=右侧无值
        var pl03=ParameterList(map02)//非空表
        var queryString03="abc="
        pl03.addQuerystring(queryString03)
        @Assert(pl03.size(),map02.size+1)
        @Assert(pl03.contains(Parameter("abc","")),true)
        //=右侧均无值
        var pl04=ParameterList(map02)//非空表
        var queryString04="="
        var exp_flag_04=0
        try{
            pl04.addQuerystring(queryString04)
        }catch(w:Exception){
            exp_flag_04=1
        }
        @Assert(exp_flag_04,1)

        //存在多个等号
        var pl05=ParameterList(map02)//非空表
        var queryString05="abc=bcd=cdv"
        pl05.addQuerystring(queryString05)
        @Assert(pl05.size(),map02.size+1)
        @Assert(pl05.contains(Parameter("abc","bcd")),true)//忽略了第二个等号之后的值

        //存在连续=
        var pl06=ParameterList(map02)//非空表
        var queryString06="=="
        var exp_flag_06=0
        try{
            pl06.addQuerystring(queryString06)
        }catch(w:Exception){
            exp_flag_06=1
        }
        @Assert(exp_flag_06,1)
    }
}