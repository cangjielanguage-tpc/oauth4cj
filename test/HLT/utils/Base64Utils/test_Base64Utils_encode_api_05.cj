// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj

@Test
public class TestBaseUtilsEncodeingB001{
	
    public var params=Array<UInt8>()
    public var re=""
 	//验证多次编码
    @TestCase
    func testEncode03(): Unit {
        params="hello & world".toUtf8Array()
        re=Base64Utils.encode(Base64Utils.encode(params).toUtf8Array())
        @Assert(re,toBase64String(toBase64String(params).toUtf8Array()))
    }
             
}   