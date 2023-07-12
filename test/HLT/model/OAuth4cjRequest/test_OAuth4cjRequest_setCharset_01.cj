// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj


@Test
public class TestOAuth4cjRequestB001{
    /***
        可允许设置的范围：
        1.UTF-8  ||  utf-8  ||  UTF8  || utf8
    ***/
    @TestCase
    func testOAuth4cjRequestsetCharset01(): Unit {
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        var charsets=Array<String>(["UTF-8","utf-8","UTF8","utf8"])
        for (charset in charsets){
            oauth4cjRequest.setCharset(charset)
            @Assert(oauth4cjRequest.getCharset(),charset)
        }
    }
}