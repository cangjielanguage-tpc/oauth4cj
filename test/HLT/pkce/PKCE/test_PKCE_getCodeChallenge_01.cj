// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj


@Test
public class TestPKCEB002{
    @TestCase
    func testPKCEgetCodeChallenge01(): Unit {
        var pkce=PKCE()
        @Assert(pkce.getCodeChallenge(),"")
    }
}