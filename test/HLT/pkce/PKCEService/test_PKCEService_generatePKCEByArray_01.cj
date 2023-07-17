// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestPKCEServiceB002{
    /***
        入参数组为空
    ***/
    @TestCase
    func testPKCEServicegeneratePKCEByArray01(): Unit {
        var pkceService01=PKCEService.defaultInstance()
        var pkceService02=PKCEService()
        var pkceService03=PKCEService(32)
        var arr1=Array<UInt8>()
        var pkce01=pkceService01.generatePKCE(arr1)
        var pkce02=pkceService02.generatePKCE(arr1)
        var pkce03=pkceService03.generatePKCE(arr1)
        @Assert(pkce01.getCodeChallenge(),pkce02.getCodeChallenge())
        @Assert(pkce01.getCodeChallenge(),pkce03.getCodeChallenge())
    }
}