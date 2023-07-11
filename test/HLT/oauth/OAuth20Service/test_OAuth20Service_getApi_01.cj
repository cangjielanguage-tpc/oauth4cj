// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj

@Test
public class TestOAuth20ServiceB008{
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
}