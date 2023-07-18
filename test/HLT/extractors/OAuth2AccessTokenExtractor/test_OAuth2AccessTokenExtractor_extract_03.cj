// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj

@Test
public class TestOAuth2AccessTokenExtractorB004{
    /***
        public func extract(response: Response): OAuth2AccessToken
        测试场景:response中code==200,但是body非空,匹配不到access_token=([^&]+)
    ***/
    @TestCase
    func testOAuth2AccessTokenExtractorExtract01(): Unit {
        var oauth2AccessTokenExtractor=OAuth2AccessTokenExtractor.instance()
        var body="access_token="
        var response01=oauth4cj.model.Response(Int32(200),"message",HashMap<String,String>(),body)
        var flag=1
        try{
            oauth2AccessTokenExtractor.extract(response01)
        }catch(e:OAuth4cjException){
            if(e.toString().contains("Response body is incorrect. Can't extract a '"+"access_token=([^&]+)'"+" from this: '")){
                flag=0
            }
        }
        @Assert(flag,0)
    }
}