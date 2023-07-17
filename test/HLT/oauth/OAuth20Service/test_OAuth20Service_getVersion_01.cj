// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj

@Test
public class TestOAuth20ServiceB008{
    /***
        public func getVersion(): String
        测试场景:默认值
    ***/

    @TestCase
    func testOAuth20ServiceGetVersion01(): Unit {
         var oauth20Service=OAuthServiceTest.getOAuth20Service()
         var re_Version=oauth20Service.getVersion()
         @Assert(re_Version,"2.0")
    }
}