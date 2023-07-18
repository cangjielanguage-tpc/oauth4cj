// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj

@Test
public class TestServiceBuilderB004{
    /***
        public func setDefaultScope(scopeBuilder: ScopeBuilder): ServiceBuilderOAuth20
        测试场景:验证字符串是否为空-否
    ***/
    @TestCase
    func testServiceBuildersetDefaultScope0202(): Unit {
        var scopeBuilder=ScopeBuilder("abc")
        var serviceBuilder=ServiceBuilderOAuth20("abc")
        var re=serviceBuilder.setDefaultScope(scopeBuilder)
        @Assert(re is ServiceBuilderOAuth20,true)
    }
}