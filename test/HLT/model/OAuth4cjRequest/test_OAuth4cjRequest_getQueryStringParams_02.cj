// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from encoding import base64.*
from std import collection.*
from oauth4cj import model.*
from oauth4cj import utils.*
from oauth4cj import exceptions.*
from std import io.*
@Test
public class TestOAuth4cjRequestV001{
    /***
        初始化查询：url带参数
    ***/
    @TestCase
    func testOAuth4cjRequestgetQueryStringParams01(): Unit {
        var exp_body=HashMap<String,String>([("uaser","name"),("old","23")])
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com?uaser=name&old=23")
        @Assert(oauth4cjRequest.getQueryStringParams().asFormUrlEncodedString(),ParameterList(exp_body).asFormUrlEncodedString())
    }
}