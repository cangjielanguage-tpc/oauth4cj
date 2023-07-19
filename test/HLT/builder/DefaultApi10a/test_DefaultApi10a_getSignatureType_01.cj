// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestDefaultApi10aB004{
    /***
        public func getSignatureType(): OAuth1SignatureType
        测试场景:能生成OAuth1SignatureType即可
    ***/
    @TestCase
    func testDefaultApi10aGetSignatureType01(): Unit {
        var subDefaultApi10a=SubDefaultApi10a()
        let signatureType=subDefaultApi10a.getSignatureType()
        @Assert(signatureType.toString(),"HEADER")
    }
}
