// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj

@Test
public class TestOAuth10aServiceB008{
    /***
        public func getApi(): DefaultApi10a
        测试场景：结果与构造器一致
    ***/
    @TestCase
    func testOAuth10aServiceGetApi01(): Unit {
         let exp_api=OAuthServiceTest.api_oauth10aService
         var oauth10aService=OAuthServiceTest.getOAuth10aService()
         var re_api=(oauth10aService.getApi() as SubDefaultApi10a).getOrThrow()
         @Assert(re_api==exp_api,true)
    }
}