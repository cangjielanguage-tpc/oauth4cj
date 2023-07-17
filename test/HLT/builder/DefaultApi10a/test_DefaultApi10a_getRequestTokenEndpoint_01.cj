// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestDefaultApi10aB004{
    /***
        public func getRequestTokenEndpoint(): String
        测试场景:返回子类实现
    ***/
    @TestCase
    func testDefaultApi10aGetRequestTokenEndpoint01(): Unit {
        var subDefaultApi10a=SubDefaultApi10a()
        let requestTokenEndpoint=subDefaultApi10a.getRequestTokenEndpoint()
        @Assert(requestTokenEndpoint,"requestTokenEndpoint_DefaultApi10a")
    }
}
