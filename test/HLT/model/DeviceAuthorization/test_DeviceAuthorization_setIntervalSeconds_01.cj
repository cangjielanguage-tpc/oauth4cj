// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from encoding import base64.*
from std import collection.*
from oauth4cj import model.*
from oauth4cj import utils.*
from std import random.*
from std import math.*
@Test
public class TestDeviceAuthorizationV001{
    //重置
    @TestCase
    func testSetIntervalSeconds01(): Unit {
        var intervalSecondsValues=Array<Int32>([Int32.Max,Int32.Min,0,Int32.Max-1,Int32.Min+1])
        var device01=DeviceAuthorization("deviceCode","userCode","verificationUri",123)
        var random01=Random()
        for (i in strValues){
            for (j in intervalSecondsValues){
                device01=DeviceAuthorization(i,i,i,random01.nextInt64())
                device01.setIntervalSeconds(j)
                @Assert(device01.getIntervalSeconds(),j)
            }
        }
    }
}