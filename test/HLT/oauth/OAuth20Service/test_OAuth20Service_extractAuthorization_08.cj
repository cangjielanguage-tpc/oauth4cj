// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj

@Test
public class TestOAuth20ServiceB008{
    /***
        public func extractAuthorization(redirectLocation: String): OAuth2Authorization
        测试场景:redirectLocation无'#'
    ***/

    @TestCase
    func testOAuth20ServiceGetAuthorizationUrl08(): Unit {
         var oauth20Service=OAuthServiceTest.getOAuth20Service()
         let redirectLocation01="http://www.baidu.com&code=codeValue&code=codeValue01&code=codeValue02"
         var re_extractAuthorization01=oauth20Service.extractAuthorization(redirectLocation01)
         @Assert(re_extractAuthorization01.getCode(),URLEncoder.decode("codeValue02","utf8"))
         @Assert(re_extractAuthorization01.getState(),"")
    }
}