// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj


@Test
public class TestRSASha1SignatureServiceB004{
    /***
        public func getSignatureMethod(): String
        测试场景:均返回HMAC-SHA1
    ***/
    @TestCase
    func testRSASha1SignatureServiceGetSignatureMethod01(): Unit {
        let rsss=RSASha1SignatureService("")
        let re=rsss.getSignatureMethod()
        @Assert(re,"RSA-SHA1")
    }
}