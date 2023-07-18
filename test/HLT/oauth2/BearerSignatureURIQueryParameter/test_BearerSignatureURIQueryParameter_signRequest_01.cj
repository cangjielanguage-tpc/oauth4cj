// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj

@Test
public class TestBearerSignatureURIQueryParameterB004{
    /***
        public func signRequest(accessToken: String, request: OAuth4cjRequest): Unit
        测试场景:添加URI Query Parameter,正常添加即可
    ***/
    @TestCase
    func testBearerSignatureURIQueryParameterSignRequest01(): Unit {
        var bearerSignatureURIQueryParameter=BearerSignatureURIQueryParameter.instance()
        var oauth4cjRequest=OAuth4cjRequest(Verb.POST,"https://www.baidu.com")
        var exp_params=HashMap<String,String>()
        var param_list=ParameterList()
        for (str in strValues){
            exp_params.put("access_token",str)

            oauth4cjRequest=OAuth4cjRequest(Verb.POST,"https://www.baidu.com")
            bearerSignatureURIQueryParameter.signRequest(str,oauth4cjRequest)
            param_list=oauth4cjRequest.getQueryStringParams()
            @Assert(param_list.asFormUrlEncodedString(),ParameterList(exp_params).asFormUrlEncodedString())
            param_list=oauth4cjRequest.getBodyParams()
            @Assert(param_list.asFormUrlEncodedString(),"")
        }
    }
}