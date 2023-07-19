// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestHMACSha1SignatureServiceB004{
    /***
        public func getSignatureMethod(): String
        测试场景:均返回HMAC-SHA1
    ***/
    @TestCase
    func testHMACSha1SignatureServiceGetSignatureMethod01(): Unit {
        let hsss=HMACSha1SignatureService()
        let re=hsss.getSignatureMethod()
        @Assert(re,"HMAC-SHA1")
    }
}