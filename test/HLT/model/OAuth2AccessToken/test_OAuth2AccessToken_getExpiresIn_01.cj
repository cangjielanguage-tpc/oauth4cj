// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import model.*

@Test
public class TestOAuth2AccessTokenB001{
    //构造器传入,不传入
    @TestCase
    func testGetExpiresIn01(): Unit {
        var oauth2accesstoken01=OAuth2AccessToken("123")
        @Assert(oauth2accesstoken01.getExpiresIn(),Int32(0))

        var oauth2accesstoken02=OAuth2AccessToken("123","123")
        @Assert(oauth2accesstoken02.getExpiresIn(),Int32(0))

        var oauth2accesstoken03=OAuth2AccessToken("123")
        for (int32Value in int32Values){
            oauth2accesstoken03=OAuth2AccessToken("str","str",int32Value,"str","str","str")
            @Assert(oauth2accesstoken03.getExpiresIn(),int32Value)
        }
    }
}