// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj

@Test
public class TestOAuth2AccessTokenExtractorB004{
    /***
        public func extract(response: Response): OAuth2AccessToken
        测试场景:response中code==200,但是body非空,匹配到access_token=([^&]+),token_type=([^&]+),expires_in=([^&]+),refresh_token=([^&]+),scope=([^&]+),且expires_in可以整型化
    ***/
    @TestCase
    func testOAuth2AccessTokenExtractorExtract01(): Unit {
        var oauth2AccessTokenExtractor02=OAuth2AccessTokenExtractor.instance()
        var body="access_token=access_token&token_type=token_type&expires_in=215&refresh_token=refresh_token&scope=scope"
        var response01=oauth4cj.model.Response(Int32(200),"message",HashMap<String,String>(),body)
        var oauth2AccessToken02=oauth2AccessTokenExtractor02.extract(response01)

        @Assert(oauth2AccessToken02 is OAuth2AccessToken,true)
        @Assert(oauth2AccessToken02.getAccessToken(),"access_token")
        @Assert(oauth2AccessToken02.getTokenType(),"token_type")
        @Assert(oauth2AccessToken02.getExpiresIn(),Int32(215))
        @Assert(oauth2AccessToken02.getRefreshToken(),"refresh_token")
        @Assert(oauth2AccessToken02.getScope(),"scope")

    }
}