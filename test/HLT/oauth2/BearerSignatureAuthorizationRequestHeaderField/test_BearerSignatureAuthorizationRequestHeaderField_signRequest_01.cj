// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestBearerSignatureAuthorizationRequestHeaderFieldB004{
    /***
        public func signRequest(accessToken: String, request: OAuth4cjRequest): Unit
        测试场景:添加Authorization Request Header,正常添加即可
    ***/
    @TestCase
    func testBearerSignatureAuthorizationRequestHeaderFieldSignRequest01(): Unit {
        var bearerSignatureAuthorizationRequestHeaderField=BearerSignatureAuthorizationRequestHeaderField.instance()
        var oauth4cjRequest=OAuth4cjRequest(Verb.POST,"https://www.baidu.com")
        var exp_headers=HashMap<String,String>()
        var re=HashMap<String,String>()
        for (str in strValues){
            exp_headers.put("Authorization","Bearer "+str)

            bearerSignatureAuthorizationRequestHeaderField.signRequest(str,oauth4cjRequest)
            re=oauth4cjRequest.getHeaders()
            @Assert(exp_headers,re)
        }
    }
}