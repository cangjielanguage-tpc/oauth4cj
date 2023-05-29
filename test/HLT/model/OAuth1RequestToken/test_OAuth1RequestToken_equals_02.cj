// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from encoding import base64.*
from std import collection.*
from oauth4cj import model.*
from oauth4cj import utils.*

@Test
public class TestOAuth1RequestTokenV001{
    /***
       测试项：(obj as OAuth1RequestToken)  是  Option<OAuth1RequestToken>.None
       测试场景： object是不相关类的实例对象
    ***/
    @TestCase
    func testEquals02(): Unit {
        var otherClass=A()
        var oauth1requesttoken01=OAuth1RequestToken("123","123")
        var oauth1requesttoken02=OAuth1RequestToken("123","123")
        var oauth1requesttoken03=OAuth1RequestToken("123","123")
        for (str in strValues) {
            oauth1requesttoken01=OAuth1RequestToken(str,str)
            @Assert(oauth1requesttoken01.equals(otherClass),false)

            oauth1requesttoken02=OAuth1RequestToken(str,str,str)
            @Assert(oauth1requesttoken02.equals(otherClass),false)

            for (boolValue in boolValues){
                oauth1requesttoken03=OAuth1RequestToken(str,str,boolValue,str)
                @Assert(oauth1requesttoken03.equals(otherClass),false)
            }
        }
    }
}
public class A{}