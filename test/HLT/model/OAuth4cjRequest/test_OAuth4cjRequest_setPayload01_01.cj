// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj


@Test
public class TestOAuth4cjRequestB001{
    @TestCase
    func testOAuth4cjRequestsetPayload0101(): Unit {
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        for (str in strValues){
            oauth4cjRequest.setPayload(str)
            @Assert(oauth4cjRequest.getStringPayload(),str)
        }
    }
}