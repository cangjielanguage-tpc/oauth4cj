// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp

from std import unittest.*
from std import unittest.testmacro.*
from std import collection.*
from oauth4cj import httpclient.multipart.*
@Test
public class TestMultipartPayloadB005{
    /***
        public func addBodyPart(bodyPartPayload: BodyPartPayload): Unit
        测试场景:多次添加
    ***/
    @TestCase
    func testMultipartPayloadAddBodyPart0102(): Unit {
        var multipartPayload01=MultipartPayload()
        var bodypayload01=BodyPartPayload()
        var contentType="contentType"
        var bodypayload02=BodyPartPayload(contentType)
        var map01=HashMap<String,String>([("token","token_value"),("token02","token_value02")])
        var bodypayload03=BodyPartPayload(map01)
        multipartPayload01.addBodyPart(bodypayload01)
        multipartPayload01.addBodyPart(bodypayload02)
        multipartPayload01.addBodyPart(bodypayload03)
        @Assert(multipartPayload01.getBodyParts().size,3)

    }
}