// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj


@Test
public class TestURLEncoderB001{
    /***
        编码后变化的字符，解码异常：
        1.%之后只有一个字符
        2.%之后只有无字符
    ***/
	public var params=Array<String>(["%","%2"])
    public var re=""

    @TestCase
    func testURLEncoderDecode0103(): Unit {
        var dec_flag=1
        for (index in 0..params.size){
            dec_flag=1
            try{
                re=URLEncoder.decode(params[index])
            }catch(e:IllegalArgumentException){
                dec_flag=0
            }
            @Assert(dec_flag,0)
        }
    }
}