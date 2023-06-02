// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import httpclient.multipart.*
@Test
public class TestMultipartPayloadB005{
    /***
        public func addBodyPart(multipartPayload: MultipartPayload): Unit
        测试场景:单次添加入参MultipartPayload.getBoundary()不等于本身的boundary
    ***/
    @TestCase
    func testMultipartPayloadAddBodyPart0101(): Unit {
        var multipartPayload01=MultipartPayload()
        var multipartPayload02=MultipartPayload("boundary")
        multipartPayload01.addBodyPart(multipartPayload02)
        @Assert(multipartPayload01.getBodyParts().size,1)

    }
}