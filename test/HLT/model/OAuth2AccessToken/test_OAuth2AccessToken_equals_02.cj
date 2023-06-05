// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import model.*

@Test
public class TestOAuth2AccessTokenB001{
    /***
       测试项：(obj as OAuth2AccessToken)  是  Option<OAuth2AccessToken>.None
       测试场景： object是不相关类的实例对象
    ***/
    @TestCase
    func testEquals02(): Unit {
        var otherClass=A()
        var oauth2accesstoken01=OAuth2AccessToken("123")
        @Assert(oauth2accesstoken01.equals(otherClass),false)

        var oauth2accesstoken02=OAuth2AccessToken("123","123")
        @Assert(oauth2accesstoken02.equals(otherClass),false)

        var oauth2accesstoken03=OAuth2AccessToken("123","123",Int32(0),"123","123","123")
        @Assert(oauth2accesstoken03.equals(otherClass),false)
    }
}
public class A{}