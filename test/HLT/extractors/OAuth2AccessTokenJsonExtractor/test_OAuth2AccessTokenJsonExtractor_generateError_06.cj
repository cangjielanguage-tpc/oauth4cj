// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj

@Test
public class TestOAuth2AccessTokenJsonExtractorB004{
    /***
        public func generateError(response: Response): Unit
        测试场景:
        response中body不为空，且可解析成json字符串,
        且包含key("error_uri"),包含("error"),
        但是error信息是OAuth2Error的errorString,但是key包含error_description
    ***/
    @TestCase
    func testOAuth2AccessTokenJsonExtractorGenerateError06(): Unit {
        var oauth2AccessTokenJsonExtractor02=OAuth2AccessTokenJsonExtractor.instance()
        var body=###"{
"error_uri":"http://www.baidu.com",
"error":"slow_down",
"error_description":"error_description",
"expires_in":"expires_in",
"token_type":"token_type",
"refresh_token":"refresh_token",
"scope":"scope",
"access_token":"access_token"}"###
        var response01=oauth4cj.model.Response(Int32(2),"message",HashMap<String,String>(),body)
        var flag=1
        try{
            oauth2AccessTokenJsonExtractor02.generateError(response01)
        }catch(e:OAuth2AccessTokenErrorResponse){
            flag=0
            var error_description=e.getErrorDescription()
            @Assert(error_description,"error_description")
        }
        @Assert(flag,0)
    }
}