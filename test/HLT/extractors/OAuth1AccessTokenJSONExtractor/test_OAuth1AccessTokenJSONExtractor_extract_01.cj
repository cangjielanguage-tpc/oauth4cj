// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj

@Test
public class TestOAuth1AccessTokenJSONExtractorB004{
    /***
        public func extract(response: Response): OAuth2AccessToken
        测试场景:response中body为空
    ***/
    @TestCase
    func testOAuth1AccessTokenJSONExtractorExtract01(): Unit {
        var oauth1AccessTokenJSONExtractor=OAuth1AccessTokenJSONExtractor.instance()
        var response01=oauth4cj.model.Response(Int32(2),"message",HashMap<String,String>(),"")
        var flag=1
        try{
            oauth1AccessTokenJSONExtractor.extract(response01)
        }catch(e:IllegalArgumentException){
            if(e.toString().contains("Response body is incorrect. Can't extract a token from an empty string")){
                flag=0
            }
        }
        @Assert(flag,0)
    }
}