// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj

@Test
public class TestBaseUtilsEncodeingB001{
	
    public var params=Array<UInt8>()
    public var re=""
 	//验证入参数组可取值情况：数组长度达10000
    @TestCase
    func testEncode02(): Unit {
        params=Array<UInt8>(10000,item:0)
        re=Base64Utils.encode(params)
        @Assert(re,toBase64String(params))
    }
               
}   