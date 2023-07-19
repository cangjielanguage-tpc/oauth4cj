// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj

@Test
public class TestBaseUtilsB002{
	
    public var params=Array<UInt8>()
    public var re=""
 	//验证入参数组可取值情况：数组为空
    @TestCase
    func testBase64UtilsencodeUrlWithoutPadding02(): Unit {
        params=Array<UInt8>()
        re=Base64Utils.encodeUrlWithoutPadding(params)
        @Assert(re,toBase64String(params))
    }
}   