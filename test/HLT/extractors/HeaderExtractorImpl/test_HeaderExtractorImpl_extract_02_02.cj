// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestHeaderExtractorImplB004{
    /***
        public func extract(request: OAuth4cjRequest): String
        测试场景:oauth参数非空,realm不为空
    ***/
    @TestCase
    func testHeaderExtractorImplExtract0202(): Unit {
        var headerExtractorImpl01=HeaderExtractorImpl()
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        oauth4cjRequest.addOAuthParameter("oauth_key01","value01")
        oauth4cjRequest.addOAuthParameter("scope","scope")
        oauth4cjRequest.setRealm("realm")
        var re=headerExtractorImpl01.extract(oauth4cjRequest)
        var exp_re="OAuth "+"oauth_key01"+"=\""+OAuthEncoder.encode("value01")+"\""+", "+"scope"+"=\""+OAuthEncoder.encode("scope")+"\""+", "+"realm"+"=\""+"realm"+"\""
        @Assert(re,exp_re)
    }
}