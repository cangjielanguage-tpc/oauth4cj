// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../../common_Values.cj

@Test
public class TestMultipartPayloadB005{
    /***
        public func getHeaders(): HashMap<String, String>
        public init(boundary: String)
        测试场景:调用父类方法,确保传给父类的值准确
    ***/
    @TestCase
    func testMultipartPayloadGetHeaders02(): Unit {
        var multipartPayload02=MultipartPayload("boundary")
        var re=multipartPayload02.getHeaders()
        var header_value="multipart/" + "form-data"+"; boundary=\"" + multipartPayload02.getBoundary() + '"';
        var header_map=HashMap<String,String>([("Content-Type",header_value)])
        @Assert(re,header_map)
    }
}