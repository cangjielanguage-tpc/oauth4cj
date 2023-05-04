// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from encoding import base64.*
from std import collection.*
from oauth4cj import model.*
from oauth4cj import utils.*
from std import random.*
@Test
public class TestDeviceAuthorizationV001{
    //多次重置
    @TestCase
    func testSetVerificationUriComplete02(): Unit {
        var device01=DeviceAuthorization("deviceCode","userCode","verificationUri",123)
        var random01=Random()
        for (i in strValues){
            device01=DeviceAuthorization(i,i,i,random01.nextInt64())
            for (j in ((strValues.size-1)..0:-1)){
                device01.setVerificationUriComplete(j.toString())
                @Assert(device01.getVerificationUriComplete(),j.toString())
            }
        }
    }
}