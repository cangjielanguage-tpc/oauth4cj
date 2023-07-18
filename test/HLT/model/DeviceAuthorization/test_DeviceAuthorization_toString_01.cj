// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestDeviceAuthorizationB001{
    //默认
    @TestCase
    func testGetDeviceCode01(): Unit {
        var device01=DeviceAuthorization("deviceCode","userCode","verificationUri",123)
        var random01=Random()
        var exp_toString=""
        for (i in strValues){
            device01=DeviceAuthorization(i,i,i,random01.nextInt64())
		    exp_toString="DeviceAuthorization{'deviceCode'='${device01.getDeviceCode()}','userCode'='${device01.getUserCode()}','verificationUri'='${device01.getVerificationUri()}','verificationUriComplete'='${device01.getVerificationUriComplete()}','expiresInSeconds'='${device01.getExpiresInSeconds().toString()}','intervalSeconds'='${device01.getIntervalSeconds().toString()}'}"
			@Assert(device01.toString(),exp_toString)
        }
    }
}