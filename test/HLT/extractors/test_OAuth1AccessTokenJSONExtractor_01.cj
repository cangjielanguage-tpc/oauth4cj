// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj

@Test
public class TestOAuth1AccessTokenJSONExtractorB004{
    /***
        public func extract(response: Response): OAuth2AccessToken
        测试场景:response中body为空
    ***/
    @TestCase
    func testOAuth1AccessTokenJSONExtractorExtract01(): Unit {
        var oauth1AccessTokenJSONExtractor=OAuth1AccessTokenJSONExtractor.instance()
        var response01=oauth4cj.OAuth4cjResponse(Int32(2),"message",HashMap<String,String>(),"")
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
    /***
        public func extract(response: Response): OAuth2AccessToken
        测试场景:response中body非空,解析后json树不包含"oauth_token"
    ***/
    @TestCase
    func testOAuth1AccessTokenJsonExtractorExtract02(): Unit {
        var oauth1AccessTokenJsonExtractor02=OAuth1AccessTokenJSONExtractor.instance()
        var body=###"{"error_uri":"http://www.baidu.com"}"###
        var response01=oauth4cj.OAuth4cjResponse(Int32(200),"message",HashMap<String,String>(),body)
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
    /***
        public func extract(response: Response): OAuth2AccessToken
        测试场景:response中body非空,包含access_token，同时不包含oauth_token_secret
    ***/
    @TestCase
    func testOAuth1AccessTokenJsonExtractorExtract03(): Unit {
        var oauth1AccessTokenJsonExtractor02=OAuth1AccessTokenJSONExtractor.instance()
        var body=###"{"access_token":"dadadsasdada"}"###
        var response01=oauth4cj.OAuth4cjResponse(Int32(200),"message",HashMap<String,String>(),body)
        var flag=1
        try{
            oauth1AccessTokenJsonExtractor02.extract(response01)
        }catch(e:Exception){
            if(e.toString().contains("Exception: Response body is incorrect. Can't extract token and secret from this: '"+body+"'")){
                flag=0
            }
        }
        @Assert(flag,0)
    }
    /***
        public func extract(response: Response): OAuth2AccessToken
        测试场景:response中body非空,包含access_token，同时包含oauth_token_secret
    ***/
    @TestCase
    func testOAuth1AccessTokenJsonExtractorExtract04(): Unit {
        var oauth1AccessTokenJsonExtractor02 = OAuth1AccessTokenJSONExtractor.instance()
        var body=###"{"oauth_token":"dadadsasdada","oauth_token_secret":"dadadsasdada"}"###
        var response01=oauth4cj.OAuth4cjResponse(Int32(200),"message",HashMap<String,String>(),body)

        var oauth1AccessToken02=oauth1AccessTokenJsonExtractor02.extract(response01)

        @Assert(oauth1AccessToken02 is OAuth1AccessToken,true)
        @Assert(oauth1AccessToken02.getToken(),"dadadsasdada")
        @Assert(oauth1AccessToken02.getTokenSecret(),"dadadsasdada")
        @Assert(oauth1AccessToken02.getRawResponse(),body)

    }
}