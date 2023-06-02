// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp

from std import unittest.*
from std import unittest.testmacro.*
from std import collection.*
from oauth4cj import model.*
from oauth4cj import revoke.*
from std import fs.*
from std import io.*

@Test
public class TestOAuth2RevokeTokenResponseConverterB004{
    /***
        public func convert(response: Response): Unit
        测试场景: Response.code!=200
    ***/
    @TestCase
    func testOAuth2RevokeTokenResponseConverterConvert02(): Unit {
        var oAuth2RevokeTokenResponseConverter02=OAuth2RevokeTokenResponseConverter()
        var sub01=SubResource(File("../../common_Values.cj",OpenOption.CreateOrTruncate(true)))
        var inputStream=ByteArrayStream()
        inputStream.write("hello cangjie".toUtf8Array())
        var response02=Response(Int32(400),"message",HashMap<String,String>(),inputStream,ArrayList<Resource>([sub01]))
        var flag=1
        try{
            oAuth2RevokeTokenResponseConverter02.convert(response02)
        }catch(e:OAuth2AccessTokenErrorResponse){
            flag=0
        }
        @Assert(flag,0)
    }
}


