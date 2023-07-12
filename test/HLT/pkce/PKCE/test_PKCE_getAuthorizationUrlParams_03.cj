// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj


@Test
public class TestPKCEB002{
    /***
        未设置:仅code_challenge_method未设置
    ***/
    @TestCase
    func testPKCEgetAuthorizationUrlParams03(): Unit {
        var pkce=PKCE()
        pkce.setCodeChallengeMethod(PKCECodeChallengeMethod.PLAIN)
        var exp_re=HashMap<String, String>([("code_challenge",""),("code_challenge_method","PLAIN")])
        @Assert(pkce.getAuthorizationUrlParams(),exp_re)
    }
}