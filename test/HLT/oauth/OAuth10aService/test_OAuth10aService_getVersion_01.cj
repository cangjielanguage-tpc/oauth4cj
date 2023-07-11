// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj

@Test
public class TestOAuth10aServiceB008{
    /***
        public func getVersion(): String
        测试场景:默认值
    ***/

    @TestCase
    func testOAuth10aServiceGetVersion01(): Unit {
         var oauth10aService=OAuthServiceTest.getOAuth10aService()
         var re_Version=oauth10aService.getVersion()
         @Assert(re_Version,"1.0")
    }
}