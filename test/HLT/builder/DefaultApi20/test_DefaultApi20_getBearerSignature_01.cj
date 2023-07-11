// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj


@Test
public class TestDefaultApi20B004{
    /***
        public func getBearerSignature(): BearerSignature
        测试场景:能生成BearerSignature即可
    ***/
    @TestCase
    func testDefaultApi20GetBearerSignature01(): Unit {
        var subDefaultApi20=SubDefaultApi20()
        let bearerSignature=subDefaultApi20.getBearerSignature()
        @Assert(bearerSignature is BearerSignatureAuthorizationRequestHeaderField,true)
        @Assert(bearerSignature is BearerSignature,true)
    }
}
