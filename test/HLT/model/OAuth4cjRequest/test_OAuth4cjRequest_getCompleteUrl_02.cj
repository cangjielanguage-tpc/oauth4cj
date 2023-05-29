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
    @TestCase
    func testOAuth4cjRequestgetCompleteUrl02(): Unit {
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        oauth4cjRequest.addHeader("header","header")
        oauth4cjRequest.addBodyParameter("BodyParameter","BodyParameter")
        oauth4cjRequest.addQuerystringParameter("QuerystringParameter","QuerystringParameter")
        @Assert(oauth4cjRequest.getCompleteUrl(),"https://www.baidu.com?QuerystringParameter=QuerystringParameter")
    }
}