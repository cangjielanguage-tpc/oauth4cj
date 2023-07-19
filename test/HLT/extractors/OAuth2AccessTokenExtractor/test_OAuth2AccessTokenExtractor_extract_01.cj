// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj

@Test
public class TestOAuth2AccessTokenExtractorB004{
    /***
        public func extract(response: Response): OAuth2AccessToken
        测试场景:response中code!=200
    ***/
    @TestCase
    func testOAuth2AccessTokenExtractorExtract01(): Unit {
        var oauth2AccessTokenExtractor=OAuth2AccessTokenExtractor.instance()
        var response01=oauth4cj.model.Response(Int32(2),"message",HashMap<String,String>(),"")
        var flag=1
        try{
            oauth2AccessTokenExtractor.extract(response01)
        }catch(e:OAuth4cjException){
            if(e.toString().contains("Response code is not 200 but")){
                flag=0
            }
        }
        @Assert(flag,0)
    }
}