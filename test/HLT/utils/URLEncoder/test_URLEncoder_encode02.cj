// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import commons.*

@Test
public class TestURLEncoderB001{
    /***
        正常编码的enc：
        1.UTF-8  ||  utf-8  ||  UTF8  || utf8
    ***/
	public var enc_params=Array<String>(["UTF-8","utf-8","UTF8","utf8"])
    public var re=""

    @TestCase
    func testURLEncoderEncode02(): Unit {
        var param="abcdefghijklmnopqrstuvwxyz"
        for (enc in enc_params){
            re=URLEncoder.encode(param,enc)
            @Assert(re,param)
        }
    }
}