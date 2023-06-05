// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp

from std import unittest.*
from std import unittest.testmacro.*
from std import collection.*
from oauth4cj import httpclient.multipart.*

@Test
public class TestBodyPartPayloadB005{
    /***
        public func getHeaders(): HashMap<String, String>
        测试场景:返回header，根据调用源返回
    ***/
    @TestCase
    func testBodyPartPayloadGetHeaders01(): Unit {
        var bodypayload01=BodyPartPayload()
        var contentType="contentType"
        var bodypayload02=BodyPartPayload(contentType)
        var map01=HashMap<String,String>([("token","token_value"),("token02","token_value02")])
        var bodypayload03=BodyPartPayload(map01)
        var re01=bodypayload01.getHeaders()
        var re02=bodypayload02.getHeaders()
        var re03=bodypayload03.getHeaders()
        @Assert(re01.size,0)
        @Assert(re02.size,1)
        @Assert(re02.get("Content-Type"),contentType)
        @Assert(re03.size,2)
        @Assert(re03.get("token"),"token_value")
        @Assert(re03.get("token02"),"token_value02")

    }
}