// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestOAuth2AccessTokenB001{
    /***
       测试项：(obj as OAuth2AccessToken)  是  Option<OAuth2AccessToken>.None
       测试场景： object是OAuth2AccessToken的父类型的实例对象:public class OAuth2AccessToken <: Token
    ***/
    @TestCase
    func testEquals01(): Unit {
        var token01=Token()
        var oauth2accesstoken01=OAuth2AccessToken("123")
        @Assert(oauth2accesstoken01.equals(token01),false)

        var oauth2accesstoken02=OAuth2AccessToken("123","123")
        @Assert(oauth2accesstoken02.equals(token01),false)

        var oauth2accesstoken03=OAuth2AccessToken("123","123",Int32(0),"123","123","123")
        @Assert(oauth2accesstoken03.equals(token01),false)

    }
}