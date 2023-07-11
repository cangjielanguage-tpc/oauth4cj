// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj


@Test
public class TestPKCEServiceB002{
    /***
        普通数组
    ***/
    @TestCase
    func testPKCEServicegeneratePKCEByArray02(): Unit {
        var pkceService01=PKCEService.defaultInstance()
        var pkceService02=PKCEService()
        var pkceService03=PKCEService(32)

        var arr1="hello cangjie".toUtf8Array()
        var pkce01=pkceService01.generatePKCE(arr1)
        var pkce02=pkceService02.generatePKCE(arr1)
        var pkce03=pkceService03.generatePKCE(arr1)
        @Assert(pkce01.getCodeChallenge(),pkce02.getCodeChallenge())
        @Assert(pkce01.getCodeChallenge(),pkce03.getCodeChallenge())
    }
}