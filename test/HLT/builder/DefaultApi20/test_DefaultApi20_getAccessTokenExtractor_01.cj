// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestDefaultApi20B004{
    /***
        public func getAccessTokenExtractor(): TokenExtractor<OAuth2AccessToken>
        测试场景:构造器默认
    ***/
    @TestCase
    func testDefaultApi20GetAccessTokenExtractor01(): Unit {
        var subDefaultApi20=SubDefaultApi20()
        var accessTokenExtractor=subDefaultApi20.getAccessTokenExtractor()
        @Assert(accessTokenExtractor is OAuth2AccessTokenJsonExtractor, true)
        @Assert(accessTokenExtractor is TokenExtractor<OAuth2AccessToken>, true)
    }
}