// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestScopeBuilderB004{
    /***
        public func withScopes(scopes: Collection<String>): ScopeBuilder
        public func build(): String
        测试场景:序列中存在已有元素和新元素
    ***/
    @TestCase
    func testScopeBuilderWithScope0301(): Unit {
        var scopeBuilder01=ScopeBuilder()
        let values=Array<String>(["abc","eee"])
        let origin="abc"

        scopeBuilder01.withScopes(values)
        @Assert(scopeBuilder01.build(),"abc"+" "+"eee")

        var scopeBuilder02=ScopeBuilder(origin)
        scopeBuilder02.withScopes(values)
        @Assert(scopeBuilder02.build(),"abc"+" "+"eee")

        var scopeBuilder03=ScopeBuilder(Array<String>([origin]))
        scopeBuilder03.withScopes(values)
        @Assert(scopeBuilder03.build(),"abc"+" "+"eee")


        var scopeBuilder04=ScopeBuilder(ArrayList<String>([origin]))
        scopeBuilder04.withScopes(values)
        @Assert(scopeBuilder04.build(),"abc"+" "+"eee")
    }
}