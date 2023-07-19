// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


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