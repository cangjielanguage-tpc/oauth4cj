// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestPKCEB002{
    /***
        单次设置，设置值为常见字符串类型
    ***/
    @TestCase
    func testPKCEsetCodeVerifier01(): Unit {
        var pkce=PKCE()
        for(str in strValues){
            pkce=PKCE()
            pkce.setCodeVerifier(str)
            @Assert(pkce.getCodeVerifier(),str)
        }
    }
}