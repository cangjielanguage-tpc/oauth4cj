// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj


@Test
public class TestOAuth1TokenB001{
    //构造器传入,不传入
    @TestCase
    func testGetToken01(): Unit {
        var oauth1token01=OAuth1Token()
        @Assert(oauth1token01.getToken(),"")
        var oauth1token02=OAuth1Token()
        for (str in strValues) {
            oauth1token02=OAuth1Token(str,str,str)
            @Assert(oauth1token02.getToken(),str)
        }
    }
}