// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import model.*
from oauth4cj import httpclient.multipart.*

@Test
public class TestOAuth4cjRequestB005{
    /***
        public func setBodyPartPayloadInMultipartPayload(bodyPartPayload: BodyPartPayload): Unit
        单次/多次设置
    ***/
    @TestCase
    func testOAuth4cjRequestSetBodyPartPayloadInMultipartPayload01(): Unit {
        var oauth4cjRequest01=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")

        var mult=oauth4cjRequest01.getMultipartPayload()
        var boundary=mult.getBoundary()
        @Assert(boundary.contains("----OAuth4cj----"),true)
        @Assert(mult.getBodyParts().size,0)


        var bodyPartPayload01=BodyPartPayload()
        oauth4cjRequest01.setBodyPartPayloadInMultipartPayload(bodyPartPayload01)
        mult=oauth4cjRequest01.getMultipartPayload()
        @Assert(mult.getBodyParts().size,1)

        oauth4cjRequest01.setBodyPartPayloadInMultipartPayload(bodyPartPayload01)
        mult=oauth4cjRequest01.getMultipartPayload()
        @Assert(mult.getBodyParts().size,1)
    }
}