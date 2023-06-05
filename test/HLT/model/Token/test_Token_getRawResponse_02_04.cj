// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import model.*

@Test
public class TestTokenB001{
    //子类实例：public class OAuth2AccessToken <: Token
    @TestCase
    func testGetRawResponse0204(): Unit {
        var oauth2accesstoken01=OAuth2AccessToken("123")
        var oauth2accesstoken02=OAuth2AccessToken("123")
        var oauth2accesstoken03=OAuth2AccessToken("123")
        for (str in strValues) {
            oauth2accesstoken01=OAuth2AccessToken(str)
            @Assert(oauth2accesstoken01.getRawResponse(),"")

            oauth2accesstoken02=OAuth2AccessToken(str,str)
            @Assert(oauth2accesstoken02.getRawResponse(),str)

            for (int32Value in int32Values){
                oauth2accesstoken03=OAuth2AccessToken(str,str,int32Value,str,str,str)
                @Assert(oauth2accesstoken03.getRawResponse(),str)
            }
        }
    }
}