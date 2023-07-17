// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestScopeBuilderB004{
    /***
        public func withScope(scope: String): ScopeBuilder
        public func build(): String
        测试场景:加入不存在字符串scope
    ***/
    @TestCase
    func testScopeBuilderWithScope0101(): Unit {
        let str="scope01"
        var scopeBuilder01=ScopeBuilder()
        scopeBuilder01.withScope(str)
        @Assert(scopeBuilder01.build(),str)

        var scopeBuilder02=ScopeBuilder("")
        scopeBuilder02.withScope(str)
        @Assert(scopeBuilder02.build()," "+str)

        var scopeBuilder03=ScopeBuilder(Array<String>())
        scopeBuilder03.withScope(str)
        @Assert(scopeBuilder03.build(),str)

        var scopeBuilder04=ScopeBuilder(ArrayList<String>())
        scopeBuilder04.withScope(str)
        @Assert(scopeBuilder04.build(),str)
    }
}