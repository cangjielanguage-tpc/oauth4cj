// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj

@Test
public class TestOAuth20ServiceB008{
    /***
        public func extractAuthorization(redirectLocation: String): OAuth2Authorization
        测试场景:redirectLocation包含字符'#',且包含?,有&,且分割后存在多个值无等号
    ***/

    @TestCase
    func testOAuth20ServiceGetAuthorizationUrl04(): Unit {
         var oauth20Service=OAuthServiceTest.getOAuth20Service()
         let redirectLocation01="http://www.baidu.com?code=code01=codeValue&state=stateValue&password=passwd#code=code01"
         var re_extractAuthorization01=oauth20Service.extractAuthorization(redirectLocation01)
         @Assert(re_extractAuthorization01.getCode(),"")
         @Assert(re_extractAuthorization01.getState(),URLEncoder.decode("stateValue","utf8"))
    }
}