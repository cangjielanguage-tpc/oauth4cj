// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp

from std import unittest.*
from std import unittest.testmacro.*
from std import collection.*
from oauth4cj import httpclient.multipart.*
@Test
public class TestMultipartPayloadB005{
    /***
        public func getBoundary(): String
        测试场景:默认构造器调用
    ***/
    @TestCase
    func testMultipartPayloadAddBodyPart0101(): Unit {
        var multipartPayload01=MultipartPayload()
        @Assert(multipartPayload01.getBoundary().contains("----OAuth4cj----"),true)

        var multipartPayload02=MultipartPayload("boundary")
        @Assert(multipartPayload02.getBoundary(),"boundary")

        var multipartPayload03=MultipartPayload("subtype","boundary")
        @Assert(multipartPayload03.getBoundary(),"boundary")

        var multipartPayload04=MultipartPayload(HashMap<String,String>())
        @Assert(multipartPayload04.getBoundary().contains("----OAuth4cj----"),true)

        var multipartPayload0401=MultipartPayload(HashMap<String,String>([("Content-Type","; boundary=\"?(1111)\"")]))
        @Assert(multipartPayload0401.getBoundary(),"?(1111)")

        var multipartPayload05=MultipartPayload("boundary",HashMap<String,String>())
        @Assert(multipartPayload05.getBoundary(),"boundary")

        var multipartPayload06=MultipartPayload("subtype","boundary",HashMap<String,String>())
        @Assert(multipartPayload06.getBoundary(),"boundary")

        var multipartPayload0601=MultipartPayload("subtype","boundary",HashMap<String,String>([("key02","value02")]))
        @Assert(multipartPayload0601.getBoundary(),"boundary")

    }
}