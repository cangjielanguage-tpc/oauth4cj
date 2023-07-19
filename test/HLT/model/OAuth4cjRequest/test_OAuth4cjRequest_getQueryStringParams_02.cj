// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestOAuth4cjRequestB001{
    /***
        初始化查询：url带参数
    ***/
    @TestCase
    func testOAuth4cjRequestgetQueryStringParams01(): Unit {
        var exp_body=HashMap<String,String>([("uaser","name"),("old","23")])
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com?uaser=name&old=23")
        @Assert(oauth4cjRequest.getQueryStringParams().asFormUrlEncodedString(),ParameterList(exp_body).asFormUrlEncodedString())
    }
}