// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from std import collection.*
from oauth4cj import model.*
from oauth4cj import commons.*
from oauth4cj import oauth2.clientauthentication.*
from std import io.*
@Test
public class TestHttpBasicAuthenticationSchemeB004{
    /***
        public func addClientAuthentication(request: OAuth4cjRequest, apiKey: String, apiSecret: String): Unit
        测试场景:Http Basic authentication scheme.添加请求头：Authorization
    ***/
    @TestCase
    func testHttpBasicAuthenticationSchemeAddClientAuthentication01(): Unit {
        var httpBasicAuthenticationScheme=HttpBasicAuthenticationScheme.instance()
        var oauth4cjRequest=OAuth4cjRequest(Verb.POST,"https://www.baidu.com")
        var exp_headers=HashMap<String,String>()
        var re=HashMap<String,String>()
        var str_encoding_before=""
        var str_encoding_after=""
        for (str in strValues){
            str_encoding_before=str+":"+str
            str_encoding_after=Base64Utils.encode(str_encoding_before.toUtf8Array())
            exp_headers.put("Authorization","Basic "+str_encoding_after)

            httpBasicAuthenticationScheme.addClientAuthentication(oauth4cjRequest,str,str)
            re=oauth4cjRequest.getHeaders()
            @Assert(re,exp_headers)
        }
    }
}