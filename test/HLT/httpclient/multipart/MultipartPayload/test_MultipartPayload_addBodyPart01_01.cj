// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp

from std import unittest.*
from std import unittest.testmacro.*
from std import collection.*
from oauth4cj import httpclient.multipart.*

@Test
public class TestMultipartPayloadB005{
    /***
        public func addBodyPart(bodyPartPayload: BodyPartPayload): Unit
        测试场景:单次添加
    ***/
    @TestCase
    func testMultipartPayloadAddBodyPart0101(): Unit {
        var multipartPayload01=MultipartPayload()
        var multipartPayload02=MultipartPayload("boundary")
        var multipartPayload03=MultipartPayload("subtype","boundary")
        var multipartPayload04=MultipartPayload(HashMap<String,String>())
        var multipartPayload05=MultipartPayload("boundary",HashMap<String,String>())
        var multipartPayload06=MultipartPayload("subtype","boundary",HashMap<String,String>())
        var bodypayload=BodyPartPayload()
        multipartPayload01.addBodyPart(bodypayload)
        multipartPayload02.addBodyPart(bodypayload)
        multipartPayload03.addBodyPart(bodypayload)
        multipartPayload04.addBodyPart(bodypayload)
        multipartPayload05.addBodyPart(bodypayload)
        multipartPayload06.addBodyPart(bodypayload)
        @Assert(multipartPayload01.getBodyParts().size,1)
        @Assert(multipartPayload02.getBodyParts().size,1)
        @Assert(multipartPayload03.getBodyParts().size,1)
        @Assert(multipartPayload04.getBodyParts().size,1)
        @Assert(multipartPayload05.getBodyParts().size,1)
        @Assert(multipartPayload06.getBodyParts().size,1)
    }
}