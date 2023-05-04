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
    //本类实例
    @TestCase
    func testGetRawResponse01(): Unit {
        var token01=Token()
        var token02=Token()
        @Assert(token01.getRawResponse(),"")
        for (str in strValues) {
            token02=Token(str)
            @Assert(token02.getRawResponse(),str)
        }
    }
}