// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj


@Test
public class TestPKCEB002{
    /***
        设置:code_challenge和code_challenge_method均设置
    ***/
    @TestCase
    func testPKCEgetAuthorizationUrlParams04(): Unit {
        var pkce=PKCE()
        pkce.setCodeChallenge("codeChallenge")
        pkce.setCodeChallengeMethod(PKCECodeChallengeMethod.PLAIN)
        var exp_re=HashMap<String, String>([("code_challenge","codeChallenge"),("code_challenge_method","PLAIN")])
        @Assert(pkce.getAuthorizationUrlParams(),exp_re)
    }
}