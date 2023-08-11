// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj

@Test
public class TestOAuth1SignatureTypeB004{
    /***
        public func toString():String
        测试场景:构造器默认
    ***/
    @TestCase
    func testOAuth1SignatureTypeToString01(): Unit {
        var signatureType01=OAuth1SignatureType.HEADER_SIGNATURE
        var signatureType02=OAuth1SignatureType.QUERY_STRING_SIGNATURE
        @Assert(signatureType01.toString(),"HEADER")
        @Assert(signatureType02.toString(),"QUERY_STRING")
    }
}