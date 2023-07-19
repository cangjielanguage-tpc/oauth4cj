// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestURLEncoderB001{
    /***
        正常编码的enc：
        1.UTF-8  ||  utf-8  ||  UTF8  || utf8
    ***/
	public var enc_params=Array<String>(["UTF-8","utf-8","UTF8","utf8"])
    public var re=""

    @TestCase
    func testURLEncoderDecode02(): Unit {
        var exp_re="abcdefghijklmnopqrstuvwxyz"
        var param=URLEncoder.encode(exp_re)
        for (enc in enc_params){
            re=URLEncoder.decode(param,enc)
            @Assert(re,exp_re)
        }
    }
}