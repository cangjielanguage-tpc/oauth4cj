// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj

@Test
public class TestServiceBuilderB004{
    /***
        public func setResponseType(responseType: String): ServiceBuilderOAuth20
        测试场景:验证字符串是否为空-是
    ***/
    @TestCase
    func testServiceBuildersetResponseType01(): Unit {
        var serviceBuilder01=ServiceBuilderOAuth20("abc")
        var flag=1
        try{
            serviceBuilder01.setResponseType("")
        }catch(e:IllegalArgumentException){
            if(e.toString().contains("Invalid OAuth responseType")){
                flag=0
            }
        }
        @Assert(flag,0)
        flag=1
        try{
            serviceBuilder01.setResponseType("   ")
        }catch(e:IllegalArgumentException){
            if(e.toString().contains("Invalid OAuth responseType")){
                flag=0
            }
        }
        @Assert(flag,0)
    }
}