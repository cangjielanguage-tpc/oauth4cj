// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from encoding import base64.*
from std import collection.*
from oauth4cj import model.*
from oauth4cj import utils.*

@Test
public class TestOAuth2AccessTokenV001{
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

            for (int32Value in int32Values){
                oauth2accesstoken03=OAuth2AccessToken(str,str,int32Value,str,str,str)
                @Assert(oauth2accesstoken03.getAccessToken(),str)
            }
        }
    }
}