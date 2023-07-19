// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestPKCEServiceB002{
    @TestCase
    func testPKCEServicedefaultInstance01(): Unit {
        var pkceService=PKCEService.defaultInstance()
        var pkce01=pkceService.generatePKCE()
        @Assert(pkce01 is PKCE,true)
    }
}