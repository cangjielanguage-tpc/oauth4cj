// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj

@Test
public class TestOAuth2AccessTokenJsonExtractorB004{
    /***
        public func extract(response: Response): OAuth2AccessToken
        测试场景:response中body为空
    ***/
    @TestCase
    func testOAuth2AccessTokenJsonExtractorExtract01(): Unit {

        var oAuth2AccessTokenJsonExtractor02=OAuth2AccessTokenJsonExtractor.instance()
        var response01=oauth4cj.OAuth4cjResponse(Int32(2),"message",HashMap<String,String>(),"")
        var flag=1
        try{
            oAuth2AccessTokenJsonExtractor02.extract(response01)
        }catch(e:IllegalArgumentException){
            if(e.toString().contains("Response body is incorrect. Can't extract a token from an empty string")){
                flag=0
            }
        }
        @Assert(flag,0)
    }
    /***
        public func extract(response: Response): OAuth2AccessToken
        测试场景:responseCode=200,response中body非空,且校验参数均包含
    ***/
    @TestCase
    func testOAuth2AccessTokenJsonExtractorExtract02(): Unit {
        var oAuth2AccessTokenJsonExtractor02=OAuth2AccessTokenJsonExtractor.instance()
        var body=###"{
"error_uri":"http://www.baidu.com",
"error":"slow_down",
"error_description":"error_description",
"expires_in":"expires_in",
"token_type":"token_type",
"refresh_token":"refresh_token",
"scope":"scope",
"access_token":"access_token"}"###
        var response01=oauth4cj.OAuth4cjResponse(Int32(200),"message",HashMap<String,String>(),body)
        var re02=oAuth2AccessTokenJsonExtractor02.extract(response01)
        @Assert(re02.getAccessToken(),"access_token")
        @Assert(re02.getTokenType(),"token_type")
        @Assert(re02.getExpiresIn(),Int32(0))
        @Assert(re02.getRefreshToken(),"refresh_token")
        @Assert(re02.getScope(),"scope")
    }
    /***
        public func extract(response: Response): OAuth2AccessToken
        测试场景:responseCode=200,response中body非空,且包含access_token，但不包含expires_in,refresh_token,scope,token_type
    ***/
    @TestCase
    func testOAuth2AccessTokenJsonExtractorExtract0201(): Unit {
        var oAuth2AccessTokenJsonExtractor02=OAuth2AccessTokenJsonExtractor.instance()
        var body=###"{
"error_uri":"http://www.baidu.com",
"error":"slow_down",
"error_description":"error_description",
"access_token":"access_token"}"###
        var response01=oauth4cj.OAuth4cjResponse(Int32(200),"message",HashMap<String,String>(),body)
        var re02=oAuth2AccessTokenJsonExtractor02.extract(response01)

        @Assert(re02 is OAuth2AccessToken,true)
        @Assert(re02.getAccessToken(),"access_token")
        @Assert(re02.getTokenType(),"")
        @Assert(re02.getExpiresIn(),Int32(0))
        @Assert(re02.getRefreshToken(),"")
        @Assert(re02.getScope(),"")
    }
    /***
        public func extract(response: Response): OAuth2AccessToken
        测试场景:response中body非空,但是responseCode=200,不包含access_token，包含其他
    ***/
    @TestCase
    func testOAuth2AccessTokenJsonExtractorExtract03(): Unit {
        var oAuth2AccessTokenJsonExtractor02=OAuth2AccessTokenJsonExtractor.instance()
        var body=###"{
"error_uri":"http://www.baidu.com",
"error":"slow_down",
"error_description":"error_description",
"expires_in":2,
"token_type":"token_type",
"refresh_token":"refresh_token",
"scope":"scope"}"###
        var response01=oauth4cj.OAuth4cjResponse(Int32(200),"message",HashMap<String,String>(),body)

        var flag=1
        try{
            oAuth2AccessTokenJsonExtractor02.extract(response01)
        }catch(e:OAuth4cjException){
            if(e.toString().contains("Response body is incorrect. Can't extract a '" + "access_token" + "' from this: '" + body + "'")){
                flag=0
            }
        }
        @Assert(flag,0)
    }
    /***
        public func extract(response: Response): OAuth2AccessToken
        测试场景:responseCode!=200,response中body非空
    ***/
    @TestCase
    func testOAuth2AccessTokenJsonExtractorExtract04(): Unit {
        var oAuth2AccessTokenJsonExtractor02=OAuth2AccessTokenJsonExtractor.instance()
        var body=###"{
"error_uri":"http://www.baidu.com",
"error":"slow_down",
"error_description":"error_description",
"expires_in":"expires_in",
"token_type":"token_type",
"refresh_token":"refresh_token",
"scope":"scope",
"access_token":"access_token"}"###
        var response01=oauth4cj.OAuth4cjResponse(Int32(201),"message",HashMap<String,String>(),body)
        var flag=1
        try{
            oAuth2AccessTokenJsonExtractor02.extract(response01)
        }catch(e:OAuth2AccessTokenErrorResponseException){//这里只验证到抛异常，具体异常信息在generateError逻辑中验证
            println(e.toString())
            flag=0
        }
        @Assert(flag,0)
    }
    /***
        public func generateError(response: Response): Unit
        测试场景:response中body不为空，但无法解析成json字符串
    ***/
    @TestCase
    func testOAuth2AccessTokenJsonExtractorGenerateError01(): Unit {
        var oAuth2AccessTokenJsonExtractor02=OAuth2AccessTokenJsonExtractor.instance()
        var response01=oauth4cj.OAuth4cjResponse(Int32(2),"message",HashMap<String,String>(),"value")
        var flag=1
        try{
            oAuth2AccessTokenJsonExtractor02.generateError(response01)
        }catch(e:OAuth2AccessTokenErrorResponseException){
            flag=0
            var error_re=e.getResponse().toString()
            var error_exp=response01.toString()
            @Assert(error_exp,error_re)
        }
        @Assert(flag,0)
    }
    /***
        public func generateError(response: Response): Unit
        测试场景:response中body不为空，且可解析成json字符串,且不包含key("error_uri")
    ***/
    @TestCase
    func testOAuth2AccessTokenJsonExtractorGenerateError02(): Unit {
        var oauth2AccessTokenJsonExtractor02=OAuth2AccessTokenJsonExtractor.instance()
        var response01=oauth4cj.OAuth4cjResponse(Int32(2),"message",HashMap<String,String>(),"true")
        var flag=1
        try{
            oauth2AccessTokenJsonExtractor02.generateError(response01)
        }catch(e:OAuth2AccessTokenErrorResponseException){
            flag=0
            var error_uri=e.getErrorUri().toString()
            @Assert(error_uri,"")
        }
        @Assert(flag,0)
    }
    /***
        public func generateError(response: Response): Unit
        测试场景:response中body不为空，且可解析成json字符串,且包含key("error_uri"),不包含("error")
    ***/
    @TestCase
    func testOAuth2AccessTokenJsonExtractorGenerateError0301(): Unit {
        var oauth2AccessTokenJsonExtractor02=OAuth2AccessTokenJsonExtractor.instance()
        var response01=oauth4cj.OAuth4cjResponse(Int32(2),"message",HashMap<String,String>(),"error_uri:http://www.baidu.com")
        var flag=1
        try{
            oauth2AccessTokenJsonExtractor02.generateError(response01)
        }catch(e:OAuth2AccessTokenErrorResponseException){
            try{
                e.getError().getOrThrow()
            }catch(e:NoneValueException){
                flag=0
            }
        }
        @Assert(flag,0)
    }
    /***
        public func generateError(response: Response): Unit
        测试场景:response中body不为空，且可解析成json字符串,且包含key("error_uri"),包含("error"),但error对应的value不是error对应的信息
    ***/
    @TestCase
    func testOAuth2AccessTokenJsonExtractorGenerateError04(): Unit {
        var oauth2AccessTokenJsonExtractor02=OAuth2AccessTokenJsonExtractor.instance()
        var body=###"{
"error_uri":"http://www.baidu.com",
"error":"slow_123_down",
"error_description":"error_description",
"expires_in":"expires_in",
"token_type":"token_type",
"refresh_token":"refresh_token",
"scope":"scope",
"access_token":"access_token"}"###
        var response01=oauth4cj.OAuth4cjResponse(Int32(2),"message",HashMap<String,String>(),body)
        var flag=1
        try{
            oauth2AccessTokenJsonExtractor02.generateError(response01)
        }catch(e:OAuth2AccessTokenErrorResponseException){
            try{
                e.getError().getOrThrow()
            }catch(e:NoneValueException){
                flag=0
            }
        }
        @Assert(flag,0)
    }
    /***
        public func generateError(response: Response): Unit
        测试场景:
        response中body不为空，且可解析成json字符串,
        且包含key("error_uri"),
        包含("error"),但是error信息是OAuth2Error的errorString,
        但是key不包含error_description
    ***/
    @TestCase
    func testOAuth2AccessTokenJsonExtractorGenerateError05(): Unit {
        var oAuth2AccessTokenJsonExtractor02=OAuth2AccessTokenJsonExtractor.instance()
        var body=###"{
"error_uri":"http://www.baidu.com",
"error":"slow_down",
"expires_in":"expires_in",
"token_type":"token_type",
"refresh_token":"refresh_token",
"scope":"scope",
"access_token":"access_token"}"###
        var response01=oauth4cj.OAuth4cjResponse(Int32(2),"message",HashMap<String,String>(),body)
        var flag=1
        try{
            oAuth2AccessTokenJsonExtractor02.generateError(response01)
        }catch(e:OAuth2AccessTokenErrorResponseException){
            flag=0
            var error=e.getError().getOrThrow()
            @Assert(error.getErrorString(),"slow_down")
        }
        @Assert(flag,0)
    }
    /***
        public func generateError(response: Response): Unit
        测试场景:
        response中body不为空，且可解析成json字符串,
        且包含key("error_uri"),包含("error"),
        但是error信息是OAuth2Error的errorString,但是key包含error_description
    ***/
    @TestCase
    func testOAuth2AccessTokenJsonExtractorGenerateError06(): Unit {
        var oauth2AccessTokenJsonExtractor02=OAuth2AccessTokenJsonExtractor.instance()
        var body=###"{
"error_uri":"http://www.baidu.com",
"error":"slow_down",
"error_description":"error_description",
"expires_in":"expires_in",
"token_type":"token_type",
"refresh_token":"refresh_token",
"scope":"scope",
"access_token":"access_token"}"###
        var response01=oauth4cj.OAuth4cjResponse(Int32(2),"message",HashMap<String,String>(),body)
        var flag=1
        try{
            oauth2AccessTokenJsonExtractor02.generateError(response01)
        }catch(e:OAuth2AccessTokenErrorResponseException){
            flag=0
            var error_description=e.getErrorDescription()
            @Assert(error_description,"error_description")
        }
        @Assert(flag,0)
    }
}