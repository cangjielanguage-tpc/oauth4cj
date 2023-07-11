// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj


@Test
public class TestDefaultApi20B004{
    /***
        public func getDeviceAuthorizationEndpoint(): String
        测试场景:未被重写，抛异常
    ***/
    @TestCase
    func testDefaultApi20GetDeviceAuthorizationExtractor01(): Unit {
        var subDefaultApi20=SubDefaultApi20()
        var flag=1
        try{
            subDefaultApi20.getDeviceAuthorizationEndpoint()
        }catch(e:Exception){
            if(e.toString().contains("This API doesn't support Device Authorization Grant or we have no info about this")){
                flag=0
            }
        }
        @Assert(flag,0)
    }
}
