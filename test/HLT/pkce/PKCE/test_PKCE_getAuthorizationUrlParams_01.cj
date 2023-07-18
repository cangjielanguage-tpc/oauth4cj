// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestPKCEB002{
    /***
        未设置:code_challenge和code_challenge_method均未设置
    ***/
    @TestCase
    func testPKCEgetAuthorizationUrlParams01(): Unit {
        var pkce=PKCE()
        var exp_re=HashMap<String, String>([("code_challenge",""),("code_challenge_method","S256")])
        @Assert(pkce.getAuthorizationUrlParams(),exp_re)
    }
}