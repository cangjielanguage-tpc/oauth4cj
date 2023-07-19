// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj

@Test
public class TestOAuth20ServiceB008{
    /***
        public func getResponseType(): String
        测试场景:与构造器传入一致
    ***/

    @TestCase
    func testOAuth20ServiceGetResponseType01(): Unit {
         let oauth20Service=OAuthServiceTest.getOAuth20Service()
         let re_responseType=oauth20Service.getResponseType()
         let exp_responseType=OAuthServiceTest.responseType
         @Assert(re_responseType,exp_responseType)
    }
}