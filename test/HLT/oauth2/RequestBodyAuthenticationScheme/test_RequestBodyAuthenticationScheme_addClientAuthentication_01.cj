// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestRequestBodyAuthenticationSchemeB004{
    /***
        public func addClientAuthentication(request: OAuth4cjRequest, apiKey: String, apiSecret: String): Unit
        测试场景:Http Basic authentication scheme.添加请求头：Authorization
    ***/
    @TestCase
    func testRequestBodyAuthenticationSchemeAddClientAuthentication01(): Unit {
        var requestBodyAuthenticationScheme=RequestBodyAuthenticationScheme.instance()
        var oauth4cjRequest=OAuth4cjRequest(Verb.POST,"https://www.baidu.com")
        var exp_headers=HashMap<String,String>()
        var param_list=ParameterList(HashMap<String,String>())
        for (str in strValues){
            exp_headers.put("client_id",str)
            exp_headers.put("client_secret",str)

            oauth4cjRequest=OAuth4cjRequest(Verb.POST,"https://www.baidu.com")

            requestBodyAuthenticationScheme.addClientAuthentication(oauth4cjRequest,str,str)
            param_list=oauth4cjRequest.getQueryStringParams()
            @Assert(param_list.asFormUrlEncodedString(),"")

            param_list=oauth4cjRequest.getBodyParams()
            @Assert(param_list.asFormUrlEncodedString(),ParameterList(exp_headers).asFormUrlEncodedString())
        }
    }
}