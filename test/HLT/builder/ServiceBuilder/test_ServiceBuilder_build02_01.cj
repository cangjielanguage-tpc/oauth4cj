// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj

@Test
public class TestServiceBuilderB004{
    /***
        public func build(api: DefaultApi20): OAuth20Service
        测试场景:验证返回确认是OAuth20Service
    ***/
    @TestCase
    func testServiceBuilderBuild0201(): Unit {
        var serviceBuilder=ServiceBuilderOAuth20("abc")
        var subDefaultApi20=SubDefaultApi20()
        let oauth20Service=serviceBuilder.build(subDefaultApi20)
        //@Assert(oauth20Service.getVersion(),"2.0")
        @Assert(oauth20Service is OAuth20Service,true)
    }
}