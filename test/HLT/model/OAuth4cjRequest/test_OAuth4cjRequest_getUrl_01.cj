// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestOAuth4cjRequestB001{
    /***
        字符串角度验证
    ***/
    @TestCase
    func testOAuth4cjRequestgetUrl01(): Unit {
        for (str in strValues){
            var oauth4cjRequest=OAuth4cjRequest(Verb.GET,str)
            @Assert(oauth4cjRequest.getUrl(),str)
        }
    }
}