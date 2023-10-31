// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj

@Test
public class TestOAuth2AccessTokenErrorResponseExceptionB004{
    /***
        public init(error: OAuth2Error, errorDescription: String, errorUrl: URL, rawResponse: Response)
        public func getError(): OAuth2Error
        测试场景:与构造器传入一致
    ***/
    @TestCase
    func testOAuth2AccessTokenErrorResponseGetError01(): Unit {
        var error=OAuth2Error.INVALID_REQUEST
        var url=URL.parse("https://www.baidu.com")
        var response=oauth4cj.OAuth4cjResponse(Int32(2),"message",HashMap<String,String>(),"body")
        var oAuth2AccessTokenErrorResponse=OAuth2AccessTokenErrorResponseException(error,"errorDescription",url,response)
        var re_error=oAuth2AccessTokenErrorResponse.getError().getOrThrow()
        @Assert(re_error.getErrorString(),error.getErrorString())
    }
    /***
        public init(error: OAuth2Error, errorDescription: String, errorUrl: URL, rawResponse: Response)
        public func getErrorDescription(): String
        测试场景:与构造器传入一致
    ***/
    @TestCase
    func testOAuth2AccessTokenErrorResponseGetErrorDescription01(): Unit {
        var error=OAuth2Error.INVALID_REQUEST
        var url=URL.parse("https://www.baidu.com")
        var response=oauth4cj.OAuth4cjResponse(Int32(2),"message",HashMap<String,String>(),"body")
        var oAuth2AccessTokenErrorResponse=OAuth2AccessTokenErrorResponseException(error,"errorDescription",url,response)
        for (str in strValues){
            oAuth2AccessTokenErrorResponse=OAuth2AccessTokenErrorResponseException(error,str,url,response)
            @Assert(oAuth2AccessTokenErrorResponse.getErrorDescription(),str)
        }
    }
    /***
        public init(error: OAuth2Error, errorDescription: String, errorUrl: URL, rawResponse: Response)
        public func getErrorUri(): URL
        测试场景:与构造器传入一致
    ***/
    @TestCase
    func testOAuth2AccessTokenErrorResponseGetErrorUri01(): Unit {
        var error=OAuth2Error.INVALID_REQUEST
        var url=URL.parse("https://www.baidu.com")
        var response=oauth4cj.OAuth4cjResponse(Int32(2),"message",HashMap<String,String>(),"body")
        var oAuth2AccessTokenErrorResponse=OAuth2AccessTokenErrorResponseException(error,"errorDescription",url,response)
        @Assert(oAuth2AccessTokenErrorResponse.getErrorUri().toString(),url.toString())
    }
}