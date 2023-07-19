// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj

let exp_api=OAuthServiceTest.api_oauth10aService
var oauth10aService=OAuthServiceTest.getOAuth10aService()
@Test
public class TestOAuth10aServiceB008{
    /***
        public func signRequest(token: OAuth1AccessToken, request: OAuth4cjRequest): Unit
        测试场景:请求加签后，对应参数添加正常
    ***/
    @TestCase
    func testOAuth10aServiceSignRequest01(): Unit {
         let token=OAuth1AccessToken("token","tokenSecret","rawResponse")
         let request=OAuth4cjRequest(Verb.POST,"http://www.baidu.com")
         oauth10aService.signRequest(token,request)
         var re_OAuthParams=request.getOauthParameters()
         var re_Headers=request.getHeaders()
         var exp_OAuthParams=HashMap<String,String>()
         exp_OAuthParams.put(OAuthConstants.TOKEN,token.getToken())
         exp_OAuthParams.put(OAuthConstants.TIMESTAMP,re_OAuthParams.get("${OAuthConstants.TIMESTAMP}").getOrThrow())
         exp_OAuthParams.put(OAuthConstants.NONCE,re_OAuthParams.get("${OAuthConstants.NONCE}").getOrThrow())
         exp_OAuthParams.put(OAuthConstants.CONSUMER_KEY,oauth10aService.getApiKey())
         exp_OAuthParams.put(OAuthConstants.SIGN_METHOD,exp_api.getSignatureService().getSignatureMethod())
         exp_OAuthParams.put(OAuthConstants.VERSION,oauth10aService.getVersion())
         exp_OAuthParams.put(OAuthConstants.SCOPE,OAuthServiceTest.scope_oauth10aService.getOrThrow())
         exp_OAuthParams.put(OAuthConstants.SIGNATURE,re_OAuthParams.get("${OAuthConstants.SIGNATURE}").getOrThrow())
         var exp_oauthHeader=HashMap<String,String>()
         exp_oauthHeader.put(OAuthConstants.HEADER_AUTHORIZATION, exp_api.getHeaderExtractor().extract(request))

         @Assert(re_OAuthParams,exp_OAuthParams)
         for (key in re_Headers.keys()){
             println(key)
         }
         @Assert(re_Headers,exp_oauthHeader)
    }
}

public func getSignature(request:OAuth4cjRequest, tokenSecret:String):String{
    let baseString = exp_api.getBaseStringExtractor().extract(request)
    let signature  = exp_api.getSignatureService().getSignature(baseString, oauth10aService.getApiSecret(), tokenSecret)
    return signature
}