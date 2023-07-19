// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj

@Test
public class TestDeviceAuthorizationJsonExtractorB004{
    /***
        public func extract(response: Response): DeviceAuthorization
        测试场景:response的Code是200-body不包含device_code,user_code,verification_uri,expires_in,interval,verification_uri_complete中一个
        场景：不包含expires_in
    ***/
    @TestCase
    func testDeviceAuthorizationJsonExtractorExtract0304(): Unit {
        var deviceAuthorizationJsonExtractor02=DeviceAuthorizationJsonExtractor.instance()
        var body=###"{
"device_code":"device_code",
"user_code":"user_code",
"verification_uri":"verification_uri",
"interval":0,
"verification_uri_complete":"verification_uri_complete"}"###
        var response01=oauth4cj.model.Response(Int32(200),"message",HashMap<String,String>(),body)
        var flag=1
        try{
            deviceAuthorizationJsonExtractor02.extract(response01)
        }catch(e:OAuth4cjException){
            if(e.toString().contains("Response body is incorrect. Can't extract")){
                flag=0
            }

        }
    }
}