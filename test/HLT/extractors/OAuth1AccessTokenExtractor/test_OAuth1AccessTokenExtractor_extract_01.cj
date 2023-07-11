// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj


@Test
public class TestOAuth1AccessTokenExtractorB004{
    /***
        public func extract(response: Response): OAuth1AccessToken
        测试场景:response中body是空字符串
    ***/
    @TestCase
    func testOAuth1AccessTokenExtractorExtract01(): Unit {
        var oauth1AccessTokenExtractor01=OAuth1AccessTokenExtractor.instance()
        var body=""
        var response01=oauth4cj.model.Response(Int32(2),"message",HashMap<String,String>(),body)
        var flag=0
        try{
            oauth1AccessTokenExtractor01.extract(response01)
        }catch(e:IllegalArgumentException){
            if(e.toString().contains("Response body is incorrect. Can't extract a token from an empty string")){
                flag=1
            }
        }
        @Assert(flag,1)
    }
}