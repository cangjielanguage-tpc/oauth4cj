// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp

from std import unittest.*
from std import unittest.testmacro.*
from std import collection.*
from oauth4cj import httpclient.multipart.*
@Test
public class TestByteArrayBodyPartPayloadB005{
    /***
        public func getPayload(): Array<UInt8>
        测试场景:返回Payload，调用源
    ***/
    @TestCase
    func testByteArrayBodyPartPayloadGetPayload01(): Unit {
        var bodypayload01=ByteArrayBodyPartPayload(Array<UInt8>(),1,1,HashMap<String,String>())
        var bodypayload02=ByteArrayBodyPartPayload(Array<UInt8>(),HashMap<String,String>())
        var bodypayload03=ByteArrayBodyPartPayload(Array<UInt8>(),"content-type")
        var bodypayload04=ByteArrayBodyPartPayload(Array<UInt8>(),1,1,"content-type")
        var bodypayload05=ByteArrayBodyPartPayload(Array<UInt8>())
        var bodypayload06=ByteArrayBodyPartPayload(Array<UInt8>(),1,1)

        @Assert(bodypayload01.getPayload(),Array<UInt8>())
        @Assert(bodypayload02.getPayload(),Array<UInt8>())
        @Assert(bodypayload03.getPayload(),Array<UInt8>())
        @Assert(bodypayload04.getPayload(),Array<UInt8>())
        @Assert(bodypayload05.getPayload(),Array<UInt8>())
        @Assert(bodypayload06.getPayload(),Array<UInt8>())
    }
}