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
        var oauth1requesttoken01=OAuth1RequestToken("123","123")
        var oauth1requesttoken02=OAuth1RequestToken("123","123","http://www.baidu.com?userName=fly&city=&old=128")
        var oauth1requesttoken03=OAuth1RequestToken("123","123",true,"http://www.baidu.com?userName=fly&city=&old=128")

        @Assert(oauth1requesttoken01.getParameter("http://www.baidu.com?userName"),"")
        @Assert(oauth1requesttoken02.getParameter("http://www.baidu.com?userName"),"fly")
        @Assert(oauth1requesttoken03.getParameter("http://www.baidu.com?userName"),"fly")

    }
}