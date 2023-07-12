// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
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