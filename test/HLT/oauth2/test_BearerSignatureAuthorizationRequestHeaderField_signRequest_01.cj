// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj


@Test
public class TestBearerSignatureAuthorizationRequestHeaderFieldB004{
    /***
        public func signRequest(accessToken: String, request: OAuth4cjRequest): Unit
        测试场景:添加Authorization Request Header,正常添加即可
    ***/
    @TestCase
    func testBearerSignatureAuthorizationRequestHeaderFieldSignRequest01(): Unit {
        var bearerSignatureAuthorizationRequestHeaderField=BearerSignatureAuthorizationRequestHeaderField.instance()
        var oauth4cjRequest=OAuth4cjRequest(Verb.POST,"https://www.baidu.com")
        var exp_headers=HashMap<String,String>()
        var re=HashMap<String,String>()
        for (str in strValues){
            exp_headers.put("Authorization","Bearer "+str)

            bearerSignatureAuthorizationRequestHeaderField.signRequest(str,oauth4cjRequest)
            re=oauth4cjRequest.getHeaders()
            @Assert(exp_headers,re)
        }
    }
    /***
        public func signRequest(accessToken: String, request: OAuth4cjRequest): Unit
        测试场景:添加URI Query OAuth4cjParameter,正常添加即可
    ***/
    @TestCase
    func testBearerSignatureURIQueryParameterSignRequest01(): Unit {
        var bearerSignatureURIQueryParameter=BearerSignatureURIQueryParameter.instance()
        var oauth4cjRequest=OAuth4cjRequest(Verb.POST,"https://www.baidu.com")
        var exp_params=HashMap<String,String>()
        var param_list=ParameterList()
        for (str in strValues){
            exp_params.put("access_token",str)

            oauth4cjRequest=OAuth4cjRequest(Verb.POST,"https://www.baidu.com")
            bearerSignatureURIQueryParameter.signRequest(str,oauth4cjRequest)
            param_list=oauth4cjRequest.getQueryStringParams()
            @Assert(param_list.asFormUrlEncodedString(),ParameterList(exp_params).asFormUrlEncodedString())
            param_list=oauth4cjRequest.getBodyParams()
            @Assert(param_list.asFormUrlEncodedString(),"")
        }
    }
    /***
        public func addClientAuthentication(request: OAuth4cjRequest, apiKey: String, apiSecret: String): Unit
        测试场景:Http Basic authentication scheme.添加请求头：Authorization
    ***/
    @TestCase
    func testHttpBasicAuthenticationSchemeAddClientAuthentication01(): Unit {
        var httpBasicAuthenticationScheme=HttpBasicAuthenticationScheme.instance()
        var oauth4cjRequest=OAuth4cjRequest(Verb.POST,"https://www.baidu.com")
        var exp_headers=HashMap<String,String>()
        var re=HashMap<String,String>()
        var str_encoding_before=""
        var str_encoding_after=""
        for (str in strValues){
            str_encoding_before=str+":"+str
            str_encoding_after=Base64Utils.encode(str_encoding_before.toArray())
            exp_headers.put("Authorization","Basic "+str_encoding_after)

            httpBasicAuthenticationScheme.addClientAuthentication(oauth4cjRequest,str,str)
            re=oauth4cjRequest.getHeaders()
            @Assert(re,exp_headers)
        }
    }
    /***
        public func addClientAuthentication(request: OAuth4cjRequest, apiKey: String, apiSecret: String): Unit
        测试场景:Http Basic authentication scheme.添加请求头：Authorization
    ***/
    @TestCase
    func testRequestBodyAuthenticationSchemeAddClientAuthentication01(): Unit {
        var requestBodyAuthenticationScheme=RequestBodyAuthenticationScheme.instance()
        var oauth4cjRequest=OAuth4cjRequest(Verb.POST,"https://www.baidu.com")
        var exp_headers=HashMap<String,String>()
        var param_list=ParameterList(HashMap<String,String>())
        for (str in strValues){
            exp_headers.put("client_id",str)
            exp_headers.put("client_secret",str)

            oauth4cjRequest=OAuth4cjRequest(Verb.POST,"https://www.baidu.com")

            requestBodyAuthenticationScheme.addClientAuthentication(oauth4cjRequest,str,str)
            param_list=oauth4cjRequest.getQueryStringParams()
            @Assert(param_list.asFormUrlEncodedString(),"")

            param_list=oauth4cjRequest.getBodyParams()
            @Assert(param_list.asFormUrlEncodedString(),ParameterList(exp_headers).asFormUrlEncodedString())
        }
    }
    /***
        public func addClientAuthentication(request: OAuth4cjRequest, apiKey: String, apiSecret: String): Unit
        测试场景:Http Basic authentication scheme.添加请求头：Authorization
    ***/
    @TestCase
    func testRequestBodyAuthenticationSchemeAddClientAuthentication02(): Unit {
        var requestBodyAuthenticationScheme=RequestBodyAuthenticationScheme.instance()
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        var exp_headers=HashMap<String,String>()
        var param_list=ParameterList(HashMap<String,String>())
        for (str in strValues){
            exp_headers.put("client_id",str)
            exp_headers.put("client_secret",str)
            oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")

            requestBodyAuthenticationScheme.addClientAuthentication(oauth4cjRequest,str,str)
            param_list=oauth4cjRequest.getQueryStringParams()
            @Assert(param_list.asFormUrlEncodedString(),ParameterList(exp_headers).asFormUrlEncodedString())

            param_list=oauth4cjRequest.getBodyParams()
            @Assert(param_list.asFormUrlEncodedString(),"")
        }
    }
    /***
        public func getValue(): String
        测试场景:获取枚举token的内容
    ***/
    @TestCase
    func testOAuth2ErrorgetErrorString01(): Unit {
        var errStrs=Array<String>(["invalid_request","unauthorized_client","access_denied","unsupported_response_type",
                                   "invalid_scope","server_error","temporarily_unavailable","invalid_client",
                                   "invalid_grant","unsupported_grant_type","invalid_token","insufficient_scope",
                                   "unsupported_token_type","authorization_pending","slow_down","expired_token"])
        var errs=Array<OAuth2Error>([ OAuth2Error.INVALID_REQUEST,
                                        OAuth2Error.UNAUTHORIZED_CLIENT,
                                        OAuth2Error.ACCESS_DENIED,
                                        OAuth2Error.UNSUPPORTED_RESPONSE_TYPE,
                                        OAuth2Error.INVALID_SCOPE,
                                        OAuth2Error.SERVER_ERROR,
                                        OAuth2Error.TEMPORARILY_UNAVAILABLE,
                                        OAuth2Error.INVALID_CLIENT,
                                        OAuth2Error.INVALID_GRANT,
                                        OAuth2Error.UNSUPPORTED_GRANT_TYPE,
                                        OAuth2Error.INVALID_TOKEN,
                                        OAuth2Error.INSUFFICIENT_SCOPE,
                                        OAuth2Error.UNSUPPORTED_TOKEN_TYPE,
                                        OAuth2Error.AUTHORIZATION_PENDING,
                                        OAuth2Error.SLOW_DOWN,
                                        OAuth2Error.EXPIRED_TOKEN])


        var res=""
        for (i in 0..errs.size){
            res=errs[i].getErrorString()
            @Assert(res,errStrs[i])
        }
    }
    /***
        public static func parseFrom(errorString: String): OAuth2Error
        测试场景:字符串是否是枚举值对应的errorString-是-返回字枚举值对象
    ***/
    @TestCase
    func testOAuth2ErrorparseFrom01(): Unit {
        var errStrs=Array<String>(["invalid_request","unauthorized_client","access_denied","unsupported_response_type",
                                   "invalid_scope","server_error","temporarily_unavailable","invalid_client",
                                   "invalid_grant","unsupported_grant_type","invalid_token","insufficient_scope",
                                   "unsupported_token_type","authorization_pending","slow_down","expired_token"])
        var res=""
        for (i in errStrs){
            res=OAuth2Error.parseFrom(i).getErrorString()
            @Assert(res,i)
        }
    }
    /***
        public static func parseFrom(errorString: String): OAuth2Error
        测试场景:字符串是否是枚举值对应的errorString-否-抛异常
    ***/
    @TestCase
    func testOAuth2ErrorparseFrom02(): Unit {
        var flag=1
        for (i in strValues){
            flag=1
            try{
                OAuth2Error.parseFrom(i)
            }catch(e:IllegalArgumentException){
                if(e.toString().contains("IllegalArgumentException") && e.toString().contains("there is no knowlege about ${i} Error")){
                    flag=0
                }
            }
            @Assert(flag,0)
        }
    }
}