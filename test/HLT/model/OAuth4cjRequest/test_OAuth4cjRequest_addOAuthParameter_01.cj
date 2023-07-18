// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestOAuth4cjRequestB001{
    /***
        添加成功
        1.key,startsWith("oauth_")
        2.key.equals("scope")
        3.key.equals("realm")
    ***/
    @TestCase
    func testOAuth4cjRequestaddOAuthParameter01(): Unit {
        var parameters=HashMap<String,String>([("oauth_1",""),("oauth_","oauth_"),("scope","scope01"),("realm","realm01")])
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        for (parameter in parameters){
            oauth4cjRequest.addOAuthParameter(parameter[0],parameter[1])
        }
        @Assert(oauth4cjRequest.getOauthParameters(),parameters)
    }
}