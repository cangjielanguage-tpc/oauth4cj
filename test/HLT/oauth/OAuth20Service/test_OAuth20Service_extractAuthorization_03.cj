// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj

@Test
public class TestOAuth20ServiceB008{
    /***
        public func extractAuthorization(redirectLocation: String): OAuth2Authorization
        测试场景:redirectLocation包含字符'#',且包含?,有&,分割后所有值仅有一个=,且解码时异常，此处抛异常
    ***/

    @TestCase
    func testOAuth20ServiceGetAuthorizationUrl02(): Unit {
         var oauth20Service=OAuthServiceTest.getOAuth20Service()
         let redirectLocation01="http://www.baidu.com?code=%2&state=stateValue#"
         let redirectLocation02="http://www.baidu.com?code=codeValue&state=%2#"
         let redirectLocation03="http://www.baidu.com?code=codeValue&name=%2#"
         var flag01=1
         try{
            oauth20Service.extractAuthorization(redirectLocation01)
         }catch(e:OAuth4cjException){
             println(e.toString())
             if(e.toString().contains("unsupported decoding.") && e.toString().contains("URLDecoder: Incomplete trailing escape (%) pattern")){
                 flag01=0
             }
         }
         @Assert(flag01,0)
        var flag02=1
        try{
            oauth20Service.extractAuthorization(redirectLocation02)
        }catch(e:OAuth4cjException){
            println(e.toString())
            if(e.toString().contains("unsupported decoding.") && e.toString().contains("URLDecoder: Incomplete trailing escape (%) pattern")){
                flag02=0
            }
        }
        @Assert(flag02,0)
        var flag03=1
        try{
            oauth20Service.extractAuthorization(redirectLocation03)
        }catch(e:OAuth4cjException){
            println(e.toString())
            if(e.toString().contains("unsupported decoding.") && e.toString().contains("URLDecoder: Incomplete trailing escape (%) pattern")){
                flag03=0
            }
        }
        @Assert(flag03,1)
    }
}