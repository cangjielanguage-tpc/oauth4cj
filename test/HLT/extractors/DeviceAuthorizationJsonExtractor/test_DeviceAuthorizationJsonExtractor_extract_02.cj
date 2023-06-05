// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import model.*
from oauth4cj import extractors.*
from std import collection.*
@Test
public class TestDeviceAuthorizationJsonExtractorB004{
    /***
        public func extract(response: Response): DeviceAuthorization
        测试场景:response的Code是200-body包含device_code,user_code,verification_uri,expires_in,interval,verification_uri_complete
    ***/
    @TestCase
    func testDeviceAuthorizationJsonExtractorExtract02(): Unit {

        var deviceAuthorizationJsonExtractor=DeviceAuthorizationJsonExtractor.instance()
        var body=###"{
"device_code":"device_code",
"user_code":"user_code",
"verification_uri":"verification_uri",
"expires_in":5,
"interval":12,
"verification_uri_complete":"verification_uri_complete"}"###
        var response=Response(Int32(200),"message",HashMap<String,String>(),body)
        var re02=deviceAuthorizationJsonExtractor.extract(response)

        @Assert(re02.getDeviceCode(),"device_code")
        @Assert(re02.getUserCode(),"user_code")
        @Assert(re02.getVerificationUri(),"verification_uri")
        @Assert(re02.getVerificationUriComplete(),"verification_uri_complete")
        @Assert(re02.getExpiresInSeconds(),5)
        @Assert(re02.getIntervalSeconds(),12)

    }
}