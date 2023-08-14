// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj

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
    /***
        public func extract(response: Response): OAuth2AccessToken
        测试场景:response中code==200,但是body为空
    ***/
    @TestCase
    func testOAuth2AccessTokenExtractorExtract02(): Unit {
        var oauth2AccessTokenExtractor=OAuth2AccessTokenExtractor.instance()
        var response01=oauth4cj.model.Response(Int32(200),"message",HashMap<String,String>(),"")
        var flag=1
        try{
            oauth2AccessTokenExtractor.extract(response01)
        }catch(e:IllegalArgumentException){
            if(e.toString().contains("Response body is incorrect. Can't extract a token from an empty string")){
                flag=0
            }
        }
        @Assert(flag,0)
    }
    /***
        public func extract(response: Response): OAuth2AccessToken
        测试场景:response中code==200,但是body非空,匹配不到access_token=([^&]+)
    ***/
    @TestCase
    func testOAuth2AccessTokenExtractorExtract03(): Unit {
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
    /***
        public func extract(response: Response): OAuth2AccessToken
        测试场景:response中code==200,但是body非空,匹配到access_token=([^&]+),匹配不到token_type=([^&]+),expires_in=([^&]+),refresh_token=([^&]+),scope=([^&]+)
    ***/
    @TestCase
    func testOAuth2AccessTokenExtractorExtract04(): Unit {
        var oauth2AccessTokenExtractor02=OAuth2AccessTokenExtractor.instance()
        var body="access_token=access_token&token_type=&expires_in=&refresh_token=&scope="
        var response01=oauth4cj.model.Response(Int32(200),"message",HashMap<String,String>(),body)
        var oauth2AccessToken02=oauth2AccessTokenExtractor02.extract(response01)

        @Assert(oauth2AccessToken02 is OAuth2AccessToken,true)
        @Assert(oauth2AccessToken02.getAccessToken(),"access_token")
        @Assert(oauth2AccessToken02.getTokenType(),"")
        @Assert(oauth2AccessToken02.getExpiresIn(),Int32(0))
        @Assert(oauth2AccessToken02.getRefreshToken(),"")
        @Assert(oauth2AccessToken02.getScope(),"")
    }
    /***
        public func extract(response: Response): OAuth2AccessToken
        测试场景:response中code==200,但是body非空,匹配到access_token=([^&]+),token_type=([^&]+),expires_in=([^&]+),refresh_token=([^&]+),scope=([^&]+),但是expires_in无法整型化
    ***/
    @TestCase
    func testOAuth2AccessTokenExtractorExtract05(): Unit {
        var oauth2AccessTokenExtractor02=OAuth2AccessTokenExtractor.instance()
        var body="access_token=access_token&token_type=token_type&expires_in=expires_in&refresh_token=refresh_token&scope=scope"
        var response01=oauth4cj.model.Response(Int32(200),"message",HashMap<String,String>(),body)
        var oauth2AccessToken02=oauth2AccessTokenExtractor02.extract(response01)

        @Assert(oauth2AccessToken02 is OAuth2AccessToken,true)
        @Assert(oauth2AccessToken02.getAccessToken(),"access_token")
        @Assert(oauth2AccessToken02.getTokenType(),"token_type")
        @Assert(oauth2AccessToken02.getExpiresIn(),Int32(0))
        @Assert(oauth2AccessToken02.getRefreshToken(),"refresh_token")
        @Assert(oauth2AccessToken02.getScope(),"scope")

    }
    /***
        public func extract(response: Response): OAuth2AccessToken
        测试场景:response中code==200,但是body非空,匹配到access_token=([^&]+),token_type=([^&]+),expires_in=([^&]+),refresh_token=([^&]+),scope=([^&]+),且expires_in可以整型化
    ***/
    @TestCase
    func testOAuth2AccessTokenExtractorExtract06(): Unit {
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
    /***
        public func extract(response: Response): OAuth2AccessToken
        测试场景:response中code==200,但是body非空,匹配到access_token=([^&]+),token_type=([^&]+),expires_in=([^&]+),refresh_token=([^&]+),scope=([^&]+),且expires_in超过In32最大值
    ***/
    @TestCase
    func testOAuth2AccessTokenExtractorExtract07(): Unit {
        var oauth2AccessTokenExtractor02=OAuth2AccessTokenExtractor.instance()
        var int32Max=(Int64(Int32.Max)+1).toString()
        var body="access_token=access_token&token_type=token_type&expires_in=${int32Max}&refresh_token=refresh_token&scope=scope"
        var response01=oauth4cj.model.Response(Int32(200),"message",HashMap<String,String>(),body)
        var oauth2AccessToken02=oauth2AccessTokenExtractor02.extract(response01)

        @Assert(oauth2AccessToken02.getExpiresIn(),Int32(0))
    }
}