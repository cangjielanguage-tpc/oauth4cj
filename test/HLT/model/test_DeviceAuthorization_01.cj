// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj

@Test
public class TestDeviceAuthorizationB001{
    //初始化空/非空
    @TestCase
    func testGetDeviceCode01(): Unit {
        var device01=DeviceAuthorization("deviceCode","userCode","verificationUri",123)
        @Assert(device01.getDeviceCode(),"deviceCode")
        device01=DeviceAuthorization("","userCode","userCode",345)
        @Assert(device01.getDeviceCode(),"")
    }
    //验证Int64特殊值
    @TestCase
    func testGetExpiresInSeconds01(): Unit {
        var device01=DeviceAuthorization("deviceCode","userCode","verificationUri",123)
        for (j in int64Values){
            if (j < 0){
                var flag = 0
                try {
                    device01=DeviceAuthorization("deviceCode","userCode","verificationUri",j)
                } catch (e: OAuth4cjException) {
                    if(e.toString().contains("The validity time of the verification code cannot be negative")){
                        flag=1
                    }
                }
                @Assert(flag,1)
            } else {
                device01=DeviceAuthorization("deviceCode","userCode","verificationUri",j)
                @Assert(device01.getExpiresInSeconds(),j)
            }
        }
    }
    //默认构造器
    @TestCase
    func testGetIntervalSeconds01(): Unit {
        var device01=DeviceAuthorization("deviceCode","userCode","verificationUri",123)
        @Assert(device01.getIntervalSeconds(),5)
    }
    //空,非空
    @TestCase
    func testGetUserCode01(): Unit {
        var device01=DeviceAuthorization("deviceCode","userCode","verificationUri",123)
        @Assert(device01.getUserCode(),"userCode")
        device01=DeviceAuthorization("deviceCode","","verificationUri",123)
        @Assert(device01.getUserCode(),"")
    }
    //与构造器一致
    @TestCase
    func testGetVerificationUri01(): Unit {
        var device01=DeviceAuthorization("deviceCode","userCode","verificationUri",123)
        @Assert(device01.getVerificationUri(),"verificationUri")
        device01=DeviceAuthorization("deviceCode","userCode","",123)
        @Assert(device01.getVerificationUri(),"")
    }
    //重置
    @TestCase
    func testGetVerificationUriComplete01(): Unit {
        var device01=DeviceAuthorization("deviceCode","userCode","verificationUri",123)
        @Assert(device01.getVerificationUriComplete(),"")
    }
    //单次,多次设置
    @TestCase
    func testSetIntervalSeconds01(): Unit {
        var intervalSecondsValues=Array<Int32>([Int32.Max,Int32.Min,0,Int32.Max-1,Int32.Min+1])
        var device01=DeviceAuthorization("deviceCode","userCode","verificationUri",123)
        for (j in intervalSecondsValues){
            if (j < 0){
                var flag = 0
                try {
                    device01.setIntervalSeconds(j)
                } catch (e: OAuth4cjException) {
                    if(e.toString().contains("The time value cannot be negative")){
                        flag=1
                    }
                }
                @Assert(flag,1)
            } else {
                device01.setIntervalSeconds(j)
                @Assert(device01.getIntervalSeconds(),j)
            }

        }
    }
    //重置
    @TestCase
    func testSetVerificationUriComplete01(): Unit {
        var device01=DeviceAuthorization("deviceCode","userCode","verificationUri",123)
        for (j in ((strValues.size-1)..0:-1)){
            device01.setVerificationUriComplete(j.toString())
            @Assert(device01.getVerificationUriComplete(),j.toString())
        }
    }
    //默认
    @TestCase
    func testToString01(): Unit {
        var device01=DeviceAuthorization("deviceCode","userCode","verificationUri",123)
        var random01=Random()
        var exp_toString=""
        for (i in strValues){
            var nextNum = random01.nextInt64()
            if (nextNum >= 0){
                device01=DeviceAuthorization(i,i,i,nextNum)
                exp_toString="DeviceAuthorization{'deviceCode'='${device01.getDeviceCode()}','userCode'='${device01.getUserCode()}','verificationUri'='${device01.getVerificationUri()}','verificationUriComplete'='${device01.getVerificationUriComplete()}','expiresInSeconds'='${device01.getExpiresInSeconds().toString()}','intervalSeconds'='${device01.getIntervalSeconds().toString()}'}"
                @Assert(device01.toString(),exp_toString)
            }
        }
    }
    //重置
    @TestCase
    func testToString02(): Unit {
        var device01=DeviceAuthorization("deviceCode","userCode","verificationUri",123)
        var random01=Random()
        var exp_toString=""
        for (i in strValues){
            var nextNum = random01.nextInt64()
            if (nextNum < 0){
                var flag = 0
                try {
                    device01=DeviceAuthorization(i,i,i,nextNum)
                } catch (e: OAuth4cjException) {
                    if(e.toString().contains("The validity time of the verification code cannot be negative")){
                        flag=1
                    }
                }
                @Assert(flag,1)
            } else {
                device01=DeviceAuthorization(i,i,i,nextNum)
                device01.setVerificationUriComplete("eweqwewq")
                device01.setIntervalSeconds(Int32(3423))
                exp_toString="DeviceAuthorization{'deviceCode'='${device01.getDeviceCode()}','userCode'='${device01.getUserCode()}','verificationUri'='${device01.getVerificationUri()}','verificationUriComplete'='${device01.getVerificationUriComplete()}','expiresInSeconds'='${device01.getExpiresInSeconds().toString()}','intervalSeconds'='${device01.getIntervalSeconds().toString()}'}"
                @Assert(device01.toString(),exp_toString)
            }
        }
    }
}