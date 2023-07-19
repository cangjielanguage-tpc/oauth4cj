// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestOAuth4cjRequestB001{
    @TestCase
    func testOAuth4cjRequestsetPayload0201(): Unit {
        var arr01=Array<UInt8>()
        var arr02=Array<UInt8>(10000,item:0)
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        oauth4cjRequest.setPayload(arr01)
        @Assert(oauth4cjRequest.getByteArrayPayload(),arr01)
        oauth4cjRequest.setPayload(arr02)
        @Assert(oauth4cjRequest.getByteArrayPayload(),arr02)

    }
}