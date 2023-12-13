// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj


@Test
public class TestOAuthEncoder01{
    /***
        经编码之后的字符串：空字符串，中英文数字，中文符号，英文符号，转义字符
    ***/
 	//验证String入参输入
    @TestCase
    func testOAuthEncoderDecode01(): Unit {
        var params=Array<String>(["","中e12","~！@#￥%……&*（）","~!@#$%^&*","\\n",getStringByLength(1000)])
        var param_temp=""
        var re=""
        for (param in params){
            param_temp=OAuthEncoder.encode(param)
            re=OAuthEncoder.decode(param_temp)
            @Assert(re,param)
        }
    }
    /***
        包含特殊字符
    ***/
    @TestCase
    func testOAuthEncoderEncode01(): Unit {
        var en_params=Array<String>([" ","*","~"])
        var en_res=Array<String>(["%20","%2A","~"])
        var en_re=""
        for (index in 0..en_params.size){
            en_re=OAuthEncoder.encode(en_params[index])
            @Assert(en_re,en_res[index])
        }
    }
}   