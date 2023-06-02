// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import model.*

@Test
public class TestOAuth2AccessTokenB001{
    /***
       测试项：(oauth2accesstoken02as OAuth2AccessToken)  不是  Option<OAuth2AccessToken>.None
       测试场景： object是OAuth2AccessToken的实例对象，与其他比较
    ***/
    @TestCase
    func testEquals04(): Unit {
        var oauth2accesstoken01=OAuth2AccessToken("123")
        var oauth2accesstoken02=OAuth2AccessToken("345")
        var oauth2accesstoken03=OAuth2AccessToken("123","123")
        var oauth2accesstoken04=OAuth2AccessToken("345","345")
        var oauth2accesstoken05=OAuth2AccessToken("123","123",Int32(0),"123","123","123")
        var oauth2accesstoken06=OAuth2AccessToken("345","345",Int32(0),"345","345","345")
        @Assert(oauth2accesstoken01.equals(oauth2accesstoken02),false)
        @Assert(oauth2accesstoken01.equals(oauth2accesstoken03),true)
        @Assert(oauth2accesstoken01.equals(oauth2accesstoken05),false)
        @Assert(oauth2accesstoken04.equals(oauth2accesstoken01),false)
        @Assert(oauth2accesstoken06.equals(oauth2accesstoken01),false)
        @Assert(oauth2accesstoken02.equals(oauth2accesstoken01),false)
    }
}
