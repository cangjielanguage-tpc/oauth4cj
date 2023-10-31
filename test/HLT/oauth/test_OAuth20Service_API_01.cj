// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj

public var url="http://127.0.0.1:${port}/index"
@Test
public class TestOAuth20ServiceB008{
    /***
        public func getAuthorizationUrl(): String
        测试场景:未设置additionalParams,pkce,state,且scope非Option.None
    ***/
    public override func beforeAll(): Unit{
        serve()
        sleep(3*Duration.second)
        url="http://127.0.0.1:${port}/index"
    }
    @TestCase
    func testOAuth20ServiceGetAuthorizationUrl0101(): Unit {
         var oauth20Service=OAuthServiceTest.getOAuth20Service()
         var re_authorizationUrl=oauth20Service.getAuthorizationUrl()

         var exp_additionalParams=HashMap<String,String>()
         var exp_params = ParameterList(exp_additionalParams)
         exp_params.add(OAuthConstants.RESPONSE_TYPE, oauth20Service.getResponseType());
         exp_params.add(OAuthConstants.CLIENT_ID, oauth20Service.getApiKey());
         exp_params.add(OAuthConstants.REDIRECT_URI, oauth20Service.getCallback().getOrThrow());
         exp_params.add(OAuthConstants.SCOPE, oauth20Service.getDefaultScope().getOrThrow());
         let exp_authorizationUrl=exp_params.appendTo(OAuthServiceTest.api_oauth20Service.getAuthorizationBaseUrl())
         @Assert(re_authorizationUrl,exp_authorizationUrl)//添加请求头，转大写
    }
    /***
        public func getAuthorizationUrl(): String
        测试场景:未设置additionalParams,pkce,state,且scope是Option.None
    ***/

    @TestCase
    func testOAuth20ServiceGetAuthorizationUrl0102(): Unit {
         var oauth20Service=OAuthServiceTest.getOAuth20ServiceScopeNone()
         var re_authorizationUrl=oauth20Service.getAuthorizationUrl()
         var exp_additionalParams=HashMap<String,String>()
         var exp_params = ParameterList(exp_additionalParams)
         exp_params.add(OAuthConstants.RESPONSE_TYPE, oauth20Service.getResponseType());
         exp_params.add(OAuthConstants.CLIENT_ID, oauth20Service.getApiKey());
         exp_params.add(OAuthConstants.REDIRECT_URI, oauth20Service.getCallback().getOrThrow());
         let exp_authorizationUrl=exp_params.appendTo(OAuthServiceTest.api_oauth20Service.getAuthorizationBaseUrl())
         @Assert(re_authorizationUrl,exp_authorizationUrl)//添加请求头，转大写
    }
    /***
        public func getAuthorizationUrl(state: String): String
        测试场景:设置state入参非None
    ***/

    @TestCase
    func testOAuth20ServiceGetAuthorizationUrl0201(): Unit {
         var oauth20Service=OAuthServiceTest.getOAuth20Service()
         var re_authorizationUrl=oauth20Service.getAuthorizationUrl("OAuth20Service state")
         var exp_additionalParams=HashMap<String,String>()
         var exp_params = ParameterList(exp_additionalParams)
         exp_params.add(OAuthConstants.RESPONSE_TYPE, oauth20Service.getResponseType());
         exp_params.add(OAuthConstants.CLIENT_ID, oauth20Service.getApiKey());
         exp_params.add(OAuthConstants.REDIRECT_URI, oauth20Service.getCallback().getOrThrow());
         exp_params.add(OAuthConstants.SCOPE, oauth20Service.getDefaultScope().getOrThrow());
         exp_params.add(OAuthConstants.STATE, "OAuth20Service state")
         let exp_authorizationUrl=exp_params.appendTo(OAuthServiceTest.api_oauth20Service.getAuthorizationBaseUrl())
         @Assert(re_authorizationUrl,exp_authorizationUrl)//添加请求头，转大写
    }
    /***
        public func getAuthorizationUrl(state: String): String
        测试场景:设置state为Option.None
    ***/

