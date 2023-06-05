// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import utils.*

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