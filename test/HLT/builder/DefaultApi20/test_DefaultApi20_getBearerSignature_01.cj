// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import builder.*
from oauth4cj import oauth2.bearersignature.*

@Test
public class TestDefaultApi20B004{
    /***
        public func getBearerSignature(): BearerSignature
        测试场景:能生成BearerSignature即可
    ***/
    @TestCase
    func testDefaultApi20GetBearerSignature01(): Unit {
        var subDefaultApi20=SubDefaultApi20()
        let bearerSignature=subDefaultApi20.getBearerSignature()
        @Assert(bearerSignature is BearerSignatureAuthorizationRequestHeaderField,true)
        @Assert(bearerSignature is BearerSignature,true)
    }
}
