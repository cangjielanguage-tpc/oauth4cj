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
        public func extract(response: Response): DeviceAuthorization
        测试场景:response的Code是200-body不包含device_code,user_code,verification_uri,expires_in,interval,verification_uri_complete中一个
        场景：不包含verification_uri
    ***/
    @TestCase
    func testDeviceAuthorizationJsonExtractorExtract0303(): Unit {
        var deviceAuthorizationJsonExtractor02=DeviceAuthorizationJsonExtractor.instance()
        var body=###"{
"device_code":"device_code",
"user_code":"user_code",
"expires_in":"expires_in",
"interval":"interval",
"verification_uri_complete":"verification_uri_complete"}"###
        var response01=Response(Int32(200),"message",HashMap<String,String>(),body)
        var flag=1
        try{
            deviceAuthorizationJsonExtractor02.extract(response01)
        }catch(e:OAuth4cjException){
            if(e.toString().contains("Response body is incorrect. Can't extract")){
                flag=0
            }

        }

    }
}