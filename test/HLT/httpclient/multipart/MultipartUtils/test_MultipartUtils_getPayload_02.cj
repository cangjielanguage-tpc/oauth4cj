// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from std import collection.*
from oauth4cj import httpclient.multipart.*
@Test
public class TestMultipartUtilsB005{
    /***
        public static func getPayload(multipartPayload: MultipartPayload): ByteArrayStream
        测试场景:返回值准确-bodypart为ByteArrayBodyPartPayload
    ***/
    @TestCase
    func testMultipartUtilsGetPayload02(): Unit {
        var  headers=HashMap<String,String>([("headers","header_value")])
        var  multipartPayload=MultipartPayload("subtype","boundary",headers)

        var bodypayload01=ByteArrayBodyPartPayload(Array<UInt8>(10,item:0),1,1,headers)
        var bodypayload02=ByteArrayBodyPartPayload(Array<UInt8>(10,item:0),headers)
        var bodypayload03=ByteArrayBodyPartPayload(Array<UInt8>(10,item:0),"content-type")
        var bodypayload04=ByteArrayBodyPartPayload(Array<UInt8>(10,item:0),1,1,"content-type")
        var bodypayload05=ByteArrayBodyPartPayload(Array<UInt8>(10,item:0))
        var bodypayload06=ByteArrayBodyPartPayload(Array<UInt8>(10,item:0),1,1)

        multipartPayload.addBodyPart(bodypayload01)
        multipartPayload.addBodyPart(bodypayload02)
        multipartPayload.addBodyPart(bodypayload03)
        multipartPayload.addBodyPart(bodypayload04)
        multipartPayload.addBodyPart(bodypayload05)
        multipartPayload.addBodyPart(bodypayload06)

        var  payload=MultipartUtils.getPayload(multipartPayload)
        var  re=payload.readToEnd()
        payload=getExpByteArrayStream(multipartPayload)
        var  exp_re=payload.readToEnd()
        @Assert(exp_re,re)
    }
}