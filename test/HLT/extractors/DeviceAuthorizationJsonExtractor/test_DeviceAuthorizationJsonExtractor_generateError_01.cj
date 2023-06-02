// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import model.*
from oauth4cj import extractors.*
from oauth4cj import exceptions.*
from std import collection.*
@Test
public class TestDeviceAuthorizationJsonExtractorB004{
    /***
        public func generateError(response: Response): Unit
        测试场景:正常调用
    ***/
    @TestCase
    func testDeviceAuthorizationJsonExtractorGenerateError01(): Unit {
        var deviceAuthorizationJsonExtractor02=DeviceAuthorizationJsonExtractor.instance()
        var response01=Response(Int32(2),"message",HashMap<String,String>(),"")
        var flag=0
        try{
            deviceAuthorizationJsonExtractor02.generateError(response01)
        }catch(e:OAuth2AccessTokenErrorResponse){
            flag=1
        }
        @Assert(flag,1)
    }
}