// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
from std import unittest.*
from std import unittest.testmacro.*
from encoding import base64.*
from oauth4cj import utils.*

@Test
public class TestBaseUtilsEncodeingB001{
	
    public var params=Array<UInt8>()
    public var re=""
 	//验证入参数组可取值情况：数组为空
    @TestCase
    func testEncode01(): Unit {
        params=Array<UInt8>()
        re=Base64Utils.encode(params)
        @Assert(re,toBase64String(params))
    }
}   