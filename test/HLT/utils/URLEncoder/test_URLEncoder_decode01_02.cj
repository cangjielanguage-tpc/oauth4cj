// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestURLEncoderB001{
    /***
        编码后变化的字符，能被正常解码：
        1.“+”被正常解码为空格
        2.%之后有两个字符
        3.%之后有超过两个字符
    ***/
	public var params=Array<String>(["+","%21%22","%21%222"])
    public var res=Array<String>([" ","!\"","!\"2"])
    public var re=""

    @TestCase
    func testURLEncoderDecode0102(): Unit {
        for (index in 0..params.size){
            re=URLEncoder.decode(params[index])
            @Assert(re,res[index])
        }
    }
}