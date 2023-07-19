// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../../common_Values.cj

@Test
public class TestMultipartUtilsB005{
    /***
        public static func getPayload(multipartPayload: MultipartPayload): ByteArrayStream
        测试场景:返回值准确-bodypart为空
    ***/
    @TestCase
    func testMultipartUtilsGetPayload01(): Unit {
        var  header=HashMap<String,String>([("key01","value01")])
        var  multipartPayload=MultipartPayload("subtype","boundary",header)
        var  payload=MultipartUtils.getPayload(multipartPayload)
        var  re=payload.readToEnd()
        payload=getExpByteArrayStream(multipartPayload)
        var  exp_re=payload.readToEnd()
        @Assert(exp_re,re)
    }
}