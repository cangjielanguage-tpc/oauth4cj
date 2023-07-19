// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestTokenB001{
    //子类实例：public open class OAuth1Token <: Token
    @TestCase
    func testGetRawResponse02(): Unit {
        var oauth1token01=OAuth1Token()
        var oauth1token02=OAuth1Token()
        @Assert(oauth1token01.getRawResponse(),"")
        for (str in strValues) {
            oauth1token02=OAuth1Token(str,str,str)
            @Assert(oauth1token02.getRawResponse(),str)

        }
    }
}