// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
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
        初始化查询：url不带参数,url有效协议
    ***/
    @TestCase
    func testOAuth4cjRequestgetQueryStringParams01(): Unit {
        var urls=Array<String>(["http://www.baidu.com","ftp://www.baidu.com"])
        for (url in urls){
            var oauth4cjRequest=OAuth4cjRequest(Verb.GET,url)
            @Assert(oauth4cjRequest.getQueryStringParams().asFormUrlEncodedString(),"")
        }
    }
}