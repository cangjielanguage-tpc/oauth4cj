// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestScopeBuilderB004{
    /***
        public func build(): String
        测试场景:构造器默认-非空参
    ***/
    @TestCase
    func testScopeBuilderBuild02(): Unit {
        let origin02="abc"
        var scopeBuilder02=ScopeBuilder(origin02)
        @Assert(scopeBuilder02.build(),origin02)

        let origin03=Array<String>(["a","b","c","d","e","f","g"])
        var scopeBuilder03=ScopeBuilder(origin03)
        @Assert(scopeBuilder03.build(),getResult(origin03))

        let origin04=Array<String>(["h","i","j","k","l","m","n"])
        var scopeBuilder04=ScopeBuilder(origin04)
        @Assert(scopeBuilder04.build(),getResult(origin04))
    }
}

public func getResult(arrs:Collection<String>):String{
    var temp=""
    for (arr in arrs){
        temp=temp+" "+arr
    }
    return temp.substring(1)
}