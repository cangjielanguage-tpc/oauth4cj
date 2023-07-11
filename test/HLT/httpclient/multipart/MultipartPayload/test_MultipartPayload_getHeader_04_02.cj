// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../../common_Values.cj

@Test
public class TestMultipartPayloadB005{
    /***
        public func getHeaders(): HashMap<String, String>
        public init(headers: HashMap<String, String>)
        测试场景:调用父类方法,确保传给父类的值准确--hashMap非空，但key不包含Content-Type
    ***/
    @TestCase
    func testMultipartPayloadGetHeaders0402(): Unit {
        var map01=HashMap<String,String>([("key01","value01"),("key02","value02")])
        var multipartPayload04=MultipartPayload(map01)
        var re=multipartPayload04.getHeaders()
        var header_value="multipart/" + "form-data"+"; boundary=\"" + multipartPayload04.getBoundary() + '"';
        var header_map=map01
        header_map.put("Content-Type",header_value)
        @Assert(re,header_map)
    }
}