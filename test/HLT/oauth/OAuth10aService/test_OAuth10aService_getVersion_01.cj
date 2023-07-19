// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
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