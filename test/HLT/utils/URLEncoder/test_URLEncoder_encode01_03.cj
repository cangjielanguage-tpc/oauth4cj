// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestURLEncoderB001{
    /***
        多次编码:可变/不可变
    ***/
	public var params=Array<String>()
    public var re=""

    @TestCase
    func testURLEncoderEncode0103(): Unit {
        var re_temp01=URLEncoder.encode(" !\"#$%&\'()*+,//~")
        var re_temp02=URLEncoder.encode("abc")
        re=URLEncoder.encode(re_temp01)
        @Assert(re==re_temp01,false)
        re=URLEncoder.encode(re_temp02)
        @Assert(re==re_temp02,true)
    }
}