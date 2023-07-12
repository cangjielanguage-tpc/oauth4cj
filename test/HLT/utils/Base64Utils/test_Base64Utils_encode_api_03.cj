// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj

@Test
public class TestBaseUtilsEncodeingB001{
	
    public var params=Array<UInt8>()
    public var re=""

 	//验证入参数组可取值情况：普通数组
    @TestCase
    func testEncode03(): Unit {
        params="hello & world".toUtf8Array()
        re=Base64Utils.encode(params)
        @Assert(re,toBase64String(params))
    }
             
}   