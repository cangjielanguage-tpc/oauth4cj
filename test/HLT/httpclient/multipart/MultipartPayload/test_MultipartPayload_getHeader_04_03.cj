// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../../common_Values.cj

@Test
public class TestMultipartPayloadB005{
    /***
        public func getHeaders(): HashMap<String, String>
        public init(headers: HashMap<String, String>)
        测试场景:调用父类方法,确保传给父类的值准确--hashMap非空，且key包含Content-Type
    ***/
    @TestCase
    func testMultipartPayloadGetHeaders0403(): Unit {
        var map01=HashMap<String,String>([("key01","value01"),("Content-Type","Content-Type")])
        var multipartPayload04=MultipartPayload(map01)
        var re=multipartPayload04.getHeaders()
        var header_value="Content-Type"+"; boundary=\"" + multipartPayload04.getBoundary() + '"'
        var header_map=map01
        header_map.put("Content-Type",header_value)
        @Assert(re,header_map)
    }
}