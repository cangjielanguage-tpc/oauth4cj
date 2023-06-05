// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp

from std import unittest.*
from std import unittest.testmacro.*
from std import collection.*
from oauth4cj import httpclient.multipart.*
@Test
public class TestMultipartPayloadB005{
    /***
        public func getHeaders(): HashMap<String, String>
        public init()
        测试场景:调用父类方法,确保传给父类的值准确--
    ***/
    @TestCase
    func testMultipartPayloadGetHeaders01(): Unit {
        var multipartPayload01=MultipartPayload()
        var re=multipartPayload01.getHeaders()
        var header_value="multipart/" + "form-data"+"; boundary=\"" + multipartPayload01.getBoundary() + '"';
        var header_map=HashMap<String,String>([("Content-Type",header_value)])
        @Assert(re,header_map)
    }
}