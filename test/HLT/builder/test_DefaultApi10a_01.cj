// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj

@Test
public class TestDefaultApi10aB004{
    /***
        public func createService(apiKey:String, apiSecret: String, callback: String, scope: String,debugStream: Option<OutputStream>, userAgent: String, httpClientConfig: Option<HttpClientConfig>,httpClient: Option<OAuth4cjHttpClient>): OAuth10aService
        测试场景:callback ,scope,state均是Option<String>.None
    ***/
    @TestCase
    func testDefaultApi10aCreateService01(): Unit {
        var subDefaultApi10a=SubDefaultApi10a()
        let str_common="cangjie"
        let debugStream=Option<OutputStream>.None
        let httpClientConfig=Option<HttpClientConfig>.None
        let httpClient=Option<OAuth4cjHttpClient>.None
        let httpClientProvider=Option<HttpClientProvider>.None
        let oAuth10aService=subDefaultApi10a.createService(str_common,str_common,str_common,str_common,debugStream,str_common,httpClientConfig,httpClient,httpClientProvider)
        @Assert(oAuth10aService is OAuth10aService,true)
    }
    /***
        public func getAccessTokenEndpoint(): String
        测试场景:返回子类实现
    ***/
    @TestCase
    func testDefaultApi10aGetAccessTokenEndpoint01(): Unit {
        var subDefaultApi10a=SubDefaultApi10a()
        let accessTokenEndpoint=subDefaultApi10a.getAccessTokenEndpoint()
        @Assert(accessTokenEndpoint,"accessTokenEndpoint_DefaultApi10a")
    }
    /***
        public func getAccessTokenExtractor(): TokenExtractor<OAuth1AccessToken>
        测试场景:能生成TokenExtractor<OAuth1AccessToken>即可
    ***/
    @TestCase
    func testDefaultApi10aGetAccessTokenExtractor01(): Unit {
        var subDefaultApi10a=SubDefaultApi10a()
        let accessTokenExtractor=subDefaultApi10a.getAccessTokenExtractor()
        @Assert(accessTokenExtractor is TokenExtractor<OAuth1AccessToken>,true)
        @Assert(accessTokenExtractor is OAuth1AccessTokenExtractor,true)
    }
    /***
        public func getAccessTokenVerb(): Verb
        测试场景:返回值准确
    ***/
    @TestCase
    func testDefaultApi10aGetAccessTokenVerb01(): Unit {
        var subDefaultApi10a=SubDefaultApi10a()
        let accessTokenVerb=subDefaultApi10a.getAccessTokenVerb()
        @Assert(accessTokenVerb.toString(),"POST")
    }
    /***
        public func getAuthorizationUrl(requestToken: OAuth1RequestToken): String
        测试场景:返回子类实现
    ***/
    @TestCase
    func testDefaultApi10aGetAuthorizationUrl01(): Unit {
        var subDefaultApi10a=SubDefaultApi10a()
        var oauth1RequestToken=OAuth1RequestToken("token","tokenSecret")
        let authorizationUrl=subDefaultApi10a.getAuthorizationUrl(oauth1RequestToken)
        var params=ParameterList()
        params.add("oauth_token",oauth1RequestToken.getToken())
        var exp_re=params.appendTo(subDefaultApi10a.getAuthorizationBaseUrl())
        @Assert(authorizationUrl,exp_re)
    }
    /***
        public func getBaseStringExtractor(): BaseStringExtractor
        测试场景:能生成BaseStringExtractor即可
    ***/
    @TestCase
    func testDefaultApi10aGetBaseStringExtractor01(): Unit {
        var subDefaultApi10a=SubDefaultApi10a()
        let baseStringExtractor=subDefaultApi10a.getBaseStringExtractor()
        @Assert(baseStringExtractor is BaseStringExtractor,true)
        @Assert(baseStringExtractor is BaseStringExtractorImpl,true)
    }
    /***
        public func getHeaderExtractor(): HeaderExtractor
        测试场景:能生成HeaderExtractor即可
    ***/
    @TestCase
    func testDefaultApi10aGetHeaderExtractor01(): Unit {
        var subDefaultApi10a=SubDefaultApi10a()
        let headerExtractor=subDefaultApi10a.getHeaderExtractor()
        @Assert(headerExtractor is HeaderExtractorImpl,true)
        @Assert(headerExtractor is HeaderExtractor,true)
    }
    /***
        public func getRequestTokenEndpoint(): String
        测试场景:返回子类实现
    ***/
    @TestCase
    func testDefaultApi10aGetRequestTokenEndpoint01(): Unit {
        var subDefaultApi10a=SubDefaultApi10a()
        let requestTokenEndpoint=subDefaultApi10a.getRequestTokenEndpoint()
        @Assert(requestTokenEndpoint,"requestTokenEndpoint_DefaultApi10a")
    }
    /***
        public func getRequestTokenExtractor(): TokenExtractor<OAuth1RequestToken>
        测试场景:能生成HHeaderExtractor即可
    ***/
    @TestCase
    func testDefaultApi10aGetRequestTokenExtractor01(): Unit {
        var subDefaultApi10a=SubDefaultApi10a()
        let requestTokenExtractor=subDefaultApi10a.getRequestTokenExtractor()
        @Assert(requestTokenExtractor is TokenExtractor<OAuth1RequestToken>,true)
        @Assert(requestTokenExtractor is OAuth1RequestTokenExtractor,true)
    }
    /***
        public func getRequestTokenVerb(): Verb
        测试场景:返回值准确
    ***/
    @TestCase
    func testDefaultApi10aGetRequestTokenVerb01(): Unit {
        var subDefaultApi10a=SubDefaultApi10a()
        let requestTokenVerb=subDefaultApi10a.getRequestTokenVerb()
        @Assert(requestTokenVerb.toString(),"POST")
    }
    /***
        public func getSignatureService(): SignatureService
        测试场景:能生成SignatureService即可
    ***/
    @TestCase
    func testDefaultApi10aGetSignatureService01(): Unit {
        var subDefaultApi10a=SubDefaultApi10a()
        let signatureService=subDefaultApi10a.getSignatureService()
        @Assert(signatureService is SignatureService,true)
        @Assert(signatureService is HMACSha1SignatureService,true)
    }
    /***
        public func getSignatureType(): OAuth1SignatureType
        测试场景:能生成OAuth1SignatureType即可
    ***/
    @TestCase
    func testDefaultApi10aGetSignatureType01(): Unit {
        var subDefaultApi10a=SubDefaultApi10a()
        let signatureType=subDefaultApi10a.getSignatureType()
        @Assert(signatureType.toString(),"HEADER")
    }
    /***
        public func getTimestampService(): TimestampService
        测试场景:能生成TimestampService即可
    ***/
    @TestCase
    func testDefaultApi10aGetTimestampService01(): Unit {
        var subDefaultApi10a=SubDefaultApi10a()
        let timestampService=subDefaultApi10a.getTimestampService()
        @Assert(timestampService is TimestampService,true)
        @Assert(timestampService is TimestampServiceImpl,true)
    }
    /***
        public func isEmptyOAuthTokenParamIsRequired(): Bool
        测试场景:不复写,返回false
    ***/
    @TestCase
    func testDefaultApi10aIsEmptyOAuthTokenParamIsRequired01(): Unit {
        var subDefaultApi10a=SubDefaultApi10a()
        let isEmptyOAuthTokenParamIsRequired=subDefaultApi10a.isEmptyOAuthTokenParamIsRequired()
        @Assert(isEmptyOAuthTokenParamIsRequired,false)
    }
}
