// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
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