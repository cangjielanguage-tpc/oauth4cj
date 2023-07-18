// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestURLEncoderB001{
    /***
        编码后解码正常(字符串的常见格式)
    ***/
	public var params=Array<String>(["","中e12","%……&","%^&*()","//n"])
    public var re=""

    @TestCase
    func testURLEncoderDecode0104(): Unit {
        for (param in params){
            re=URLEncoder.encode(param)
            re=URLEncoder.decode(re)
            @Assert(re,param)
        }
    }
}