// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj

@Test
public class TestServiceBuilderB004{
    /***
        public func withScope(scope: String): ServiceBuilderOAuth10a
        测试场景:验证字符串是否为空-否
    ***/
    @TestCase
    func testServiceBuilderwithScope02(): Unit {
        var serviceBuilder01=ServiceBuilderOAuth10a("abc")
        var subDefaultApi10a=SubDefaultApi10a()
        var re=serviceBuilder01.withScope("str")
        @Assert(re is ServiceBuilderOAuth10a,true)//scope值无法验证待后续版本交付
    }
}