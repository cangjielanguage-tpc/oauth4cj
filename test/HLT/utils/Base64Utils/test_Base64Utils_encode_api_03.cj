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

 	//验证入参数组可取值情况：普通数组
    @TestCase
    func testEncode03(): Unit {
        params="hello & world".toUtf8Array()
        re=Base64Utils.encode(params)
        @Assert(re,toBase64String(params))
    }
             
}   