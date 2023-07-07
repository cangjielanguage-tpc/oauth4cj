// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import commons.*

@Test
public class TestURLEncoderB001{
    /***
        编码后比不变的字符解码：
        1.a ”至“ z ”，“ A ”至“ Z ”和“ 0 ”至“ 9 ”保持不变 ”至“ z ”，“ A ”至“ Z ”和“ 0 ”至“ 9 ”保持不变，
        2.特殊字符“ . ”，“ - ”，“ * ”和“ _ ”保持不变
    ***/
	public var params=Array<String>(["1234567890","abcdefghijklmnopqrstuvwxyz",".-*_"])
    public var re=""
    @TestCase
    func testURLEncoderDecode01(): Unit {
        for (param in params){
            re=URLEncoder.encode(param)
            re=URLEncoder.decode(re)
            @Assert(re,param)
        }
    }
}