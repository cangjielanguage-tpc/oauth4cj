// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestOAuth4cjRequestB001{
    /***
        初始化查询：url不带参数,url有效协议
    ***/
    @TestCase
    func testOAuth4cjRequestgetQueryStringParams01(): Unit {
        var urls=Array<String>(["http://www.baidu.com","ftp://www.baidu.com"])
        for (url in urls){
            var oauth4cjRequest=OAuth4cjRequest(Verb.GET,url)
            @Assert(oauth4cjRequest.getQueryStringParams().asFormUrlEncodedString(),"")
        }
    }
}