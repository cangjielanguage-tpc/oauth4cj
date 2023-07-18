// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestOAuth4cjRequestB001{
    /***
        1.url.startWith("http://") &&  ( url.endWith(":80")  || url.contains(":80/") )---替换“:80”为空，删除“？”之后的所有字符串,包括?
    ***/
    @TestCase
    func testOAuth4cjRequestgetUrl01(): Unit {
        var urls=Array<String>(["http://127.0.0.0:80","http://127.0.0.0:80/","http://127.0.0.0:80/index?","http://127.0.0.0:80/index?user=001&passwd=123"])
        var exp_urls=Array<String>(["http://127.0.0.0","http://127.0.0.0/","http://127.0.0.0/index","http://127.0.0.0/index"])
        for (index in 0..urls.size){
            var oauth4cjRequest=OAuth4cjRequest(Verb.GET,urls[index])
            @Assert(oauth4cjRequest.getSanitizedUrl(),exp_urls[index])
        }
    }
}