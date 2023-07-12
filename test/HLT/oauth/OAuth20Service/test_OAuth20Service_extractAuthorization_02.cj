// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj

@Test
public class TestOAuth20ServiceB008{
    /***
        public func extractAuthorization(redirectLocation: String): OAuth2Authorization
        测试场景:redirectLocation包含字符'#',且包含?,有&,且分割后所有值仅有一个=，且key和value本身无等号，key仅有code或state或其他
    ***/

    @TestCase
    func testOAuth20ServiceGetAuthorizationUrl02(): Unit {
         var oauth20Service=OAuthServiceTest.getOAuth20Service()
         let redirectLocation01="http://www.baidu.com?code=codeValue&password=passwd#&code=codeValue02"
         let redirectLocation02="http://www.baidu.com?state=stateValue&password=passwd#&code=codeValue"
         let redirectLocation03="http://www.baidu.com?name=stateValue&password=passwd#&state=stateValue"
         var re_extractAuthorization01=oauth20Service.extractAuthorization(redirectLocation01)
         var re_extractAuthorization02=oauth20Service.extractAuthorization(redirectLocation02)
         var re_extractAuthorization03=oauth20Service.extractAuthorization(redirectLocation03)
         @Assert(re_extractAuthorization01.getCode(),URLEncoder.decode("codeValue","utf8"))
         @Assert(re_extractAuthorization01.getState(),"")
         @Assert(re_extractAuthorization02.getCode(),"")
         @Assert(re_extractAuthorization02.getState(),URLEncoder.decode("stateValue","utf8"))
         @Assert(re_extractAuthorization03.getCode(),"")
         @Assert(re_extractAuthorization03.getState(),"")
    }
}