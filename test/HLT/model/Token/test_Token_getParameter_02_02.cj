// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from encoding import base64.*
from std import collection.*
from oauth4cj import model.*
from oauth4cj import utils.*

@Test
public class TestTokenV001{
    //子类实例:public class OAuth1AccessToken <: OAuth1Token
    @TestCase
    func testGetParameter0202(): Unit {
        var oauth1accesstoken01=OAuth1AccessToken("123","123")
        var oauth1accesstoken02=OAuth1AccessToken("123","123","http://www.baidu.com?userName=fly&city=&old=128")
        @Assert(oauth1accesstoken01.getParameter("http://www.baidu.com?userName"),"")
        @Assert(oauth1accesstoken02.getParameter("http://www.baidu.com?userName"),"fly")
    }
}