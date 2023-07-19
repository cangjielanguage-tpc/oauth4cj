// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestTokenB001{
    //子类实例:public class OAuth1AccessToken <: OAuth1Token
    @TestCase
    func testGetParameter0202(): Unit {
        var oauth1accesstoken01=OAuth1AccessToken("123","123")
        var oauth1accesstoken02=OAuth1AccessToken("123","123","http://www.baidu.com?userName=fly&city=&old=128")
        @Assert(oauth1accesstoken01.getParameter("http://www.baidu.com?userName"),"")
        @Assert(oauth1accesstoken02.getParameter("http://www.baidu.com?userName"),"fly")
    }
}