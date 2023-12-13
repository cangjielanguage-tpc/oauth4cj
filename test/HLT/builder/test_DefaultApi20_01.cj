// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj

@Test
public class TestDefaultApi20B004{
    /***
        public func createService(apiKey: String, apiSecret: String, callback: String, defaultScope: String,responseType: String, debugStream: ?OutputStream, userAgent: String, httpClientConfig: ?HttpClientConfig,httpClient: ?OAuth4cjHttpClient):OAuth20Service
        测试场景:callback ,scope,state均是Option<String>.None
    ***/
    @TestCase
    func testDefaultApi20CreateService01(): Unit {
        var subDefaultApi20=SubDefaultApi20()
        let str_common="cangjie"
        let debugStream=Option<OutputStream>.None
        let httpClientConfig=Option<HttpClientConfig>.None
        let httpClient=Option<OAuth4cjHttpClient>.None
        let httpClientProvider=Option<HttpClientProvider>.None
        let oAuth20Service=subDefaultApi20.createService(str_common,str_common,str_common,str_common,str_common,debugStream,str_common,httpClientConfig,httpClient,httpClientProvider)
        @Assert(oAuth20Service is OAuth20Service,true)
    }
    /***
        public open func getAccessTokenEndpoint(): String
        测试场景:根据实现类重写返回结果
    ***/
    @TestCase
    func testDefaultApi20GetAccessTokenEndpoint01(): Unit {
        var subDefaultApi20=SubDefaultApi20()
        @Assert(subDefaultApi20.getAccessTokenEndpoint(),"accessTokenEndpoint_DefaultApi20")
    }
    /***
        public func getAccessTokenExtractor(): TokenExtractor<OAuth2AccessToken>
        测试场景:构造器默认
    ***/
    @TestCase
    func testDefaultApi20GetAccessTokenExtractor01(): Unit {
        var subDefaultApi20=SubDefaultApi20()
        var accessTokenExtractor=subDefaultApi20.getAccessTokenExtractor()
        @Assert(accessTokenExtractor is OAuth2AccessTokenJsonExtractor, true)
        @Assert(accessTokenExtractor is TokenExtractor<OAuth2AccessToken>, true)
    }
    /***
        public func getAccessTokenVerb(): Verb
        测试场景:默认均返回Verb.POST
    ***/
    @TestCase
    func testDefaultApi20GetAccessTokenVerb01(): Unit {
        var subDefaultApi20=SubDefaultApi20()
        @Assert(subDefaultApi20.getAccessTokenVerb().toString(),Verb.POST.toString())
    }
    /***
        public func getAuthorizationUrl(responseType: String, apiKey: String, callback: ?String, scope: ?String,state: ?String, additionalParams: HashMap<String, String>): String
        测试场景:callback ,scope,state均不是Option<String>.None
    ***/
    @TestCase
    func testDefaultApi20GetAuthorizationUrl01(): Unit {
        var subDefaultApi20=SubDefaultApi20()
        let str_common="cangjie"
        let str_common_option=Option<String>.Some(str_common)
        var map=HashMap<String, String>([("map01","value01")])
        var authorizationUrl=subDefaultApi20.getAuthorizationUrl(str_common,str_common,str_common_option,str_common_option,str_common_option,map)
        var params=ParameterList(map)
        params.add("response_type",str_common)
        params.add("client_id",str_common)
        params.add("redirect_uri",str_common_option.getOrThrow())
        params.add("scope",str_common_option.getOrThrow())
        params.add("state",str_common_option.getOrThrow())
        var exp_authorizationUrl=params.appendTo(subDefaultApi20.getAuthorizationBaseUrl())
        @Assert(authorizationUrl,exp_authorizationUrl)
    }
    /***
        public func getAuthorizationUrl(responseType: String, apiKey: String, callback: ?String, scope: ?String,state: ?String, additionalParams: HashMap<String, String>): String
        测试场景:callback ,scope,state均是Option<String>.None
    ***/
    @TestCase
    func testDefaultApi20GetAuthorizationUrl02(): Unit {
        var subDefaultApi20=SubDefaultApi20()
        let str_common="cangjie"
        let str_common_option=Option<String>.None
        var map=HashMap<String, String>([("map01","value01")])
        var authorizationUrl=subDefaultApi20.getAuthorizationUrl(str_common,str_common,str_common_option,str_common_option,str_common_option,map)
        var params=ParameterList(map)
        params.add("response_type",str_common)
        params.add("client_id",str_common)
        var exp_authorizationUrl=params.appendTo(subDefaultApi20.getAuthorizationBaseUrl())
        @Assert(authorizationUrl,exp_authorizationUrl)
    }
    /***
        public func getBearerSignature(): BearerSignature
        测试场景:能生成BearerSignature即可
    ***/
    @TestCase
    func testDefaultApi20GetBearerSignature01(): Unit {
        var subDefaultApi20=SubDefaultApi20()
        let bearerSignature=subDefaultApi20.getBearerSignature()
        @Assert(bearerSignature is BearerSignatureAuthorizationRequestHeaderField,true)
        @Assert(bearerSignature is BearerSignature,true)
    }
    /***
        public func getClientAuthentication(): ClientAuthentication
        测试场景:能生成ClientAuthentication即可
    ***/
    @TestCase
    func testDefaultApi20GetClientAuthentication01(): Unit {
        var subDefaultApi20=SubDefaultApi20()
        let clientAuthentication=subDefaultApi20.getClientAuthentication()
        @Assert(clientAuthentication is HttpBasicAuthenticationScheme,true)
        @Assert(clientAuthentication is ClientAuthentication,true)
    }
    /***
        public func getDeviceAuthorizationEndpoint(): String
        测试场景:未被重写，抛异常
    ***/
    @TestCase
    func testDefaultApi20GetDeviceAuthorizationExtractor01(): Unit {
        var subDefaultApi20=SubDefaultApi20()
        var flag=1
        try{
            subDefaultApi20.getDeviceAuthorizationEndpoint()
        }catch(e:IllegalArgumentException){
            if(e.toString().contains("IllegalArgumentException") && e.toString().contains("This API doesn't support device authorization grant or we have no info about this")){
                flag=0
            }
        }
        @Assert(flag,0)
    }
    /***
        public func getDeviceAuthorizationExtractor(): DeviceAuthorizationJsonExtractor
        测试场景:能生成DeviceAuthorizationJsonExtractor即可
    ***/
    @TestCase
    func testDefaultApi20GetDeviceAuthorizationExtractor02(): Unit {
        var subDefaultApi20=SubDefaultApi20()
        let deviceAuthorization=subDefaultApi20.getDeviceAuthorizationExtractor()
        @Assert(deviceAuthorization is DeviceAuthorizationJsonExtractor,true)
    }
    /***
        public func getRefreshTokenEndpoint(): String
        测试场景:根据实现类重写返回结果
    ***/
    @TestCase
    func testDefaultApi20GetRefreshTokenEndpoint01(): Unit {
        var subDefaultApi20=SubDefaultApi20()
        @Assert(subDefaultApi20.getRefreshTokenEndpoint(),"accessTokenEndpoint_DefaultApi20")
    }
    /***
        public func getRevokeTokenEndpoint(): String
        测试场景:不被重写抛异常
    ***/
    @TestCase
    func testDefaultApi20GetRevokeTokenEndpoint01(): Unit {
        var subDefaultApi20=SubDefaultApi20()
        var flag=1
        try{
            subDefaultApi20.getRevokeTokenEndpoint()
        }catch(e:IllegalArgumentException ){
            if(e.toString().contains("IllegalArgumentException") && e.toString().contains("This API doesn't support revoking tokens or we have no info about this")){
                flag=0
            }
        }
        @Assert(flag,0)
    }
}
