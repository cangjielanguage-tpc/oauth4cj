// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj

@Test
public class TestOAuth20ServiceB008{
    /***
        public func extractAuthorization(redirectLocation: String): OAuth2Authorization
        测试场景:redirectLocation包含字符'#',无？
    ***/

    @TestCase
    func testOAuth20ServiceGetAuthorizationUrl07(): Unit {
         var oauth20Service=OAuthServiceTest.getOAuth20Service()
         let redirectLocation01="http://www.baidu.com&code=codeValue#&state=stateValue"
         let redirectLocation02="http://www.baidu.comcode=codeValue#&state=stateValue"
         var re_extractAuthorization01=oauth20Service.extractAuthorization(redirectLocation01)
         var re_extractAuthorization02=oauth20Service.extractAuthorization(redirectLocation02)
         @Assert(re_extractAuthorization01.getCode(),URLEncoder.decode("codeValue","utf8"))
         @Assert(re_extractAuthorization01.getState(),"")
         @Assert(re_extractAuthorization02.getCode(),"")
         @Assert(re_extractAuthorization02.getState(),"")
    }
}