// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj


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
    /***
        未设置:仅code_challenge未设置
    ***/
    @TestCase
    func testPKCEgetAuthorizationUrlParams02(): Unit {
        var pkce=PKCE()
        pkce.setCodeChallenge("codeChallenge")
        var exp_re=HashMap<String, String>([("code_challenge","codeChallenge"),("code_challenge_method","S256")])
        @Assert(pkce.getAuthorizationUrlParams(),exp_re)
    }
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
    @TestCase
    func testPKCEgetCodeChallenge01(): Unit {
        var pkce=PKCE()
        @Assert(pkce.getCodeChallenge(),"")
    }
    @TestCase
    func testPKCEgetCodeChallengeMethod01(): Unit {
        var pkce=PKCE()
        @Assert(pkce.getCodeChallengeMethod().toString(),PKCECodeChallengeMethod.S256.toString())
    }
    @TestCase
    func testPKCEgetCodeVerifier01(): Unit {
        var pkce=PKCE()
        @Assert(pkce.getCodeVerifier(),"")
    }
    /***
        单次设置，设置值为常见字符串类型
    ***/
    @TestCase
    func testPKCEsetCodeChallenge01(): Unit {
        var pkce=PKCE()
        for(str in strValues){
            pkce=PKCE()
            pkce.setCodeChallenge(str)
            @Assert(pkce.getCodeChallenge(),str)
        }
    }
    /***
        多次设置，设置值为常见字符串类型
    ***/
    @TestCase
    func testPKCEsetCodeChallenge02(): Unit {
        var pkce=PKCE()
        for(str in strValues){
            pkce.setCodeChallenge(str)
            @Assert(pkce.getCodeChallenge(),str)
        }
    }
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
        /***
            多次设置
        ***/
    @TestCase
    func testPKCEsetCodeChallengeMethod02(): Unit {
        var pkce=PKCE()
        pkce.setCodeChallengeMethod(PKCECodeChallengeMethod.PLAIN)
        @Assert(pkce.getCodeChallengeMethod().toString(),PKCECodeChallengeMethod.PLAIN.toString())
        pkce.setCodeChallengeMethod(PKCECodeChallengeMethod.S256)
        @Assert(pkce.getCodeChallengeMethod().toString(),PKCECodeChallengeMethod.S256.toString())
    }
    /***
        单次设置，设置值为常见字符串类型
    ***/
    @TestCase
    func testPKCEsetCodeVerifier01(): Unit {
        var pkce=PKCE()
        for(str in strValues){
            pkce=PKCE()
            pkce.setCodeVerifier(str)
            @Assert(pkce.getCodeVerifier(),str)
        }
    }
    /***
        多次设置，设置值为常见字符串类型
    ***/
    @TestCase
    func testPKCEsetCodeVerifier02(): Unit {
        var pkce=PKCE()
        for(str in strValues){
            pkce.setCodeVerifier(str)
            @Assert(pkce.getCodeVerifier(),str)
        }
    }
}