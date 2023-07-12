// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj


@Test
public class TestDeviceAuthorizationB001{
    //单次,多次设置
    @TestCase
    func testSetIntervalSeconds01(): Unit {
        var intervalSecondsValues=Array<Int32>([Int32.Max,Int32.Min,0,Int32.Max-1,Int32.Min+1])
        var device01=DeviceAuthorization("deviceCode","userCode","verificationUri",123)
        for (j in intervalSecondsValues){
            device01.setIntervalSeconds(j)
            @Assert(device01.getIntervalSeconds(),j)
        }
    }
}