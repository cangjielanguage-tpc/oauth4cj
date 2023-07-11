// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj

@Test
public class TestOAuth1RequestTokenJSONExtractorB004{
    /***
        public func extract(response: Response): OAuth1RequestToken
        测试场景:response中body为空
    ***/
    @TestCase
    func testOAuth1RequestTokenJSONExtractorExtract01(): Unit {
        var oauth1RequestTokenJSONExtractor02=OAuth1RequestTokenJSONExtractor.instance()
        var response01=oauth4cj.model.Response(Int32(2),"message",HashMap<String,String>(),"")
        var flag=1
        try{
            oauth1RequestTokenJSONExtractor02.extract(response01)
        }catch(e:IllegalArgumentException){
            if(e.toString().contains("Response body is incorrect. Can't extract a token from an empty string")){
                flag=0
            }
        }
        @Assert(flag,0)
    }
}