    @TestCase
    func testOAuth20ServiceGetAuthorizationUrl0202(): Unit {
         var oauth20Service=OAuthServiceTest.getOAuth20Service()
         let state=Option<String>.None
         var re_authorizationUrl=oauth20Service.getAuthorizationUrl(state)
         var exp_additionalParams=HashMap<String,String>()
         var exp_params = ParameterList(exp_additionalParams)
         exp_params.add(OAuthConstants.RESPONSE_TYPE, oauth20Service.getResponseType());
         exp_params.add(OAuthConstants.CLIENT_ID, oauth20Service.getApiKey());
         exp_params.add(OAuthConstants.REDIRECT_URI, oauth20Service.getCallback().getOrThrow());
         exp_params.add(OAuthConstants.SCOPE, oauth20Service.getDefaultScope().getOrThrow());
         let exp_authorizationUrl=exp_params.appendTo(OAuthServiceTest.api_oauth20Service.getAuthorizationBaseUrl())
         @Assert(re_authorizationUrl,exp_authorizationUrl)//添加请求头，转大写
    }
    /***
        public func getAuthorizationUrl(additionalParams: HashMap<String, String>): String
        测试场景:additionalParams非空
    ***/

    @TestCase
    func testOAuth20ServiceGetAuthorizationUrl0301(): Unit {
         var oauth20Service=OAuthServiceTest.getOAuth20Service()
         var additionalParams=HashMap<String,String>([("additionalParams01","01"),("additionalParams02","02")])
         var re_authorizationUrl=oauth20Service.getAuthorizationUrl(additionalParams)
         var exp_additionalParams=additionalParams
         var exp_params = ParameterList(exp_additionalParams)
         exp_params.add(OAuthConstants.RESPONSE_TYPE, oauth20Service.getResponseType());
         exp_params.add(OAuthConstants.CLIENT_ID, oauth20Service.getApiKey());
         exp_params.add(OAuthConstants.REDIRECT_URI, oauth20Service.getCallback().getOrThrow());
         exp_params.add(OAuthConstants.SCOPE, oauth20Service.getDefaultScope().getOrThrow());
         let exp_authorizationUrl=exp_params.appendTo(OAuthServiceTest.api_oauth20Service.getAuthorizationBaseUrl())
         @Assert(re_authorizationUrl,exp_authorizationUrl)//添加请求头，转大写
    }
    /***
        public func getAuthorizationUrl(additionalParams: HashMap<String, String>): String
        测试场景:additionalParams为空
    ***/

    @TestCase
    func testOAuth20ServiceGetAuthorizationUrl0302(): Unit {
         var oauth20Service=OAuthServiceTest.getOAuth20Service()
         var additionalParams=HashMap<String,String>()
         var re_authorizationUrl=oauth20Service.getAuthorizationUrl(additionalParams)
         var exp_additionalParams=additionalParams
         var exp_params = ParameterList(exp_additionalParams)
         exp_params.add(OAuthConstants.RESPONSE_TYPE, oauth20Service.getResponseType());
         exp_params.add(OAuthConstants.CLIENT_ID, oauth20Service.getApiKey());
         exp_params.add(OAuthConstants.REDIRECT_URI, oauth20Service.getCallback().getOrThrow());
         exp_params.add(OAuthConstants.SCOPE, oauth20Service.getDefaultScope().getOrThrow());
         let exp_authorizationUrl=exp_params.appendTo(OAuthServiceTest.api_oauth20Service.getAuthorizationBaseUrl())
         @Assert(re_authorizationUrl,exp_authorizationUrl)//添加请求头，转大写
    }
    /***
        public func getAuthorizationUrl(pkce: PKCE): String
        测试场景:pkce非None
    ***/

    @TestCase
    func testOAuth20ServiceGetAuthorizationUrl0401(): Unit {
         var oauth20Service=OAuthServiceTest.getOAuth20Service()
         let pkce=PKCE()
         pkce.setCodeChallenge("Pkce codeChallenge")
         var re_authorizationUrl=oauth20Service.getAuthorizationUrl(pkce)
         var exp_additionalParams=HashMap<String,String>()
         exp_additionalParams.putAll(pkce.getAuthorizationUrlParams())
         var exp_params = ParameterList(exp_additionalParams)
         exp_params.add(OAuthConstants.RESPONSE_TYPE, oauth20Service.getResponseType());
         exp_params.add(OAuthConstants.CLIENT_ID, oauth20Service.getApiKey());
         exp_params.add(OAuthConstants.REDIRECT_URI, oauth20Service.getCallback().getOrThrow());
         exp_params.add(OAuthConstants.SCOPE, oauth20Service.getDefaultScope().getOrThrow());
         let exp_authorizationUrl=exp_params.appendTo(OAuthServiceTest.api_oauth20Service.getAuthorizationBaseUrl())
         @Assert(re_authorizationUrl,exp_authorizationUrl)//添加请求头，转大写
    }
    /***
        public func getAuthorizationUrl(pkce: PKCE): String
        测试场景:pkce为None
    ***/

