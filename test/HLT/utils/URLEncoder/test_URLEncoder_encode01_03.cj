// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import utils.*

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