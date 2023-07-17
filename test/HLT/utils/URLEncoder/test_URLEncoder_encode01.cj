// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestURLEncoderB001{
    /***
        编码后比不变的字符：
        1.a ”至“ z ”，“ A ”至“ Z ”和“ 0 ”至“ 9 ”保持不变 ”至“ z ”，“ A ”至“ Z ”和“ 0 ”至“ 9 ”保持不变，
        2.特殊字符“ . ”，“ - ”，“ * ”和“ _ ”保持不变
    ***/
	public var params=Array<String>(["1234567890","abcdefghijklmnopqrstuvwxyz",".-*_"])
    public var re=""

    @TestCase
    func testURLEncoderEncode01(): Unit {
        for (param in params){
            re=URLEncoder.encode(param)
            @Assert(re,param)
        }
    }
}