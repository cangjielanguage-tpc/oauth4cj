// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj

@Test
public class TestURLEncoderB001{
    /***
        异常编码的enc：
        1.空字符串
        2.枚举值外，非空白字符串
        3.空白字符串
    ***/
	public var enc_params=Array<String>([" ","abc",""])
    public var re=""

    @TestCase
    func testURLEncoderEncode0202(): Unit {
        var enc_flag=1
        for (index in 0..enc_params.size){
            enc_flag=1
            try{
                re=URLEncoder.decode("abcdefghijklmnopqrstuvwxyz",enc_params[index])
            }catch(e:Exception){
                if(e.toString().contains("only UTF-8 is supported") || e.toString().contains("empty string enc parameter")){
                    enc_flag=0
                }
            }
            @Assert(enc_flag,0)
        }
    }
}