    @TestCase
    func testOAuth20ServiceGetAuthorizationUrl0402(): Unit {
         var oauth20Service=OAuthServiceTest.getOAuth20Service()
         let pkce=Option<PKCE>.None
         var re_authorizationUrl=oauth20Service.getAuthorizationUrl(pkce)
         var exp_additionalParams=HashMap<String,String>()
         var exp_params = ParameterList(exp_additionalParams)
         exp_params.add(OAuthConstants.RESPONSE_TYPE, oauth20Service.getResponseType());
         exp_params.add(OAuthConstants.CLIENT_ID, oauth20Service.getApiKey());
         exp_params.add(OAuthConstants.REDIRECT_URI, oauth20Service.getCallback().getOrThrow());
         exp_params.add(OAuthConstants.SCOPE, oauth20Service.getDefaultScope().getOrThrow());
         let exp_authorizationUrl=exp_params.appendTo(OAuthServiceTest.api_oauth20Service.getAuthorizationBaseUrl())
         @Assert(re_authorizationUrl,exp_authorizationUrl)//添加请求头，转大写
    }
    /***
        public func getApi(): DefaultApi20
        测试场景:与构造器保持一致
    ***/
    @TestCase
    func testOAuth20ServiceGetApi01(): Unit {
         let exp_api=OAuthServiceTest.api_oauth20Service
         var oauth20Service=OAuthServiceTest.getOAuth20Service()
         var re_api=(oauth20Service.getApi() as SubDefaultApi20).getOrThrow()
         @Assert(re_api==exp_api,true)
    }
    /***
        public func getDefaultScope(): Option<String>
        测试场景:与构造器传入一致
    ***/

    @TestCase
    func testOAuth20ServiceGetDefaultScope01(): Unit {
         var oauth20Service=OAuthServiceTest.getOAuth20Service()
         var oauth20ServiceScopeNone=OAuthServiceTest.getOAuth20ServiceScopeNone()
         var re_Scope=oauth20Service.getDefaultScope()
         var re_ScopeNone=oauth20ServiceScopeNone.getDefaultScope()
         @Assert(re_Scope,OAuthServiceTest.scope_oauth20Service.getOrThrow())
         var flag=1
         try{
             re_ScopeNone.getOrThrow()
         }catch(e:NoneValueException){
            flag=0
         }
         @Assert(flag,0)
    }
    /***
        public func getResponseType(): String
        测试场景:与构造器传入一致
    ***/

    @TestCase
    func testOAuth20ServiceGetResponseType01(): Unit {
         let oauth20Service=OAuthServiceTest.getOAuth20Service()
         let re_responseType=oauth20Service.getResponseType()
         let exp_responseType=OAuthServiceTest.responseType
         @Assert(re_responseType,exp_responseType)
    }
    /***
        public func getVersion(): String
        测试场景:默认值
    ***/

    @TestCase
    func testOAuth20ServiceGetVersion01(): Unit {
         var oauth20Service=OAuthServiceTest.getOAuth20Service()
         var re_Version=oauth20Service.getVersion()
         @Assert(re_Version,"2.0")
    }
    /***
        public func signRequest(accessToken: String, request: OAuth4cjRequest): Unit
        测试场景:加签后各参数值添加准确
    ***/

    @TestCase
    func testOAuth20ServiceSignRequest0101(): Unit {
         var oauth20Service=OAuthServiceTest.getOAuth20Service()
         let request=OAuth4cjRequest(Verb.POST,url)
         let accessToken="accessToken"
         oauth20Service.signRequest(accessToken,request)
         let re_Header=request.getHeaders()
         var exp_Header=HashMap<String,String>()
         exp_Header.put(OAuthConstants.HEADER_AUTHORIZATION,"Bearer " +accessToken )
         @Assert(re_Header,exp_Header)//添加请求头，转大写
    }
    /***
        public func signRequest(accessToken: OAuth2AccessToken, request: OAuth4cjRequest): Unit
        测试场景:加签后各参数值添加准确
    ***/

