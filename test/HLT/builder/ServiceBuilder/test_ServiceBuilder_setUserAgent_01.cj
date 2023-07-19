// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj

@Test
public class TestServiceBuilderB004{
    /***
        public func setUserAgent(userAgent: String): ServiceBuilder
        测试场景:字符串角度,只能验证正常调用，暂时无法验证结果，需要流程通过后从功能角度验证
    ***/
    @TestCase
    func testServiceBuilderSetApiKey01(): Unit {
        var serviceBuilder01=ServiceBuilderOAuth10a("abc")
        serviceBuilder01.setUserAgent("")

        var serviceBuilder02=ServiceBuilderOAuth20("abc")
        serviceBuilder02.setUserAgent("")
    }
}