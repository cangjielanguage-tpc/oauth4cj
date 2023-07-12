// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj


@Test
public class TestDeviceAuthorizationB001{
    //空,非空
    @TestCase
    func testGetUserCode01(): Unit {
        var device01=DeviceAuthorization("deviceCode","userCode","verificationUri",123)
        @Assert(device01.getUserCode(),"userCode")
        device01=DeviceAuthorization("deviceCode","","verificationUri",123)
        @Assert(device01.getUserCode(),"")
    }
}