// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj


@Test
public class TestDefaultApi20B004{
    /***
        public func getDeviceAuthorizationExtractor(): DeviceAuthorizationJsonExtractor
        测试场景:能生成DeviceAuthorizationJsonExtractor即可
    ***/
    @TestCase
    func testDefaultApi20GetDeviceAuthorizationExtractor01(): Unit {
        var subDefaultApi20=SubDefaultApi20()
        let deviceAuthorization=subDefaultApi20.getDeviceAuthorizationExtractor()
        @Assert(deviceAuthorization is DeviceAuthorizationJsonExtractor,true)
    }
}
