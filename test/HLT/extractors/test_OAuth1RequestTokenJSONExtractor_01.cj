// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj

@Test
public class TestOAuth1RequestTokenJSONExtractorB004{
    /***
        public func extract(response: Response): OAuth1RequestToken
        测试场景:response中body为空
    ***/
    @TestCase
    func testOAuth1RequestTokenJSONExtractorExtract01(): Unit {
        var oauth1RequestTokenJSONExtractor02=OAuth1RequestTokenJSONExtractor.instance()
        var response01=OAuth4cjResponse(Int32(2),"message",HashMap<String,String>(),"")
        var flag=1
        try{
            oauth1RequestTokenJSONExtractor02.extract(response01)
        }catch(e:IllegalArgumentException){
            if(e.toString().contains("IllegalArgumentException") && e.toString().contains("Response body is incorrect. Can't extract a token from an empty string")){
                flag=0
            }
        }
        @Assert(flag,0)
    }
    /***
        public func extract(response: Response): OAuth1RequestToken
        测试场景:response中body非空,解析后json树不包含"oauth_token"
    ***/
    @TestCase
    func testOAuth1RequestTokenJSONExtractorExtract02(): Unit {
        var oauth1RequestTokenJSONExtractor02=OAuth1RequestTokenJSONExtractor.instance()
        var body=###"{"error_uri":"http://www.baidu.com"}"###
        var response01=OAuth4cjResponse(Int32(200),"message",HashMap<String,String>(),body)
        var flag=1
        try{
            oauth1RequestTokenJSONExtractor02.extract(response01)
        }catch(e:OAuth4cjException){
            if(e.toString().contains("OAuth4cjException") && e.toString().contains("Response body is incorrect. Can't extract token and secret from this: '" + body + "\'")){
                flag=0
            }
        }
        @Assert(flag,0)
    }
    /***
        public func extract(response: Response): OAuth1RequestToken
        测试场景:response中body非空,包含oauth_token，同时不包含oauth_token_secret
    ***/
    @TestCase
    func testOAuth1RequestTokenJSONExtractorExtract03(): Unit {
        var oauth1RequestTokenJSONExtractor02=OAuth1RequestTokenJSONExtractor.instance()
        var body=###"{"oauth_token":"dadadsasdada"}"###
        var response01=OAuth4cjResponse(Int32(200),"message",HashMap<String,String>(),body)
        var flag=1
        try{
            oauth1RequestTokenJSONExtractor02.extract(response01)
        }catch(e:OAuth4cjException){
            if(e.toString().contains("OAuth4cjException") && e.toString().contains("Response body is incorrect. Can't extract token and secret from this: '" + body + "\'")){
                flag=0
            }
        }
        @Assert(flag,0)
    }
    /***
        public func extract(response: Response): OAuth1RequestToken
        测试场景:response中body非空,包含oauth_token，同时包含oauth_token_secret
    ***/
    @TestCase
    func testOAuth1RequestTokenExtractorExtract04(): Unit {
        var oauth1RequestTokenJSONExtractor01=OAuth1RequestTokenJSONExtractor.instance()

        var body=###"{"oauth_token":"dadadsasdada","oauth_token_secret":"dadadsasdada"}"###
        var response01=OAuth4cjResponse(Int32(200),"message",HashMap<String,String>(),body)
        var oauth1RequestToken02=oauth1RequestTokenJSONExtractor01.extract(response01)

        @Assert(oauth1RequestToken02 is OAuth1RequestToken,true)
        @Assert(oauth1RequestToken02.getToken(),"dadadsasdada")
        @Assert(oauth1RequestToken02.getTokenSecret(),"dadadsasdada")
        @Assert(oauth1RequestToken02.getRawResponse(),body)
    }
}