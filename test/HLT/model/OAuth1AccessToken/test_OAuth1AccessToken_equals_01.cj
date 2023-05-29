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
    /***
       测试项：(obj as OAuth1AccessToken)  是  Option<OAuth1RequestToken>.None
       测试场景： object是OAuth1AccessToken的父类型的实例对象:public class OAuth1RequestToken <: OAuth1Token
    ***/
    @TestCase
    func testEquals01(): Unit {
        var oauth1token01=OAuth1Token()
        var oauth1accesstoken01=OAuth1AccessToken("123","123")
        var oauth1accesstoken02=OAuth1AccessToken("123","123")

        for (str in strValues) {
            oauth1accesstoken01=OAuth1AccessToken(str,str)
            @Assert(oauth1accesstoken01.equals(oauth1token01),false)

            oauth1accesstoken02=OAuth1AccessToken(str,str,str)
            @Assert(oauth1accesstoken02.equals(oauth1token01),false)
        }
    }
}