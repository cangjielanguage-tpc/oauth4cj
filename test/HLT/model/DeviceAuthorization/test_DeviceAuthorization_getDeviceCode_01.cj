// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import model.*
from std import random.*

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
}