// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../../common_Values.cj

@Test
public class TestMultipartPayloadB005{
    /***
        public func getHeaders(): HashMap<String, String>
        public init(subtype: String, boundary: String, headers: HashMap<String, String>)
        测试场景:调用父类方法,确保传给父类的值准确
    ***/
    @TestCase
    func testMultipartPayloadGetHeaders06(): Unit {
        var multipartPayload06=MultipartPayload("subtype","boundary",HashMap<String,String>())
        var re=multipartPayload06.getHeaders()
        var header_value="multipart/" + "subtype"+"; boundary=\"" + multipartPayload06.getBoundary() + '"';
        var header_map=HashMap<String,String>([("Content-Type",header_value)])
        @Assert(re,header_map)
    }
}