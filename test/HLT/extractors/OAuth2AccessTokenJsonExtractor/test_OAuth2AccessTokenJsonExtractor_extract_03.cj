// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj

@Test
public class TestOAuth2AccessTokenJsonExtractorB004{
    /***
        public func extract(response: Response): OAuth2AccessToken
        测试场景:response中body非空,但是responseCode=200,不包含access_token，包含其他
    ***/
    @TestCase
    func testOAuth2AccessTokenJsonExtractorExtract03(): Unit {
        var oAuth2AccessTokenJsonExtractor02=OAuth2AccessTokenJsonExtractor.instance()
        var body=###"{
"error_uri":"http://www.baidu.com",
"error":"slow_down",
"error_description":"error_description",
"expires_in":2,
"token_type":"token_type",
"refresh_token":"refresh_token",
"scope":"scope"}"###
        var response01=oauth4cj.model.Response(Int32(200),"message",HashMap<String,String>(),body)

        var flag=1
        try{
            oAuth2AccessTokenJsonExtractor02.extract(response01)
        }catch(e:OAuth4cjException){
            if(e.toString().contains("Response body is incorrect. Can't extract a '" + "access_token" + "' from this: '" + body + "'")){
                flag=0
            }
        }
        @Assert(flag,0)
    }
}

