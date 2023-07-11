// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj

@Test
public class TestServiceBuilderB004{
    /***
        public func setDefaultScope(scopeBuilder: ScopeBuilder): ServiceBuilderOAuth20
        测试场景:验证字符串是否为空-是
    ***/
    @TestCase
    func testServiceBuildersetDefaultScope0201(): Unit {
        var serviceBuilder=ServiceBuilderOAuth20("abc")
        var scopeBuilder=ScopeBuilder()
        var flag=1
        try{
            serviceBuilder.setDefaultScope(scopeBuilder)
        }catch(e:IndexOutOfBoundsException){
            flag=0
        }
        @Assert(flag,0)
    }
}