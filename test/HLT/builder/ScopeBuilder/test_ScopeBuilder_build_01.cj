// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestScopeBuilderB004{
    /***
        public func build(): String
        测试场景:构造器默认-空参
    ***/
    @TestCase
    func testScopeBuilderBuild01(): Unit {
        var scopeBuilder01=ScopeBuilder()
        var flag=1
        try{
            scopeBuilder01.build()
        }catch(e:IndexOutOfBoundsException){
            flag=0
        }
        @Assert(flag,0)
    }
}