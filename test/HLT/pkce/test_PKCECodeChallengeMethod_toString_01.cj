// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj


@Test
public class TestPKCECodeChallengeMethodB002{
    @TestCase
    func testPKCECodeChallengeMethodToString01(): Unit {
        @Assert(PKCECodeChallengeMethod.S256.toString(),"S256")
        @Assert(PKCECodeChallengeMethod.PLAIN.toString(),"PLAIN")
    }
    /***
        调用源PKCECodeChallengeMethod.S256
    ***/
    @TestCase
    func testPKCECodeChallengeMethodTransform2CodeChallenge01(): Unit {
        var codeChallengeMethod_S256=PKCECodeChallengeMethod.S256
        var re=""
        var exp_re=""
        var temp= Array<UInt8>(32,item:0)
        strValues=Array<String>([strEmpty,getStringByLength(1000),strBlank,strCommon])
        for (str in strValues){
            re=codeChallengeMethod_S256.transform2CodeChallenge(str)
            sha256(str.toUtf8Array(),temp)
            exp_re=Base64Utils.encodeUrlWithoutPadding(temp)
            @Assert(re,exp_re)
        }
    }
    /***
        调用源PKCECodeChallengeMethod.PLAIN
    ***/
    @TestCase
    func testPKCECodeChallengeMethodTransform2CodeChallenge02(): Unit {
        var codeChallengeMethod_PLAIN=PKCECodeChallengeMethod.PLAIN
        var re=""
        for (str in strValues){
            re=codeChallengeMethod_PLAIN.transform2CodeChallenge(str)
            @Assert(re,str)
        }
    }
}