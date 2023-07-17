// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestServiceBuilderB004{
    /***
        public func setHttpClient(httpClient: ?HttpClient): ServiceBuilder
        测试场景:验证字符串是Option<OAuth4cjHttpClient>.None
    ***/
    @TestCase
    func testServiceBuildersetHttpClient01(): Unit {
        var serviceBuilder01=ServiceBuilderOAuth10a("abc")
        var httpclient=Option<OAuth4cjHttpClient>.None
        serviceBuilder01.setHttpClient(httpclient)
        //结果暂时验证不了，待OAuthService类交付

        var serviceBuilder02=ServiceBuilderOAuth20("abc")
        var httpclient02=Option<OAuth4cjHttpClient>.None
        serviceBuilder02.setHttpClient(httpclient02)
    }
}