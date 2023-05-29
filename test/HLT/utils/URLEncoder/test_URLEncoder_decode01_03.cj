// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj
from std import unittest.*
from std import unittest.testmacro.*
from encoding import base64.*
from std import collection.*
from oauth4cj import utils.*
from oauth4cj import model.*
from oauth4cj import exceptions.*
@Test
public class TestURLEncoder01{
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