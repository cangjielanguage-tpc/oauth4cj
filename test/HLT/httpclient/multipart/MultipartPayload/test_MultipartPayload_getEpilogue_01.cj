// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../../common_Values.cj

@Test
public class TestMultipartPayloadB005{
    /***
        public func getEpilogue(): String
        测试场景:默认构造器调用
    ***/
    @TestCase
    func testMultipartPayloadGetEpilogue01(): Unit {
        var multipartPayload01=MultipartPayload()
        @Assert(multipartPayload01.getEpilogue(),"")

        var multipartPayload02=MultipartPayload("boundary")
        @Assert(multipartPayload02.getEpilogue(),"")

        var multipartPayload03=MultipartPayload("subtype","boundary")
        @Assert(multipartPayload03.getEpilogue(),"")

        var multipartPayload04=MultipartPayload(HashMap<String,String>())
        @Assert(multipartPayload04.getEpilogue(),"")

        var multipartPayload05=MultipartPayload("boundary",HashMap<String,String>())
        @Assert(multipartPayload05.getEpilogue(),"")

        var multipartPayload06=MultipartPayload("subtype","boundary",HashMap<String,String>())
        @Assert(multipartPayload06.getEpilogue(),"")
    }
}