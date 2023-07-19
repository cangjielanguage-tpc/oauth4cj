// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj

@Test
public class TestOAuthServiceB008{
    /***
        public func execute(request: OAuth4cjRequest, callback: Option<OAuthAsyncRequestCallback>): Future<Any>
        测试场景:callback为Option<OAuthAsyncRequestCallback>.None,不回调
    ***/
    @TestCase
    func testOAuthServiceExecute01(): Unit {
         let oauth10aService=OAuthServiceTest.getOAuth10aService()
         var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com/")
         var callback=Option<OAuthAsyncRequestCallback>.None
         let fut_response=oauth10aService.execute(oauth4cjRequest,callback)
         let response_any=fut_response.get()
         let response=(response_any as oauth4cj.model.Response).getOrThrow()
         @Assert(response.getCode(),200)
    }
}

