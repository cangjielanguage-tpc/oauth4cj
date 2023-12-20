// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj

@Test
public class TestOAuth1RequestTokenExtractorB004{
    /***
        public func extract(response: Response): OAuth1AccessToken
        测试场景:response中body是空字符串
    ***/
    @TestCase
    func testOAuth1RequestTokenExtractorExtract01(): Unit {
        var oauth1RequestTokenExtractor01=OAuth1RequestTokenExtractor.instance()
        var body=""
        var response01=oauth4cj.OAuth4cjResponse(Int32(2),"message",HashMap<String,String>(),body)
        var flag=0
        try{
            oauth1RequestTokenExtractor01.extract(response01)
        }catch(e:IllegalArgumentException){
            if(e.toString().contains("IllegalArgumentException") && e.toString().contains("Response body is incorrect. Can't extract a token from an empty string")){
                flag=1
            }
        }
        @Assert(flag,1)
    }
    /***
        public func extract(response: Response): OAuth1AccessToken
        测试场景:response中body是非空,字符串不能匹配到oauth_token=([^&]+),
    ***/
    @TestCase
    func testOAuth1RequestTokenExtractorExtract02(): Unit {
        var oauth1RequestTokenExtractor01=OAuth1RequestTokenExtractor.instance()
        var body="error=slow_down"
        var response01=oauth4cj.OAuth4cjResponse(Int32(2),"message",HashMap<String,String>(),body)
        var flag=1
        try{
            oauth1RequestTokenExtractor01.extract(response01)
        }catch(e:OAuth4cjException){
            if(e.toString().contains("OAuth4cjException") && e.toString().contains("Response body is incorrect. Can't extract token and secret from this: '" + body + "'")){
                flag=0
            }
        }
        @Assert(flag,0)
    }
    /***
        public func extract(response: Response): OAuth1AccessToken
        测试场景:response中body是非空,字符串能匹配到oauth_token=([^&]+),不能匹配到oauth_token_secret=([^&]*)
    ***/
    @TestCase
    func testOAuth1RequestTokenExtractorExtract03(): Unit {
        var oauth1RequestTokenExtractor01=OAuth1RequestTokenExtractor.instance()
        var body="oauth_token=abcsd&token_secret=&"
        var response01=oauth4cj.OAuth4cjResponse(Int32(2),"message",HashMap<String,String>(),body)
        var flag=1
        try{
            oauth1RequestTokenExtractor01.extract(response01)
        }catch(e:OAuth4cjException){
            if(e.toString().contains("OAuth4cjException") && e.toString().contains("Response body is incorrect. Can't extract token and secret from this: '" + body + "'")){
                flag=0
            }
        }
        @Assert(flag,0)
    }
    /***
        public func extract(response: Response): OAuth1AccessToken
        测试场景:response中body是非空,字符串能匹配到oauth_token=([^&]+),能匹配到oauth_token_secret=([^&]*)
    ***/
    @TestCase
    func testOAuth1RequestTokenExtractorExtract04(): Unit {
        var oauth1RequestTokenExtractor01=OAuth1RequestTokenExtractor.instance()
        var body="oauth_token=oauth_token&oauth_token_secret=oauth_token_secret&abc"
        var response01=oauth4cj.OAuth4cjResponse(Int32(2),"message",HashMap<String,String>(),body)
        var oauth1AccessToken02=oauth1RequestTokenExtractor01.extract(response01)
        @Assert(oauth1AccessToken02 is OAuth1RequestToken,true)
        @Assert(oauth1AccessToken02.getToken(),"oauth_token")
        @Assert(oauth1AccessToken02.getTokenSecret(),"oauth_token_secret")
        @Assert(oauth1AccessToken02.getRawResponse(),body)
    }
}