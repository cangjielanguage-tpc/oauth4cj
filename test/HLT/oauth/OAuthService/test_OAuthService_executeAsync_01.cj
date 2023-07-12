// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj

@Test
public class TestOAuthServiceB008{
    /***
        public func executeAsync(request: OAuth4cjRequest): Future<Any>
        测试场景: 执行请求成功
    ***/
    @TestCase
    func testOAuthServiceExecuteAsync01(): Unit {
         let oauth10aService=OAuthServiceTest.getOAuth10aService()
         var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com/")
         let response_any=oauth10aService.executeAsync(oauth4cjRequest).get()
         let response= (response_any as oauth4cj.model.Response).getOrThrow()
         @Assert(response.getCode(),200)
    }
}
