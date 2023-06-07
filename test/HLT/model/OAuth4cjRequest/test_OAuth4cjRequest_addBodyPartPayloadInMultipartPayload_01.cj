// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import model.*
from oauth4cj import httpclient.multipart.*

@Test
public class TestOAuth4cjRequestB005{
    /***
        单次/多次添加，显示追加本次后的结果
    ***/
    @TestCase
    func testOAuth4cjRequestAddBodyPartPayloadInMultipartPayload01(): Unit {
        var oauth4cjRequest01=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        var bodyPartPayload01=BodyPartPayload()
        oauth4cjRequest01.addBodyPartPayloadInMultipartPayload(bodyPartPayload01)
        var bodyparts=oauth4cjRequest01.getMultipartPayload().getOrThrow().getBodyParts()
        @Assert(bodyparts.size,1)

        oauth4cjRequest01.addBodyPartPayloadInMultipartPayload(bodyPartPayload01)
        var mult=oauth4cjRequest01.getMultipartPayload().getOrThrow()
        @Assert(mult.getBodyParts().size,2)
    }
}