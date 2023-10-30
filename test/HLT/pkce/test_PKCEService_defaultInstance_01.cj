// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj


@Test
public class TestPKCEServiceB002{
    @TestCase
    func testPKCEServicedefaultInstance01(): Unit {
        var pkceService=PKCEService.defaultInstance()
        var pkce01=pkceService.generatePKCE()
        @Assert(pkce01 is PKCE,true)
    }
    @TestCase
    func testPKCEServicegeneratePKCE01(): Unit {
        var pkceService01=PKCEService.defaultInstance()
        var pkceService02=PKCEService()
        var pkceService03=PKCEService(32)
        var pkce01=pkceService01.generatePKCE()
        var pkce02=pkceService02.generatePKCE()
        var pkce03=pkceService03.generatePKCE()
        @Assert(pkce01 is PKCE,true)
        @Assert(pkce02 is PKCE,true)
        @Assert(pkce03 is PKCE,true)
    }
    @TestCase
    func testPKCEServicegeneratePKCE02(): Unit {
        var flag=0
        try{
            PKCEService(-1)
        }catch(e:OAuth4cjException){
            if(e.toString().contains("OAuth4cjException: The number of octets cannot be negative")){
                flag=1
            }
        }
        @Assert(flag,1)
    }
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
    /***
        入参数组长度10000
    ***/
    @TestCase
    func testPKCEServicegeneratePKCEByArray02(): Unit {
        var pkceService01=PKCEService.defaultInstance()
        var pkceService02=PKCEService()
        var pkceService03=PKCEService(32)

        var arr1=getStringByLength(10000).toUtf8Array()
        var pkce01=pkceService01.generatePKCE(arr1)
        var pkce02=pkceService02.generatePKCE(arr1)
        var pkce03=pkceService03.generatePKCE(arr1)
        @Assert(pkce01.getCodeChallenge(),pkce02.getCodeChallenge())
        @Assert(pkce01.getCodeChallenge(),pkce03.getCodeChallenge())
    }
    /***
        普通数组
    ***/
    @TestCase
    func testPKCEServicegeneratePKCEByArray03(): Unit {
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