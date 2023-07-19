// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj

@Test
public class TestOAuth1AccessTokenJsonExtractorB004{
    /***
        public func extract(response: Response): OAuth2AccessToken
        测试场景:response中body非空,解析后json树不包含"oauth_token"
    ***/
    @TestCase
    func testOAuth1AccessTokenJsonExtractorExtract02(): Unit {
        var oauth1AccessTokenJsonExtractor02=OAuth1AccessTokenJSONExtractor.instance()
        var body=###"{"error_uri":"http://www.baidu.com"}"###
        var response01=oauth4cj.model.Response(Int32(200),"message",HashMap<String,String>(),body)
        var flag=1
        try{
            oauth1AccessTokenJsonExtractor02.extract(response01)
        }catch(e:OAuth4cjException){
            if(e.toString().contains("Response body is incorrect. Can't extract token and secret from this: '"+body+"\'")){
                flag=0
            }
        }
        @Assert(flag,0)
    }
}

