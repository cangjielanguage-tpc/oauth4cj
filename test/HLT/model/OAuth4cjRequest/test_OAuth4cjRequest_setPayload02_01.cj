// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from encoding import base64.*
from std import collection.*
from oauth4cj import model.*
from oauth4cj import utils.*
from std import io.*
@Test
public class TestOAuth4cjRequestV001{
    @TestCase
    func testOAuth4cjRequestsetPayload0201(): Unit {
        var arr01=Array<UInt8>()
        var arr02=Array<UInt8>(10000,item:0)
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        oauth4cjRequest.setPayload(arr01)
        @Assert(oauth4cjRequest.getByteArrayPayload(),arr01)
        oauth4cjRequest.setPayload(arr02)
        @Assert(oauth4cjRequest.getByteArrayPayload(),arr02)

    }
}