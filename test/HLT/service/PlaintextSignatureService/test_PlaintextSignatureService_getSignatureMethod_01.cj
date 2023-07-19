// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestPlaintextSignatureServiceB004{
    /***
        public func getSignatureMethod(): String
        测试场景:均返回PLAINTEXT
    ***/
    @TestCase
    func testPlaintextSignatureServiceGetSignatureMethod01(): Unit {
        let plSS=PlaintextSignatureService()
        let re=plSS.getSignatureMethod()
        @Assert(re,"PLAINTEXT")
    }
}