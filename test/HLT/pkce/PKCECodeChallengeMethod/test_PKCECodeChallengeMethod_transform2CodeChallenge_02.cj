// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj


@Test
public class TestPKCECodeChallengeMethodB002{
    /***
        调用源PKCECodeChallengeMethod.PLAIN
    ***/
    @TestCase
    func testPKCECodeChallengeMethodTransform2CodeChallenge02(): Unit {
        var codeChallengeMethod_PLAIN=PKCECodeChallengeMethod.PLAIN
        var re=""
        var exp_re=""
        for (str in strValues){
            re=codeChallengeMethod_PLAIN.transform2CodeChallenge(str)
            @Assert(re,str)
        }
    }
}