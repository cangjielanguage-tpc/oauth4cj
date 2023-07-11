// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj

@Test
public class TestServiceBuilderB004{
    /***
        public init(apiKey: String)
        测试场景:字符串是否是空白字符串-是
    ***/
    @TestCase
    func testServiceBuilderInit01(): Unit {
        var serviceBuilder01=ServiceBuilderOAuth10a("abc")
        var flag=1
        try{
            serviceBuilder01=ServiceBuilderOAuth10a("")
        }catch(e:IllegalArgumentException){
            if(e.toString().contains("Invalid Api key")){
                flag=0
            }
        }
        @Assert(flag,0)
        flag=1
        try{
            serviceBuilder01=ServiceBuilderOAuth10a("   ")
        }catch(e:IllegalArgumentException){
            if(e.toString().contains("Invalid Api key")){
                flag=0
            }
        }
        @Assert(flag,0)

        var serviceBuilder02=ServiceBuilderOAuth20("abc")
        var flag02=1
        try{
            serviceBuilder02=ServiceBuilderOAuth20("")
        }catch(e:IllegalArgumentException){
            if(e.toString().contains("Invalid Api key")){
                flag02=0
            }
        }
        @Assert(flag02,0)
        flag02=1
        try{
            serviceBuilder02=ServiceBuilderOAuth20("   ")
        }catch(e:IllegalArgumentException){
            if(e.toString().contains("Invalid Api key")){
                flag02=0
            }
        }
        @Assert(flag02,0)
    }
}