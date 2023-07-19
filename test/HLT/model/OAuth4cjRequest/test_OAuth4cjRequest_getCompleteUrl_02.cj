// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestOAuth4cjRequestB001{
    @TestCase
    func testOAuth4cjRequestgetCompleteUrl02(): Unit {
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        oauth4cjRequest.addHeader("header","header")
        oauth4cjRequest.addBodyParameter("BodyParameter","BodyParameter")
        oauth4cjRequest.addQuerystringParameter("QuerystringParameter","QuerystringParameter")
        @Assert(oauth4cjRequest.getCompleteUrl(),"https://www.baidu.com?QuerystringParameter=QuerystringParameter")
    }
}