// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../../common_Values.cj

@Test
public class TestMultipartUtilsB005{
    /***
        public static func getPayload(multipartPayload: MultipartPayload): ByteArrayStream
        测试场景:返回值准确-bodypart为MultipartPayload
    ***/
    @TestCase
    func testMultipartUtilsGetPayload03(): Unit {
        var header=HashMap<String,String>([("key01","value01")])
        var multipartPayload=MultipartPayload("subtype","boundary",header)
        var multipartPayload01=MultipartPayload()
        var multipartPayload02=MultipartPayload("boundary01")
        var multipartPayload03=MultipartPayload("subtype","boundary02")
        var map01=HashMap<String,String>([("Content-Type","; boundary=\"?(1111)\"")])
        var multipartPayload04=MultipartPayload(map01)
        var multipartPayload05=MultipartPayload("?(1111)",map01)
        var multipartPayload06=MultipartPayload("subtype","?(1111)",map01)


        multipartPayload.addBodyPart(multipartPayload01)
        multipartPayload.addBodyPart(multipartPayload02)
        multipartPayload.addBodyPart(multipartPayload03)
        multipartPayload.addBodyPart(multipartPayload04)
        multipartPayload.addBodyPart(multipartPayload05)
        multipartPayload.addBodyPart(multipartPayload06)
        var  payload=MultipartUtils.getPayload(multipartPayload)
        var  re=payload.readToEnd()
        payload=getExpByteArrayStream(multipartPayload)
        var  exp_re=payload.readToEnd()
        @Assert(exp_re,re)
    }
}

