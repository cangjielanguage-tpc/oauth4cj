// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj

@Test
public class TestOAuthServiceB008{
    /***
        public func execute(request: OAuth4cjRequest, callback: Option<OAuthAsyncRequestCallback>): Future<Any>
        测试场景:callback非Option<OAuthAsyncRequestCallback>.None,回调
    ***/
    @TestCase
    func testOAuthServiceExecute0202(): Unit {
         let oauth10aService=OAuthServiceTest.getOAuth10aService()
         var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
         var sub01=SubOAuthAsyncRequestCallback()
         var callback=Option<OAuthAsyncRequestCallback>.Some(sub01)
         try{
             oauth10aService.execute(oauth4cjRequest,callback)
             @Assert(sub01.getFlagOnCompleted(),"pass")
             @Assert(sub01.getFlagOnThrowable(),"fail")
         }catch(e:Exception){
             @Assert(sub01.getFlagOnThrowable(),"pass")
             @Assert(sub01.getFlagOnCompleted(),"fail")
         }
    }
}