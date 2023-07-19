// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestDefaultApi10aB004{
    /***
        public func getAccessTokenEndpoint(): String
        测试场景:返回子类实现
    ***/
    @TestCase
    func testDefaultApi10aGetAccessTokenEndpoint01(): Unit {
        var subDefaultApi10a=SubDefaultApi10a()
        let accessTokenEndpoint=subDefaultApi10a.getAccessTokenEndpoint()
        @Assert(accessTokenEndpoint,"accessTokenEndpoint_DefaultApi10a")
    }
}
