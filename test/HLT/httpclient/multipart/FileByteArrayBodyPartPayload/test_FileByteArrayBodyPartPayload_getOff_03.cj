// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import httpclient.multipart.*
@Test
public class TestFileByteArrayBodyPartPayloadB005{
    /***
         public func getOff(): Int64
         测试场景:获取off，根据调用源返回
         public init(contentType: String, payload: Array<UInt8>)
         public init(contentType: String, payload: Array<UInt8>, off: Int64, len: Int64)
         public init(contentType: String, payload: Array<UInt8>, name: String)
     ***/
     @TestCase
     func testFileByteArrayBodyPartPayloadGetOff03(): Unit {
        var fileByteArrayBodyPartPayload01=FileByteArrayBodyPartPayload("contentType",Array<UInt8>())
        var re01=fileByteArrayBodyPartPayload01.getOff()
        @Assert(re01,0)

        var fileByteArrayBodyPartPayload02=FileByteArrayBodyPartPayload("contentType",Array<UInt8>(),1,100)
        var re02=fileByteArrayBodyPartPayload02.getOff()
        @Assert(re02,1)

        var fileByteArrayBodyPartPayload03=FileByteArrayBodyPartPayload("contentType",Array<UInt8>(),"name_value")
        var re03=fileByteArrayBodyPartPayload03.getOff()
        @Assert(re03,0)
     }
}