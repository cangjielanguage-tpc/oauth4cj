// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj

@Test
public class TestOAuthServiceB008{
    /***
        public open func isClosed(): Bool
        测试场景:默认false
    ***/
    @TestCase
    func testOAuthServiceTIsClosed01(): Unit {
         var oauth10aService=OAuthServiceTest.getOAuth10aService()
         var re_isClosed=oauth10aService.isClosed()
         @Assert(re_isClosed,false)
    }
    @TestCase
    func testOAuthServiceTIsClosed02(): Unit {
         var oauth20Service=OAuthServiceTest.getOAuth20Service()
         var re_isClosed=oauth20Service.isClosed()
         @Assert(re_isClosed,false)
    }
}