// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj


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
        }catch(e:IllegalArgumentException){
            if(e.toString().contains("IllegalArgumentException: Cannot get String from a empty ScopeBuilder")){
                flag=0
            }
        }
        @Assert(flag,0)
    }
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
    /***
        public func withScope(scope: String): ScopeBuilder
        public func build(): String
        测试场景:加入已存在字符串scope
    ***/
    @TestCase
    func testScopeBuilderWithScope0102(): Unit {
        let str="scope01"
        var scopeBuilder01=ScopeBuilder()
        scopeBuilder01.withScope(str)
        scopeBuilder01.withScope(str)
        @Assert(scopeBuilder01.build(),str)

        var scopeBuilder02=ScopeBuilder("scope01")
        scopeBuilder02.withScope(str)
        @Assert(scopeBuilder02.build(),str)

        var scopeBuilder03=ScopeBuilder(Array<String>(["scope01"]))
        scopeBuilder03.withScope(str)
        @Assert(scopeBuilder03.build(),str)

        var scopeBuilder04=ScopeBuilder(ArrayList<String>(["scope01"]))
        scopeBuilder04.withScope(str)
        @Assert(scopeBuilder04.build(),str)
    }
    /***
        public func withScopes(scopes: Array<String>): ScopeBuilder
        public func build(): String
        测试场景:数组中存在已有元素和新元素
    ***/
    @TestCase
    func testScopeBuilderWithScope0201(): Unit {
        let values=Array<String>(["abc","eee"])
        let origin="abc"

        var scopeBuilder01=ScopeBuilder()
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

public func getResult(arrs:Collection<String>):String{
    var temp=""
    for (arr in arrs){
        temp=temp+" "+arr
    }
    //return temp.substring(1)
    return temp[1..temp.size]
}