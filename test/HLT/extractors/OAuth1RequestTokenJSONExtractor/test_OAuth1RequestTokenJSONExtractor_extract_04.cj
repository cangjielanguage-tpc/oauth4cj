// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestOAuth1RequestTokenJSONExtractorB004{
    /***
        public func extract(response: Response): OAuth1RequestToken
        测试场景:response中body非空,包含oauth_token，同时包含oauth_token_secret
    ***/
    @TestCase
    func testOAuth1RequestTokenExtractorExtract04(): Unit {
        var oauth1RequestTokenJSONExtractor01=OAuth1RequestTokenJSONExtractor.instance()

        var body=###"{"oauth_token":"dadadsasdada","oauth_token_secret":"dadadsasdada"}"###
        var response01=oauth4cj.model.Response(Int32(200),"message",HashMap<String,String>(),body)
        var oauth1RequestToken02=oauth1RequestTokenJSONExtractor01.extract(response01)

        @Assert(oauth1RequestToken02 is OAuth1RequestToken,true)
        @Assert(oauth1RequestToken02.getToken(),"dadadsasdada")
        @Assert(oauth1RequestToken02.getTokenSecret(),"dadadsasdada")
        @Assert(oauth1RequestToken02.getRawResponse(),body)
    }
}

