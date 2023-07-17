// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj

@Test
public class TestOAuth20ServiceB008{
    /***
        public func extractAuthorization(redirectLocation: String): OAuth2Authorization
        测试场景:redirectLocation包含字符'#',且包含?,有&,且分割后所有值仅有一个=，且key和value本身无等号，key为code,state,或者其他
    ***/

    @TestCase
    func testOAuth20ServiceGetAuthorizationUrl01(): Unit {
         var oauth20Service=OAuthServiceTest.getOAuth20Service()
         let redirectLocation="http://www.baidu.com?code=codeValue&state=stateValue&password=passwd#&state=stateValue02"
         var re_extractAuthorization=oauth20Service.extractAuthorization(redirectLocation)
         @Assert(re_extractAuthorization.getCode(),URLEncoder.decode("codeValue","utf8"))
         @Assert(re_extractAuthorization.getState(),URLEncoder.decode("stateValue","utf8"))
    }
}