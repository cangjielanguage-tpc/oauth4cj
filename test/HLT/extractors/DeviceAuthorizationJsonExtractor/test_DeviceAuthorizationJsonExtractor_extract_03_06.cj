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
        测试场景:response的Code是200-body不包含device_code,user_code,verification_uri,expires_in,interval,verification_uri_complete中一个
        场景：不包含verification_uri_complete,且expires_in,interval不能转化为整数
    ***/
    @TestCase
    func testDeviceAuthorizationJsonExtractorExtract0306(): Unit {
        var deviceAuthorizationJsonExtractor02=DeviceAuthorizationJsonExtractor.instance()
        var body=###"{
"device_code":"device_code",
"user_code":"user_code",
"verification_uri":"verification_uri",
"expires_in":"expires_in",
"interval":"interval"}"###
        var response01=Response(Int32(200),"message",HashMap<String,String>(),body)
        var re02=deviceAuthorizationJsonExtractor02.extract(response01)

        @Assert(re02.getDeviceCode(),"device_code")
        @Assert(re02.getUserCode(),"user_code")
        @Assert(re02.getVerificationUri(),"verification_uri")
        @Assert(re02.getVerificationUriComplete(),"")
        @Assert(re02.getExpiresInSeconds(),0)
        @Assert(re02.getIntervalSeconds(),5)

    }
}