// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import model.*

@Test
public class TestOAuth1AccessTokenB001{
    /***
       测试项：(obj as OAuth1AccessToken)  是  Option<OAuth1AccessToken>.None
       测试场景： object是不相关类的实例对象
    ***/
    @TestCase
    func testEquals02(): Unit {
        var otherClass=A()
        var oauth1accesstoken01=OAuth1AccessToken("123","123")
        var oauth1accesstoken02=OAuth1AccessToken("123","123")

        oauth1accesstoken01=OAuth1AccessToken("str","str")
        @Assert(oauth1accesstoken01.equals(otherClass),false)

        oauth1accesstoken02=OAuth1AccessToken("str","str","str")
        @Assert(oauth1accesstoken02.equals(otherClass),false)
    }
}
public class A{}