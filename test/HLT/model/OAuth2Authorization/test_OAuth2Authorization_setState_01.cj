// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj


@Test
public class TestOAuth2AuthorizationB001{
    //单/多次设置
    @TestCase
    func testOAuth2AuthorizationSetState01(): Unit {
        var oa01=OAuth2Authorization()
        for (i in strValues){
            oa01.setState(i)
            @Assert(oa01.getState(),i)
        }
    }
}