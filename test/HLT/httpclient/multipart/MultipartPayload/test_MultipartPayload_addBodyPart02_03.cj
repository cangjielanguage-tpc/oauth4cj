// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../../common_Values.cj

@Test
public class TestMultipartPayloadB005{
    /***
        public func addBodyPart(multipartPayload: MultipartPayload): Unit
        测试场景:多次添加
    ***/
    @TestCase
    func testMultipartPayloadAddBodyPart0203(): Unit {
        var multipartPayload01=MultipartPayload()
        var multipartPayload02=MultipartPayload("boundary01")
        var multipartPayload03=MultipartPayload("boundary02")
        var multipartPayload04=MultipartPayload("boundary03")
        multipartPayload01.addBodyPart(multipartPayload02)
        multipartPayload01.addBodyPart(multipartPayload03)
        multipartPayload01.addBodyPart(multipartPayload04)
        @Assert(multipartPayload01.getBodyParts().size,3)

    }
}