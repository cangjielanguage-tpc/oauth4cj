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
    func testGetParameter02(): Unit {
        var oauth1token01=OAuth1Token()
        var oauth1token02=OAuth1Token("123","123","http://www.baidu.com?userName=fly&city=&old=128")
        @Assert(oauth1token01.getParameter("http://www.baidu.com?userName"),"")
        @Assert(oauth1token02.getParameter("http://www.baidu.com?userName"),"fly")
    }
}