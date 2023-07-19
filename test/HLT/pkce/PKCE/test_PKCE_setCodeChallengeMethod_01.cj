// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestPKCEB002{
        /***
            单次设置
        ***/
    @TestCase
    func testPKCEsetCodeChallengeMethod01(): Unit {
        var pkce=PKCE()
        pkce.setCodeChallengeMethod(PKCECodeChallengeMethod.PLAIN)
        @Assert(pkce.getCodeChallengeMethod().toString(),PKCECodeChallengeMethod.PLAIN.toString())
        pkce=PKCE()
        pkce.setCodeChallengeMethod(PKCECodeChallengeMethod.S256)
        @Assert(pkce.getCodeChallengeMethod().toString(),PKCECodeChallengeMethod.S256.toString())
    }
}