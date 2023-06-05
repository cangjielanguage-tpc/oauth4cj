// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp

from std import unittest.*
from std import unittest.testmacro.*
from std import collection.*
from oauth4cj import model.*
from oauth4cj import revoke.*
from std import fs.*
@Test
public class TestOAuth2RevokeTokenResponseConverterB004{
    /***
        public func convert(response: Response): Unit
        测试场景: Response.code==200
    ***/
    @TestCase
    func testOAuth2RevokeTokenResponseConverterConvert01(): Unit {
        var oAuth2RevokeTokenResponseConverter01=OAuth2RevokeTokenResponseConverter()
        var response01=Response(Int32(200),"message",HashMap<String,String>(),"body")
        var flag=1
        oAuth2RevokeTokenResponseConverter01.convert(response01)
        try{
            oAuth2RevokeTokenResponseConverter01.convert(response01)
        }catch(e:OAuth2AccessTokenErrorResponse){
            flag=0
        }
        @Assert(flag,1)
    }
}