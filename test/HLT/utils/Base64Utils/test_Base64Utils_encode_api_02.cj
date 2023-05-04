// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj
from std import unittest.*
from std import unittest.testmacro.*
from encoding import base64.*
from std import collection.*
from oauth4cj import utils.*
@Test
public class TestBaseUtilsEncodeingV001{
	
    public var params=Array<UInt8>()
    public var re=""
 	//验证入参数组可取值情况：数组长度达10000
    @TestCase
    func testEncode02(): Unit {
        params=Array<UInt8>(10000,item:0)
        re=Base64Utils.encode(params)
        @Assert(re,toBase64String(params))
    }
               
}   