// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from std import collection.*
from oauth4cj import model.*
from oauth4cj import oauth2.clientauthentication.*

@Test
public class TestRequestBodyAuthenticationSchemeB004{
    /***
        public func addClientAuthentication(request: OAuth4cjRequest, apiKey: String, apiSecret: String): Unit
        测试场景:Http Basic authentication scheme.添加请求头：Authorization
    ***/
    @TestCase
    func testRequestBodyAuthenticationSchemeAddClientAuthentication01(): Unit {
        var requestBodyAuthenticationScheme=RequestBodyAuthenticationScheme.instance()
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        var exp_headers=HashMap<String,String>()
        var param_list=ParameterList(HashMap<String,String>())
        for (str in strValues){
            exp_headers.put("client_id",str)
            exp_headers.put("client_secret",str)
            oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")

            requestBodyAuthenticationScheme.addClientAuthentication(oauth4cjRequest,str,str)
            param_list=oauth4cjRequest.getQueryStringParams()
            @Assert(param_list.asFormUrlEncodedString(),ParameterList(exp_headers).asFormUrlEncodedString())
            
            param_list=oauth4cjRequest.getBodyParams()
            @Assert(param_list.asFormUrlEncodedString(),"")
        }
    }
}