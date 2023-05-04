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
        可允许设置的范围：
        1.UTF-8  ||  utf-8  ||  UTF8  || utf8
    ***/
    @TestCase
    func testOAuth4cjRequestsetCharset01(): Unit {
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        var charsets=Array<String>(["UTF-8","utf-8","UTF8","utf8"])
        for (charset in charsets){
            oauth4cjRequest.setCharset(charset)
            @Assert(oauth4cjRequest.getCharset(),charset)
        }
    }
}