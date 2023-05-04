// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from encoding import base64.*
from std import collection.*
from oauth4cj import model.*
from oauth4cj import utils.*

@Test
public class TestOAuth1TokenV001{
    //调用源
    @TestCase
    func testGetTokenSecret01(): Unit {
        var oauth1token01=OAuth1Token()
        @Assert(oauth1token01.getTokenSecret(),"")
        var oauth1token02=OAuth1Token()
        for (str in strValues) {
            oauth1token02=OAuth1Token(str,str,str)
            @Assert(oauth1token02.getTokenSecret(),str)
        }
    }
}