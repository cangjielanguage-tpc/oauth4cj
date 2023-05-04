// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from encoding import base64.*
from std import collection.*
from oauth4cj import model.*
from oauth4cj import utils.*
from std import io.*
@Test
public class TestOAuth4cjRequestV001{
    /***
        3.其他:删除？之后的所有,包括?
    ***/
    @TestCase
    func testOAuth4cjRequestgetUrl03(): Unit {
        var urls=Array<String>(["http://127.0.0.0:443","https://127.0.0.0:80","http://wwe.kk:8080?sh=34&uaer=123"])
        var exp_urls=Array<String>(["http://127.0.0.0","https://127.0.0.0","http://wwe.kk:8080"])
        for (index in 0..urls.size){
            var oauth4cjRequest=OAuth4cjRequest(Verb.GET,exp_urls[index])
            @Assert(oauth4cjRequest.getSanitizedUrl(),exp_urls[index])
        }
    }
}