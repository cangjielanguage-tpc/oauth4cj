// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj


@Test
public class TestOAuth4cjRequestB001{
    /***
        2.url.startWith("https://") &&  ( url.endWith(":443")  || url.contains(":443/") )----替换“:443”为空，删除“？”之后的所有字符串,包括?
    ***/
    @TestCase
    func testOAuth4cjRequestgetUrl02(): Unit {
        var urls=Array<String>(["https://127.0.0.0:443","https://127.0.0.0:443/","https://127.0.0.0:443/index?","https://127.0.0.0:443/index?user=001&passwd=123"])
        var exp_urls=Array<String>(["https://127.0.0.0","https://127.0.0.0/","https://127.0.0.0/index","https://127.0.0.0/index"])
        for (index in 0..urls.size){
            var oauth4cjRequest=OAuth4cjRequest(Verb.GET,urls[index])
            @Assert(oauth4cjRequest.getSanitizedUrl(),exp_urls[index])
        }
    }
}