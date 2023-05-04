// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from encoding import base64.*
from std import collection.*
from oauth4cj import utils.*

@Test
public class TestOAuthEncoder01{
    /***
        经编码之后的字符串：空字符串，中英文数字，中文符号，英文符号，转义字符
    ***/
	public var params=Array<String>(["","中e12","~！@#￥%……&*（）","~!@#$%^&*","\\n",getStringByLength(1000)])
    public var param_temp=""
    public var re=""
 	//验证String入参输入
    @TestCase
    func testOAuthEncoderDecode01(): Unit {
        for (param in params){
            param_temp=OAuthEncoder.encode(param)
            re=OAuthEncoder.decode(param_temp)
            @Assert(re,param)
        }
    }                  
}   