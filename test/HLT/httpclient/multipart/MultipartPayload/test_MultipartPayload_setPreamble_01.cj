// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../../common_Values.cj

@Test
public class TestMultipartPayloadB005{
    /***
        public func setPreamble(preamble: String): Unit
        测试场景:单次、多次设置
    ***/
    @TestCase
    func testMultipartPayloadSetPreamble01(): Unit {
        var multipartPayload01=MultipartPayload()
        multipartPayload01.setPreamble("Preamble")
        @Assert(multipartPayload01.getPreamble(),"Preamble")
        multipartPayload01.setPreamble("Preamble02")
        @Assert(multipartPayload01.getPreamble(),"Preamble02")

        var multipartPayload02=MultipartPayload("boundary")
        multipartPayload02.setPreamble("Preamble")
        @Assert(multipartPayload02.getPreamble(),"Preamble")
        multipartPayload02.setPreamble("Preamble02")
        @Assert(multipartPayload02.getPreamble(),"Preamble02")

        var multipartPayload03=MultipartPayload("subtype","boundary")
        multipartPayload03.setPreamble("Preamble")
        @Assert(multipartPayload03.getPreamble(),"Preamble")
        multipartPayload03.setPreamble("Preamble02")
        @Assert(multipartPayload03.getPreamble(),"Preamble02")

        var multipartPayload04=MultipartPayload(HashMap<String,String>())
        multipartPayload04.setPreamble("Preamble")
        @Assert(multipartPayload04.getPreamble(),"Preamble")
        multipartPayload04.setPreamble("Preamble02")
        @Assert(multipartPayload04.getPreamble(),"Preamble02")

        var multipartPayload05=MultipartPayload("boundary",HashMap<String,String>())
        multipartPayload05.setPreamble("Preamble")
        @Assert(multipartPayload05.getPreamble(),"Preamble")
        multipartPayload05.setPreamble("Preamble02")
        @Assert(multipartPayload05.getPreamble(),"Preamble02")

        var multipartPayload06=MultipartPayload("subtype","boundary",HashMap<String,String>())
        multipartPayload06.setPreamble("Preamble")
        @Assert(multipartPayload06.getPreamble(),"Preamble")
        multipartPayload06.setPreamble("Preamble02")
        @Assert(multipartPayload06.getPreamble(),"Preamble02")
    }
}