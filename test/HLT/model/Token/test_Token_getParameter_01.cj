// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from encoding import base64.*
from std import collection.*
from oauth4cj import model.*
from oauth4cj import utils.*

@Test
public class TestTokenV001{
    //本类实例: 无&,且无参数,http://www.baidu.com?
    @TestCase
    func testGetParameter01(): Unit {
        var token01=Token()
        var token02=Token("")
        var token03=Token("http://www.baidu.com?")
        @Assert(token01.getParameter(""),"")
        @Assert(token02.getParameter(""),"")
        @Assert(token03.getParameter(""),"")
    }
}