// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestDeviceAuthorizationB001{
    //重置
    @TestCase
    func testSetVerificationUriComplete01(): Unit {
        var device01=DeviceAuthorization("deviceCode","userCode","verificationUri",123)
        for (j in ((strValues.size-1)..0:-1)){
            device01.setVerificationUriComplete(j.toString())
            @Assert(device01.getVerificationUriComplete(),j.toString())
        }
    }
}