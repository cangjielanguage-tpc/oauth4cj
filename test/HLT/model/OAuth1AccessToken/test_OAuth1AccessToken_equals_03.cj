// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestOAuth1AccessTokenB001{
    /***
       测试项：(obj as OAuth1AccessToken)  不是  Option<OAuth1AccessToken>.None
       测试场景： object是OAuth1AccessToken的实例对象，与自身比较
    ***/
    @TestCase
    func testEquals03(): Unit {
        var oauth1accesstoken01=OAuth1AccessToken("123","123")
        @Assert(oauth1accesstoken01.equals(oauth1accesstoken01),true)

        var oauth1accesstoken02=OAuth1AccessToken("123","123","123")
        @Assert(oauth1accesstoken02.equals(oauth1accesstoken02),true)
    }
}