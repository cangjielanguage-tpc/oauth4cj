// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from std import collection.*
from oauth4cj import model.*

@Test
public class TestOAuth4cjRequestB001{
    /***
        从无到有，追加header
    ***/
    @TestCase
    func testOAuth4cjRequestaddHeader01(): Unit {
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        var exp_body=HashMap<String,String>()
        for (str in strValues){
            oauth4cjRequest.addBodyParameter(str,str)
            exp_body.put(str,str)
        }
        @Assert(oauth4cjRequest.getBodyParams().asFormUrlEncodedString(),ParameterList(exp_body).asFormUrlEncodedString())
    }
}