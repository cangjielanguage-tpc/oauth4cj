// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestOAuth4cjRequestB005{
    /***
        public func initMultipartPayload(subtype: String, boundary: String): Unit
    ***/
    @TestCase
    func testOAuth4cjRequestInitMultipartPayload0301(): Unit {
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        var str="11111111111"
        oauth4cjRequest.initMultipartPayload(str,str)
        var multi=oauth4cjRequest.getMultipartPayload().getOrThrow()
        var boundary=multi.getBoundary()
        @Assert(boundary,str)
        var re=multi.getHeaders()
        var header_value="multipart/" + str+"; boundary=\"" + multi.getBoundary() + '"';
        var header_map=HashMap<String,String>([("Content-Type",header_value)])
        @Assert(re,header_map)
    }
}