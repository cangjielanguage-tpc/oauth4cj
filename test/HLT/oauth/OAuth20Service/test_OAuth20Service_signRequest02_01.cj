// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj

@Test
public class TestOAuth20ServiceB008{
    /***
        public func signRequest(accessToken: OAuth2AccessToken, request: OAuth4cjRequest): Unit
        测试场景:加签后各参数值添加准确
    ***/

    @TestCase
    func testOAuth20ServiceSignRequest0201(): Unit {
         var oauth20Service=OAuthServiceTest.getOAuth20Service()
         let request=OAuth4cjRequest(Verb.POST,"http://www.baidu.com")
         let accessToken=OAuth2AccessToken("accessToken")
         oauth20Service.signRequest(accessToken,request)
         let re_Header=request.getHeaders()
         var exp_Header=HashMap<String,String>()
         exp_Header.put(OAuthConstants.HEADER_AUTHORIZATION,"Bearer " +accessToken.getAccessToken() )
         @Assert(re_Header,exp_Header)//添加请求头，转大写
    }
}