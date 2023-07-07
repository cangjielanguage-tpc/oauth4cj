// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from std import collection.*
from oauth4cj import model.*
from oauth4cj import commons.*

@Test
public class TestParameterListB001{
    //非空parameterList，返回各个Parameter调用asUrlEncodedPair()之后的值，并将其用&链接起来:1000个
    @TestCase
    func testAsOauthBaseString03(): Unit {
        var map02=HashMap<String,String>([("key01","value01"),("key02","value02")])
        var pl03=ParameterList(map02)//非空表
        for (i in 0..1000){
            pl03.add("key-1000","value-1000")
        }
        @Assert(pl03.size(),1002)
        var re_exp=""
        for (i in map02){
            re_exp=re_exp+"&"+OAuthEncoder.encode(i[0]).concat("=").concat(OAuthEncoder.encode(i[1]))
        }
        for (i in 0..1000){
            re_exp=re_exp+"&"+OAuthEncoder.encode("key-1000").concat("=").concat(OAuthEncoder.encode("value-1000"))
        }
        re_exp=re_exp.substring(1)
        @Assert(pl03.asOauthBaseString(),OAuthEncoder.encode(re_exp))
    }
}