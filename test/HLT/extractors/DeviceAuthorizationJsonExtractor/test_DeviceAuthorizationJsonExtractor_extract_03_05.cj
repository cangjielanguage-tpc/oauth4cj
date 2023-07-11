// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj

@Test
public class TestDeviceAuthorizationJsonExtractorB004{
    /***
        public func extract(response: Response): DeviceAuthorization
        测试场景:response的Code是200-body不包含device_code,user_code,verification_uri,expires_in,interval,verification_uri_complete中一个
        场景：不包含interval
    ***/
    @TestCase
    func testDeviceAuthorizationJsonExtractorExtract0305(): Unit {
        var deviceAuthorizationJsonExtractor02=DeviceAuthorizationJsonExtractor.instance()
        var body=###"{
"device_code":"device_code",
"user_code":"user_code",
"verification_uri":"verification_uri",
"expires_in":0,
"verification_uri_complete":"verification_uri_complete"}"###
        var response01=oauth4cj.model.Response(Int32(200),"message",HashMap<String,String>(),body)
        var re02=deviceAuthorizationJsonExtractor02.extract(response01)

        @Assert(re02.getDeviceCode(),"device_code")
        @Assert(re02.getUserCode(),"user_code")
        @Assert(re02.getVerificationUri(),"verification_uri")
        @Assert(re02.getVerificationUriComplete(),"verification_uri_complete")
        @Assert(re02.getExpiresInSeconds(),0)
        @Assert(re02.getIntervalSeconds(),5)

    }
}