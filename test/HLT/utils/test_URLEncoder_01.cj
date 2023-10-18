// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj


@Test
public class TestURLEncoderB001{
    /***
        编码后比不变的字符解码：
        1.a ”至“ z ”，“ A ”至“ Z ”和“ 0 ”至“ 9 ”保持不变 ”至“ z ”，“ A ”至“ Z ”和“ 0 ”至“ 9 ”保持不变，
        2.特殊字符“ . ”，“ - ”，“ * ”和“ _ ”保持不变
    ***/
	public var params=Array<String>()
    public var re=""
    @TestCase
    func testURLEncoderDecode01(): Unit {
        params=Array<String>(["1234567890","abcdefghijklmnopqrstuvwxyz",".-*_"])
        for (param in params){
            re=URLEncoder.encode(param)
            re=URLEncoder.decode(re)
            @Assert(re,param)
        }
    }
    /***
        编码后变化的字符，能被正常解码：
        1.“+”被正常解码为空格
        2.%之后有两个字符
        3.%之后有超过两个字符
    ***/
    @TestCase
    func testURLEncoderDecode0102(): Unit {
        params=Array<String>(["+","%21%22","%21%222"])
        var res=Array<String>([" ","!\"","!\"2"])
        for (index in 0..params.size){
            re=URLEncoder.decode(params[index])
            @Assert(re,res[index])
        }
    }
    /***
        编码后变化的字符，解码异常：
        1.%之后只有一个字符
        2.%之后只有无字符
    ***/
    @TestCase
    func testURLEncoderDecode0103(): Unit {
        params=Array<String>(["%","%2"])
        var dec_flag=1
        for (index in 0..params.size){
            dec_flag=1
            try{
                URLEncoder.decode(params[index])
            }catch(e:IllegalArgumentException){
                dec_flag=0
            }
            @Assert(dec_flag,0)
        }
    }
    /***
        编码后解码正常(字符串的常见格式)
    ***/
    @TestCase
    func testURLEncoderDecode0104(): Unit {
        params=Array<String>(["","中e12","%……&","%^&*()","//n"])
        for (param in params){
            re=URLEncoder.encode(param)
            re=URLEncoder.decode(re)
            @Assert(re,param)
        }
    }
    /***
        正常编码的enc：
        1.UTF-8  ||  utf-8  ||  UTF8  || utf8
    ***/
    @TestCase
    func testURLEncoderDecode02(): Unit {
        var enc_params=Array<String>(["UTF-8","utf-8","UTF8","utf8"])
        var exp_re="abcdefghijklmnopqrstuvwxyz"
        var param=URLEncoder.encode(exp_re)
        for (enc in enc_params){
            re=URLEncoder.decode(param,enc)
            @Assert(re,exp_re)
        }
    }
    /***
        异常编码的enc：
        1.空字符串
        2.枚举值外，非空白字符串
        3.空白字符串
    ***/
    @TestCase
    func testURLEncoderDecode0202(): Unit {
        var enc_params=Array<String>([" ","abc",""])
        var enc_flag=1
        for (index in 0..enc_params.size){
            enc_flag=1
            try{
                URLEncoder.decode("abcdefghijklmnopqrstuvwxyz",enc_params[index])
            }catch(e:Exception){
                if(e.toString().contains("only UTF-8 Character Set is supported") || e.toString().contains("empty string enc parameter")){
                    enc_flag=0
                }
            }
            @Assert(enc_flag,0)
        }
    }
    /***
        编码后比不变的字符：
        1.a ”至“ z ”，“ A ”至“ Z ”和“ 0 ”至“ 9 ”保持不变 ”至“ z ”，“ A ”至“ Z ”和“ 0 ”至“ 9 ”保持不变，
        2.特殊字符“ . ”，“ - ”，“ * ”和“ _ ”保持不变
    ***/
    @TestCase
    func testURLEncoderEncode01(): Unit {
        params=Array<String>(["1234567890","abcdefghijklmnopqrstuvwxyz",".-*_"])
        for (param in params){
            re=URLEncoder.encode(param)
            @Assert(re,param)
        }
    }
    /***
        编码后变化的字符：
        1.空格替换为“+”
        2.所有其他字符都不安全，并且首先使用一些编码方案将其转换为一个或多个字节。 然后每个字节由3个字符串“ %xy ”表示，其中xy是字节的两位十六进制表示。
    ***/
    @TestCase
    func testURLEncoderEncode0102(): Unit {
        re=URLEncoder.encode(" !\"#$%&\'()*+,/~")
        @Assert(re,"+%21%22%23%24%25%26%27%28%29*%2B%2C%2F%7E")
    }
    /***
        多次编码:可变/不可变
    ***/
    @TestCase
    func testURLEncoderEncode0103(): Unit {
        var re_temp01=URLEncoder.encode(" !\"#$%&\'()*+,//~")
        var re_temp02=URLEncoder.encode("abc")
        re=URLEncoder.encode(re_temp01)
        @Assert(re==re_temp01,false)
        re=URLEncoder.encode(re_temp02)
        @Assert(re==re_temp02,true)
    }
    /***
        正常编码的enc：
        1.UTF-8  ||  utf-8  ||  UTF8  || utf8
    ***/
    @TestCase
    func testURLEncoderEncode02(): Unit {
        var enc_params=Array<String>(["UTF-8","utf-8","UTF8","utf8"])
        var param="abcdefghijklmnopqrstuvwxyz"
        for (enc in enc_params){
            re=URLEncoder.encode(param,enc)
            @Assert(re,param)
        }
    }
    /***
        异常编码的enc：
        1.空字符串
        2.枚举值外，非空白字符串
        3.空白字符串
    ***/
    @TestCase
    func testURLEncoderEncode0202(): Unit {
        var enc_params=Array<String>([" ","abc",""])
        var enc_flag=1
        for (enc in enc_params){
            enc_flag=1
            try{
                URLEncoder.encode("abcdefghijklmnopqrstuvwxyz",enc)
            }catch(e:Exception){
                if(e.toString().contains("only UTF-8 Character Set is supported") || e.toString().contains("charsetName can not be empty" ) ){
                    enc_flag=0
                }
            }
            @Assert(enc_flag,0)
        }
    }
}