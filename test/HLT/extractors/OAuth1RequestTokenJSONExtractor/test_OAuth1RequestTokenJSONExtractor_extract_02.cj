// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj

@Test
public class TestOAuth1RequestTokenJSONExtractorB004{
    /***
        public func extract(response: Response): OAuth1RequestToken
        测试场景:response中body非空,解析后json树不包含"oauth_token"
    ***/
    @TestCase
    func testOAuth1RequestTokenJSONExtractorExtract02(): Unit {
        var oauth1RequestTokenJSONExtractor02=OAuth1RequestTokenJSONExtractor.instance()
        var body=###"{"error_uri":"http://www.baidu.com"}"###
        var response01=oauth4cj.model.Response(Int32(200),"message",HashMap<String,String>(),body)
        var flag=1
        try{
            oauth1RequestTokenJSONExtractor02.extract(response01)
        }catch(e:OAuth4cjException){
            if(e.toString().contains("Response body is incorrect. Can't extract token and secret from this: '" + body + '\'')){
                flag=0
            }
        }
        @Assert(flag,0)
    }
}

