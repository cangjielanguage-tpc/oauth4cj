// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj

@Test
public class TestServiceBuilderB004{
    /***
        public func setCallback(callback: String): ServiceBuilder
        测试场景:无设置逻辑,设置成功即可
    ***/
    @TestCase
    func testServiceBuilderSetCallback01(): Unit {
        var serviceBuilder01 = ServiceBuilderOAuth10a("abc")
        var subDefaultApi10a=SubDefaultApi10a()
        serviceBuilder01.setCallback("str")
        let oauth10aService=serviceBuilder01.build(subDefaultApi10a)
        @Assert(oauth10aService.getCallback(),"str")

        var serviceBuilder02=ServiceBuilderOAuth20("abc")
        var subDefaultApi20=SubDefaultApi20()
        serviceBuilder02.setCallback("str")
        let oAuth20Service=serviceBuilder02.build(subDefaultApi20)
        @Assert(oAuth20Service.getCallback(),"str")
    }
}