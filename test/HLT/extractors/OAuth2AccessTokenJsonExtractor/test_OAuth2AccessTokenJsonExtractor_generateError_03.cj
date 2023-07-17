// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj

@Test
public class TestOAuth2AccessTokenJsonExtractorB004{
    /***
        public func generateError(response: Response): Unit
        测试场景:response中body不为空，且可解析成json字符串,且包含key("error_uri"),不包含("error")
    ***/
    @TestCase
    func testOAuth2AccessTokenJsonExtractorGenerateError0301(): Unit {
        var oauth2AccessTokenJsonExtractor02=OAuth2AccessTokenJsonExtractor.instance()
        var response01=oauth4cj.model.Response(Int32(2),"message",HashMap<String,String>(),"error_uri:http://www.baidu.com")
        var flag=1
        try{
            oauth2AccessTokenJsonExtractor02.generateError(response01)
        }catch(e:OAuth2AccessTokenErrorResponse){
            try{
                e.getError().getOrThrow()
            }catch(e:NoneValueException){
                flag=0
            }
        }
        @Assert(flag,0)
    }
}