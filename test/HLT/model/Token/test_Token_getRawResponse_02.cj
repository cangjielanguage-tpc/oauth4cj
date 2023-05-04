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
    //子类实例：public open class OAuth1Token <: Token
    @TestCase
    func testGetRawResponse02(): Unit {
        var oauth1token01=OAuth1Token()
        var oauth1token02=OAuth1Token()
        @Assert(oauth1token01.getRawResponse(),"")
        for (str in strValues) {
            oauth1token02=OAuth1Token(str,str,str)
            @Assert(oauth1token02.getRawResponse(),str)

        }
    }
}