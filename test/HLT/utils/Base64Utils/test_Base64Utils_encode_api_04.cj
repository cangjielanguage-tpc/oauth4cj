// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj

@Test
public class TestBaseUtilsEncodeingB001{
	
    public var params=Array<UInt8>()
    public var re=""
 	//验证入参数组可取值情况：数组内元素值包含在[0,256)
    @TestCase
    func testEncode04(): Unit {
        params=Array<UInt8>(256,item:0)
        for (i in 0..params.size){
            params[i]=UInt8(i)
        }
        re=Base64Utils.encode(params)
        @Assert(re,toBase64String(params))
    }
}   