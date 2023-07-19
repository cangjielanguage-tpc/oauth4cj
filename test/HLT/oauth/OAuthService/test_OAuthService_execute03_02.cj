// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj

@Test
public class TestOAuthServiceB008{
    /***
        public func execute(request: OAuth4cjRequest, callback: Option<OAuthAsyncRequestCallback>,converter: Option<ResponseConverter>): Future<Any>
        测试场景:converter非Option<ResponseConverter>.None
    ***/
    @TestCase
    func testOAuthServiceExecute0302(): Unit {
         let oauth10aService=OAuthServiceTest.getOAuth10aService()
         var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
         var sub01=SubOAuthAsyncRequestCallback()
         var callback=Option<OAuthAsyncRequestCallback>.Some(sub01)
         let subResponseConverter=SubResponseConverter()
         var converter=Option<ResponseConverter>.Some(subResponseConverter)
         try{
             oauth10aService.execute(oauth4cjRequest,callback,converter)
             @Assert(sub01.getFlagOnCompleted(),"pass")
             @Assert(sub01.getFlagOnThrowable(),"fail")
         }catch(e:Exception){
             @Assert(sub01.getFlagOnCompleted(),"fail")
             @Assert(sub01.getFlagOnThrowable(),"fail")
         }
    }
}
