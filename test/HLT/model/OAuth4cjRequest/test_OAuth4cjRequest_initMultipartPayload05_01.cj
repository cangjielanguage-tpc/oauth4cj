// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestOAuth4cjRequestB005{
    /***
        public func initMultipartPayload(boundary: String, headers: HashMap<String, String>): Unit
    ***/
    @TestCase
    func testOAuth4cjRequestInitMultipartPayload0501(): Unit {
        var oauth4cjRequest01=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        var hashmap01=HashMap<String, String>()
        var hashmap02=HashMap<String, String>([("key01","value01"),("key02","value02")])
        var str="111111111"
        oauth4cjRequest01.initMultipartPayload(str,hashmap01)
        oauth4cjRequest01.initMultipartPayload(str,hashmap02)
        var multi=oauth4cjRequest01.getMultipartPayload().getOrThrow()
        var re=multi.getHeaders()
        var header_value="multipart/" + "form-data"+"; boundary=\"" + multi.getBoundary() + '"';
        var header_map=hashmap02
        header_map.put("Content-Type",header_value)
        @Assert(re,header_map)
    }
}