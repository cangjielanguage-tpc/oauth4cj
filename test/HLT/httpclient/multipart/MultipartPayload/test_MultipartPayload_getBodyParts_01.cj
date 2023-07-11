// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../../common_Values.cj

@Test
public class TestMultipartPayloadB005{
    /***
        public func getBodyParts(): ArrayList<BodyPartPayload>
        测试场景:默认构造器调用
    ***/
    @TestCase
    func testMultipartPayloadAddBodyPart0101(): Unit {
        var multipartPayload01=MultipartPayload()
        var multipartPayload02=MultipartPayload("boundary")
        var multipartPayload03=MultipartPayload("subtype","boundary")
        var multipartPayload04=MultipartPayload(HashMap<String,String>())
        var multipartPayload05=MultipartPayload("boundary",HashMap<String,String>())
        var multipartPayload06=MultipartPayload("subtype","boundary",HashMap<String,String>())
        @Assert(multipartPayload01.getBodyParts().size,0)
        @Assert(multipartPayload02.getBodyParts().size,0)
        @Assert(multipartPayload03.getBodyParts().size,0)
        @Assert(multipartPayload04.getBodyParts().size,0)
        @Assert(multipartPayload05.getBodyParts().size,0)
        @Assert(multipartPayload06.getBodyParts().size,0)
    }
}