    @TestCase
    func testOAuth20ServiceSignRequest0201(): Unit {
         var oauth20Service=OAuthServiceTest.getOAuth20Service()
         let request=OAuth4cjRequest(Verb.POST,url)
         let accessToken=OAuth2AccessToken("accessToken")
         oauth20Service.signRequest(accessToken,request)
         let re_Header=request.getHeaders()
         var exp_Header=HashMap<String,String>()
         exp_Header.put(OAuthConstants.HEADER_AUTHORIZATION,"Bearer " +accessToken.getAccessToken() )
         @Assert(re_Header,exp_Header)//添加请求头，转大写
    }
    /***
        public func extractAuthorization(redirectLocation: String): OAuth2Authorization
        测试场景:redirectLocation包含字符'#',且包含?,有&,且分割后所有值仅有一个=，且key和value本身无等号，key为code,state,或者其他
    ***/

    @TestCase
    func testOAuth20ServiceExtractAuthorization01(): Unit {
         var oauth20Service=OAuthServiceTest.getOAuth20Service()
         let redirectLocation="${url}?code=codeValue&state=stateValue&password=passwd#&state=stateValue02"
         var re_extractAuthorization=oauth20Service.extractAuthorization(redirectLocation)
         @Assert(re_extractAuthorization.getCode(),URLEncoder.decode("codeValue","utf8"))
         @Assert(re_extractAuthorization.getState(),URLEncoder.decode("stateValue","utf8"))
    }
    /***
        public func extractAuthorization(redirectLocation: String): OAuth2Authorization
        测试场景:redirectLocation包含字符'#',且包含?,有&,且分割后所有值仅有一个=，且key和value本身无等号，key仅有code或state或其他
    ***/

    @TestCase
    func testOAuth20ServiceExtractAuthorization02(): Unit {
         var oauth20Service=OAuthServiceTest.getOAuth20Service()
         let redirectLocation01="${url}?code=codeValue&password=passwd#&code=codeValue02"
         let redirectLocation02="${url}?state=stateValue&password=passwd#&code=codeValue"
         let redirectLocation03="${url}?name=stateValue&password=passwd#&state=stateValue"
         var re_extractAuthorization01=oauth20Service.extractAuthorization(redirectLocation01)
         var re_extractAuthorization02=oauth20Service.extractAuthorization(redirectLocation02)
         var re_extractAuthorization03=oauth20Service.extractAuthorization(redirectLocation03)
         @Assert(re_extractAuthorization01.getCode(),URLEncoder.decode("codeValue","utf8"))
         @Assert(re_extractAuthorization01.getState(),"")
         @Assert(re_extractAuthorization02.getCode(),"")
         @Assert(re_extractAuthorization02.getState(),URLEncoder.decode("stateValue","utf8"))
         @Assert(re_extractAuthorization03.getCode(),"")
         @Assert(re_extractAuthorization03.getState(),"")
    }
    /***
        public func extractAuthorization(redirectLocation: String): OAuth2Authorization
        测试场景:redirectLocation包含字符'#',且包含?,有&,分割后所有值仅有一个=,且解码时异常，此处抛异常
    ***/

    @TestCase
    func testOAuth20ServiceExtractAuthorization03(): Unit {
         var oauth20Service=OAuthServiceTest.getOAuth20Service()
         let redirectLocation01="${url}?code=%2&state=stateValue#"
         let redirectLocation02="${url}?code=codeValue&state=%2#"
         let redirectLocation03="${url}?code=codeValue&name=%2#"
         var flag01=1
         try{
            oauth20Service.extractAuthorization(redirectLocation01)
         }catch(e:OAuth4cjException){
             println(e.toString())
             if(e.toString().contains("OAuth4cjException") && e.toString().contains("unsupported decoding.") && e.toString().contains("Incomplete trailing escape (%) pattern")){
                 flag01=0
             }
         }
         @Assert(flag01,0)
        var flag02=1
        try{
            oauth20Service.extractAuthorization(redirectLocation02)
        }catch(e:OAuth4cjException){
            println(e.toString())
            if(e.toString().contains("OAuth4cjException") && e.toString().contains("unsupported decoding.") && e.toString().contains("Incomplete trailing escape (%) pattern")){
                flag02=0
            }
        }
        @Assert(flag02,0)
        var flag03=1
        try{
            oauth20Service.extractAuthorization(redirectLocation03)
        }catch(e:OAuth4cjException){
            println(e.toString())
            if(e.toString().contains("OAuth4cjException") && e.toString().contains("unsupported decoding.") && e.toString().contains("Incomplete trailing escape (%) pattern")){
                flag03=0
            }
        }
        @Assert(flag03,1)
    }
    /***
        public func extractAuthorization(redirectLocation: String): OAuth2Authorization
        测试场景:redirectLocation包含字符'#',且包含?,有&,且分割后存在多个值无等号
    ***/

