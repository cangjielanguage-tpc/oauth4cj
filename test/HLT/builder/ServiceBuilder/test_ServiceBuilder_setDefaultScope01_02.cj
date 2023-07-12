// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj

@Test
public class TestServiceBuilderB004{
    /***
        public func setDefaultScope(defaultScope: String): ServiceBuilderOAuth20
        测试场景:验证字符串是否为空-否
    ***/
    @TestCase
    func testServiceBuildersetDefaultScope0102(): Unit {
        var serviceBuilder01=ServiceBuilderOAuth20("abc")
        var re=serviceBuilder01.setDefaultScope("str")
        @Assert(re is ServiceBuilderOAuth20,true)
    }
}