// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import model.*

@Test
public class TestOAuth2AccessTokenB001{
    //构造器不同，均能成功获取
    @TestCase
    func testGetAccessToken01(): Unit {
        var oauth2accesstoken01=OAuth2AccessToken("123")
        var oauth2accesstoken02=OAuth2AccessToken("123")
        var oauth2accesstoken03=OAuth2AccessToken("123")
        for (str in strValues) {
            oauth2accesstoken01=OAuth2AccessToken(str)
            @Assert(oauth2accesstoken01.getAccessToken(),str)

            oauth2accesstoken02=OAuth2AccessToken(str,str)
            @Assert(oauth2accesstoken02.getAccessToken(),str)

            oauth2accesstoken03=OAuth2AccessToken(str,str,Int32(0),str,str,str)
            @Assert(oauth2accesstoken03.getAccessToken(),str)
        }
    }
}