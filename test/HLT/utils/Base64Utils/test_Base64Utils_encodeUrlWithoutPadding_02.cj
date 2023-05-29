// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
from std import unittest.*
from std import unittest.testmacro.*
from encoding import base64.*
from std import collection.*
from oauth4cj import utils.*

@Test
public class TestBaseUtilsV002{
	
    public var params=Array<UInt8>()
    public var re=""
 	//验证入参数组可取值情况：数组为空
    @TestCase
    func testBase64UtilsencodeUrlWithoutPadding02(): Unit {
        params=Array<UInt8>()
        re=Base64Utils.encodeUrlWithoutPadding(params)
        println(re)
        @Assert(re,toBase64String(params))
    }
}   