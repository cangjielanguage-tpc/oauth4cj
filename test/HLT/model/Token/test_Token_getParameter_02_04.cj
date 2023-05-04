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
    //子类实例:public class OAuth1RequestToken <: OAuth1Token
    @TestCase
    func testGetParameter0203(): Unit {
        var oauth2accesstoken01=OAuth2AccessToken("123")
        var oauth2accesstoken02=OAuth2AccessToken("123","http://www.baidu.com?userName=fly&city=&old=128")
        var oauth2accesstoken03=OAuth2AccessToken("123","123",Int32(123),"123","123","http://www.baidu.com?userName=fly&city=&old=128")
        @Assert(oauth2accesstoken01.getParameter("http://www.baidu.com?userName"),"")
        @Assert(oauth2accesstoken02.getParameter("http://www.baidu.com?userName"),"fly")
        @Assert(oauth2accesstoken03.getParameter("http://www.baidu.com?userName"),"fly")
    }
}