// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj

@Test
public class TestOAuth20ServiceB008{
    /***
        public func extractAuthorization(redirectLocation: String): OAuth2Authorization
        测试场景:redirectLocation包含字符'#',且包含?,有&，且分割后存在一个值无等号
               场景2:&分割后存在相同的值
    ***/

    @TestCase
    func testOAuth20ServiceGetAuthorizationUrl05(): Unit {
         var oauth20Service=OAuthServiceTest.getOAuth20Service()
         let redirectLocation01="http://www.baidu.com?code&state=stateValue&password=passwd#&code=code01"
         var re_extractAuthorization01=oauth20Service.extractAuthorization(redirectLocation01)
         @Assert(re_extractAuthorization01.getCode(),"")
         @Assert(re_extractAuthorization01.getState(),URLEncoder.decode("stateValue","utf8"))
    }
    @TestCase
    func testOAuth20ServiceGetAuthorizationUrl0502(): Unit {
         var oauth20Service=OAuthServiceTest.getOAuth20Service()
         let redirectLocation01="http://www.baidu.com?code&state=stateValue&state=stateValue02#&&state=stateValue03"
         var re_extractAuthorization01=oauth20Service.extractAuthorization(redirectLocation01)
         @Assert(re_extractAuthorization01.getCode(),"")
         @Assert(re_extractAuthorization01.getState(),URLEncoder.decode("stateValue02","utf8"))
    }
}