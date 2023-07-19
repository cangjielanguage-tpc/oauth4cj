// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestOAuth2AccessTokenJsonExtractorB004{
    /***
        public func extract(response: Response): OAuth2AccessToken
        测试场景:responseCode=200,response中body非空,且包含access_token，但不包含expires_in,refresh_token,scope,token_type
    ***/
    @TestCase
    func testOAuth2AccessTokenJsonExtractorExtract0201(): Unit {
        var oAuth2AccessTokenJsonExtractor02=OAuth2AccessTokenJsonExtractor.instance()
        var body=###"{
"error_uri":"http://www.baidu.com",
"error":"slow_down",
"error_description":"error_description",
"access_token":"access_token"}"###
        var response01=oauth4cj.model.Response(Int32(200),"message",HashMap<String,String>(),body)
        var re02=oAuth2AccessTokenJsonExtractor02.extract(response01)

        @Assert(re02 is OAuth2AccessToken,true)
        @Assert(re02.getAccessToken(),"access_token")
        @Assert(re02.getTokenType(),"")
        @Assert(re02.getExpiresIn(),Int32(0))
        @Assert(re02.getRefreshToken(),"")
        @Assert(re02.getScope(),"")
    }
}

