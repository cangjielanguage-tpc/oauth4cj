// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from encoding import base64.*
from std import collection.*
from oauth4cj import model.*
from oauth4cj import utils.*

@Test
public class TestOAuth1AccessTokenV001{
    //调用源
    @TestCase
    func testGetTokenSecret01(): Unit {
        var oauth1accesstoken01=OAuth1AccessToken("123","123")
        var oauth1accesstoken02=OAuth1AccessToken("123","123")
        var oauth1accesstoken03=OAuth1AccessToken("123","123")
        for (str in strValues) {
            oauth1accesstoken01=OAuth1AccessToken(str,str,str)
            @Assert(oauth1accesstoken01.getTokenSecret(),str)

            oauth1accesstoken02=OAuth1AccessToken(str,str,str)
            @Assert(oauth1accesstoken02.getTokenSecret(),str)
        }
    }
}