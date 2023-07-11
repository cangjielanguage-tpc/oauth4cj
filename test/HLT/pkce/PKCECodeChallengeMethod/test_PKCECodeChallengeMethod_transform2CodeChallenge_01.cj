// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj

@Test
public class TestPKCECodeChallengeMethodB002{
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
}