    @TestCase
    func testOAuth20ServiceExtractAuthorization04(): Unit {
         var oauth20Service=OAuthServiceTest.getOAuth20Service()
         let redirectLocation01="${url}?code=code01=codeValue&state=stateValue&password=passwd#code=code01"
         var re_extractAuthorization01=oauth20Service.extractAuthorization(redirectLocation01)
         @Assert(re_extractAuthorization01.getCode(),"")
         @Assert(re_extractAuthorization01.getState(),URLEncoder.decode("stateValue","utf8"))
    }
    /***
        public func extractAuthorization(redirectLocation: String): OAuth2Authorization
        测试场景:redirectLocation包含字符'#',且包含?,有&，且分割后存在一个值无等号
               场景2:&分割后存在相同的值
    ***/

    @TestCase
    func testOAuth20ServiceExtractAuthorization05(): Unit {
         var oauth20Service=OAuthServiceTest.getOAuth20Service()
         let redirectLocation01="${url}?code&state=stateValue&password=passwd#&code=code01"
         var re_extractAuthorization01=oauth20Service.extractAuthorization(redirectLocation01)
         @Assert(re_extractAuthorization01.getCode(),"")
         @Assert(re_extractAuthorization01.getState(),URLEncoder.decode("stateValue","utf8"))
    }
    @TestCase
    func testOAuth20ServiceExtractAuthorization0502(): Unit {
         var oauth20Service=OAuthServiceTest.getOAuth20Service()
         let redirectLocation01="${url}?code&state=stateValue&state=stateValue02#&&state=stateValue03"
         var re_extractAuthorization01=oauth20Service.extractAuthorization(redirectLocation01)
         @Assert(re_extractAuthorization01.getCode(),"")
         @Assert(re_extractAuthorization01.getState(),URLEncoder.decode("stateValue02","utf8"))
    }
    /***
        public func extractAuthorization(redirectLocation: String): OAuth2Authorization
        测试场景:redirectLocation包含字符'#',且包含?,无&
    ***/

    @TestCase
    func testOAuth20ServiceExtractAuthorization06(): Unit {
         var oauth20Service=OAuthServiceTest.getOAuth20Service()
         let redirectLocation01="${url}?code=codeValue#&state=stateValue"
         var re_extractAuthorization01=oauth20Service.extractAuthorization(redirectLocation01)
         @Assert(re_extractAuthorization01.getCode(),URLEncoder.decode("codeValue","utf8"))
         @Assert(re_extractAuthorization01.getState(),"")
    }
    /***
        public func extractAuthorization(redirectLocation: String): OAuth2Authorization
        测试场景:redirectLocation包含字符'#',无？
    ***/

    @TestCase
    func testOAuth20ServiceExtractAuthorization07(): Unit {
         var oauth20Service=OAuthServiceTest.getOAuth20Service()
         let redirectLocation01="${url}&code=codeValue#&state=stateValue"
         let redirectLocation02="${url}code=codeValue#&state=stateValue"
         var re_extractAuthorization01=oauth20Service.extractAuthorization(redirectLocation01)
         var re_extractAuthorization02=oauth20Service.extractAuthorization(redirectLocation02)
         @Assert(re_extractAuthorization01.getCode(),URLEncoder.decode("codeValue","utf8"))
         @Assert(re_extractAuthorization01.getState(),"")
         @Assert(re_extractAuthorization02.getCode(),"")
         @Assert(re_extractAuthorization02.getState(),"")
    }
    /***
        public func extractAuthorization(redirectLocation: String): OAuth2Authorization
        测试场景:redirectLocation无'#'
    ***/

    @TestCase
    func testOAuth20ServiceExtractAuthorization08(): Unit {
         var oauth20Service=OAuthServiceTest.getOAuth20Service()
         let redirectLocation01="${url}&code=codeValue&code=codeValue01&code=codeValue02"
         var re_extractAuthorization01=oauth20Service.extractAuthorization(redirectLocation01)
         @Assert(re_extractAuthorization01.getCode(),URLEncoder.decode("codeValue02","utf8"))
         @Assert(re_extractAuthorization01.getState(),"")
    }
}
func serve(): Unit {
    let serverSocket = TcpServerSocket(bindAt: 0)
    let server = ServerBuilder.new().listener(serverSocket).build()
    server.distributor.register("/index",
        {
        httpContext =>
        let resp = "Hello from /red".toUtf8Array()
        httpContext.responseBuilder.body(resp)
        return
    })
    spawn {server.serve()}
    sleep(Duration.second)
    port=serverSocket.localAddress.port
}