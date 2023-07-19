// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestServiceBuilderB004{
    /***
        public func build(api: DefaultApi10a): OAuth10aService
        测试场景:验证返回确认是OAuth10aService
    ***/
    @TestCase
    func testServiceBuilderBuild0101(): Unit {
        var serviceBuilder=ServiceBuilderOAuth10a("abc")
        var subDefaultApi10a=SubDefaultApi10a()
        let oauth10aService=serviceBuilder.build(subDefaultApi10a)
       // @Assert(oauth10aService.getVersion(),"1.0")
        @Assert(oauth10aService is OAuth10aService,true)
    }
}