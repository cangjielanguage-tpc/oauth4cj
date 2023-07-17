// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestOAuth4cjRequestB005{
    /***
        public func setBodyPartPayloadInMultipartPayload(bodyPartPayload: BodyPartPayload): Unit
        单次/多次设置
    ***/
    @TestCase
    func testOAuth4cjRequestSetBodyPartPayloadInMultipartPayload01(): Unit {
        var oauth4cjRequest01=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        var mult: MultipartPayload
        try {
            mult=oauth4cjRequest01.getMultipartPayload().getOrThrow()
        } catch (e: Exception) {
            println(e)
            oauth4cjRequest01.initMultipartPayload()
            mult=oauth4cjRequest01.getMultipartPayload().getOrThrow()
        }
        var boundary=mult.getBoundary()
        @Assert(boundary.contains("----OAuth4cj----"),true)
        @Assert(mult.getBodyParts().size,0)


        var bodyPartPayload01=BodyPartPayload()
        oauth4cjRequest01.setBodyPartPayloadInMultipartPayload(bodyPartPayload01)
        mult=oauth4cjRequest01.getMultipartPayload().getOrThrow()
        @Assert(mult.getBodyParts().size,1)

        oauth4cjRequest01.setBodyPartPayloadInMultipartPayload(bodyPartPayload01)
        mult=oauth4cjRequest01.getMultipartPayload().getOrThrow()
        @Assert(mult.getBodyParts().size,1)
    }
}