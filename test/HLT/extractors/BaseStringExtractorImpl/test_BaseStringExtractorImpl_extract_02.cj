// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj

@Test
public class TestBaseStringExtractorImplB004{
    /***
        public func extract(request: OAuth4cjRequest): String
        测试场景:有oauth4参数,无其他参数
    ***/
    @TestCase
    func testBaseStringExtractorImplExtract02(): Unit {
        var baseStringExtractorImpl01=BaseStringExtractorImpl()
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"http://www.baidu.com")
        oauth4cjRequest.addOAuthParameter("oauth_prefix_start","oauth_prefix_value")
        oauth4cjRequest.addOAuthParameter("scope","scope_value")
        oauth4cjRequest.addOAuthParameter("realm","scope_value")
        var re=baseStringExtractorImpl01.extract(oauth4cjRequest)
        var exp_re=getExpectResult(oauth4cjRequest)
        @Assert(re,exp_re)
    }
}

public func getExpectResult(request: OAuth4cjRequest):String {
    var verb = OAuthEncoder.encode(Verb.GET.toString())
    var url = OAuthEncoder.encode(request.getSanitizedUrl())
    var params = ParameterList()
    params.addAll(request.getQueryStringParams())
    params.addAll(request.getBodyParams())
    params.addAll(ParameterList(request.getOauthParameters()))
    params=params.sort()
    var params_encode=params.asOauthBaseString()
    return verb+"&"+url+"&"+params_encode
}