// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestDeviceAuthorizationB001{
    //验证Int64特殊值
    @TestCase
    func testGetExpiresInSeconds01(): Unit {
        var device01=DeviceAuthorization("deviceCode","userCode","verificationUri",123)
        for(j in int64Values){
            device01=DeviceAuthorization("deviceCode","userCode","verificationUri",j)
            @Assert(device01.getExpiresInSeconds(),j)
        }
    }
}