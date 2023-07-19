// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestOAuth4cjRequestB005{
    /***
        public func initMultipartPayload(subtype: String, boundary: String, headers: HashMap<String, String>): Unit
    ***/
    @TestCase
    func testOAuth4cjRequestInitMultipartPayload0601(): Unit {
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        var str="222222222"
        var hashmap01=HashMap<String, String>()
        var hashmap02=HashMap<String, String>([("key01","value01"),("key02","value02")])
        oauth4cjRequest.initMultipartPayload(str,str,hashmap01)
        oauth4cjRequest.initMultipartPayload(str,str,hashmap02)
        var multi=oauth4cjRequest.getMultipartPayload().getOrThrow()
        var re=multi.getHeaders()
        var header_value="multipart/" + str+"; boundary=\"" + multi.getBoundary() + '"';
        var header_map=hashmap02
        header_map.put("Content-Type",header_value)
        @Assert(re,header_map)
    }
}