// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj

@Test
public class TestDeviceAuthorizationJsonExtractorB004{
    /***
        public func extract(response: Response): DeviceAuthorization
        测试场景:response的Code不是200-抛异常
    ***/
    @TestCase
    func testDeviceAuthorizationJsonExtractorExtract01(): Unit {
        var deviceAuthorizationJsonExtractor=DeviceAuthorizationJsonExtractor.instance()
        var response=oauth4cj.model.Response(Int32(2),"message",HashMap<String,String>(),"")
        var flag=0
        try{
            deviceAuthorizationJsonExtractor.extract(response)
        }catch(e:OAuth2AccessTokenErrorResponse){
            flag=1
        }
        @Assert(flag,1)
    }
}