// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
from std import unittest.*
from std import unittest.testmacro.*
from encoding import base64.*
from oauth4cj import utils.*

@Test
public class TestBaseUtilsEncodeingB001{
	
    public var params=Array<UInt8>()
    public var re=""
 	//验证多次编码
    @TestCase
    func testEncode03(): Unit {
        params="hello & world".toUtf8Array()
        re=Base64Utils.encode(Base64Utils.encode(params).toUtf8Array())
        @Assert(re,toBase64String(toBase64String(params).toUtf8Array()))
    }
             
}   