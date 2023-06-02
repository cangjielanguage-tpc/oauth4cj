// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import model.*

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