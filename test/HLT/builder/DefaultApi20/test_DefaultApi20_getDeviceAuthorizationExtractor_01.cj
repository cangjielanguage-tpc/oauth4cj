// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import builder.*
from oauth4cj import extractors.*

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
