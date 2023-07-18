// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestOAuth4cjRequestB001{
    /***
        添加异常，不满足以下条件
        1.key,startsWith("oauth_")
        2.key.equals("scope")
        3.key.equals("realm")
    ***/
    @TestCase
    func testOAuth4cjRequestaddOAuthParameter02(): Unit {
        var parameters=HashMap<String,String>([("Oauth_1",""),("oauth","oauth_"),("scope01","scope01"),("scop","scope01"),("realm01","realm01"),("rea","realm01")])
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        var flag=1
        for (parameter in parameters){
            flag=1
            try{
                oauth4cjRequest.addOAuthParameter(parameter[0],parameter[1])
            }catch(e:Exception){
                flag=0
            }
            @Assert(flag,0)
        }
    }
}